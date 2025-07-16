import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ruler_scale_picker/src/controller/controller.dart';
import 'package:ruler_scale_picker/src/types.dart';
import 'package:ruler_scale_picker/src/widgets/ruler_area/latching_scroll_physics.dart';
import 'package:ruler_scale_picker/src/widgets/ruler_area/padded_scroll_controller.dart';
import 'package:ruler_scale_picker/src/widgets/ruler_area/scroll_area_semantics.dart';

/// A scrollable widget styled like a ruler.
class RulerScrollArea<T> extends StatefulWidget {
  /// Creates a [RulerScrollArea] of type [T].
  const RulerScrollArea({
    required this.rulerController,
    required this.majorIndicatorInterval,
    required this.indicatorExtend,
    required this.orientation,
    required this.indicatorBuilder,
    super.key,
  }) : assert(
         indicatorExtend > 0,
         '[indicatorExtend] must be greater 0',
       );

  /// A controller to handle value changes.
  final RulerScalePickerController<T> rulerController;

  /// Declares after how many steps the value should be highlighted.
  final int majorIndicatorInterval;

  /// Declares the extend of the widgets used to represent a scale indicator.
  ///
  /// When [orientation] is [Axis.horizontal] this is the height of the widgets
  /// When [orientation] is [Axis.vertical] this is the width of the widgets.
  final double indicatorExtend;

  /// Declares the orientation.
  ///
  /// This can be either [Axis.horizontal] or [Axis.vertical].
  final Axis orientation;

  /// The function used to build the widget that represents the value
  /// on the scale.
  final ScaleIndicatorBuilder<T> indicatorBuilder;

  @override
  State<RulerScrollArea<T>> createState() => _RulerScrollAreaState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DiagnosticsProperty<RulerScalePickerController<T>>(
          'rulerController',
          rulerController,
        ),
      )
      ..add(IntProperty('majorIndicatorInterval', majorIndicatorInterval))
      ..add(DoubleProperty('indicatorExtend', indicatorExtend))
      ..add(EnumProperty<Axis>('orientation', orientation))
      ..add(
        ObjectFlagProperty<ScaleIndicatorBuilder<T>>.has(
          'indicatorBuilder',
          indicatorBuilder,
        ),
      );
  }
}

class _RulerScrollAreaState<T> extends State<RulerScrollArea<T>> {
  late ScrollController _scrollController;
  bool _userIsScrolling = false;
  late double _scrollOffset;
  late int _lastHapticFeedbackIndex;
  late ValueKey<double> _listViewKey;

  @override
  void initState() {
    super.initState();
    _scrollOffset = widget.indicatorExtend / 2;
    _listViewKey = ValueKey(_scrollOffset);
    final index = widget.rulerController.index;
    _lastHapticFeedbackIndex = index;
    _scrollController = PaddedScrollController(
      padding: _scrollOffset,
      initialScrollOffset: _indexToOffset(index),
    )..addListener(_scrollPositionChangeHandler);
    widget.rulerController.addListener(_valueChangeHandler);
  }

  @override
  void didUpdateWidget(RulerScrollArea<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.indicatorExtend != widget.indicatorExtend) {
      _scrollOffset = widget.indicatorExtend / 2;
      _listViewKey = ValueKey(_scrollOffset);
      final index = oldWidget.rulerController.index;
      _lastHapticFeedbackIndex = index;
      _scrollController
        ..removeListener(_scrollPositionChangeHandler)
        ..dispose();
      _scrollController = PaddedScrollController(
        padding: _scrollOffset,
        initialScrollOffset: _indexToOffset(index),
      )..addListener(_scrollPositionChangeHandler);
      oldWidget.rulerController.removeListener(_valueChangeHandler);
      widget.rulerController.addListener(_valueChangeHandler);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RulerScrollAreaSemantics<T>(
      rulerController: widget.rulerController,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              scrollbars: false,
              overscroll: false,
            ),
            child: ListView.builder(
              key: _listViewKey,
              physics: LatchingScrollPhysics(widget.indicatorExtend),
              padding: _getPadding(widget.orientation, constraints),
              itemExtent: widget.indicatorExtend,
              itemCount: widget.rulerController.length,
              controller: _scrollController,
              scrollDirection: widget.orientation,
              itemBuilder: (context, index) {
                final bool isMajorIndicator = _checkIfMajorIndicator(
                  index,
                  widget.majorIndicatorInterval,
                );
                return widget.indicatorBuilder.call(
                  context,
                  widget.orientation == Axis.horizontal
                      ? Axis.vertical
                      : Axis.horizontal,
                  widget.rulerController.getValueAt(index),
                  isMajorIndicator: isMajorIndicator,
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_scrollPositionChangeHandler)
      ..dispose();
    widget.rulerController.removeListener(_valueChangeHandler);
    super.dispose();
  }

  void _scrollPositionChangeHandler() {
    _userIsScrolling = true;
    final index = _offsetToIndex(_scrollController.offset);
    if (index != widget.rulerController.index) {
      widget.rulerController.setValue(
        widget.rulerController.getValueAt(index),
      );
      _hapticFeedback();
    }
    _userIsScrolling = false;
  }

  void _valueChangeHandler() {
    if (!_userIsScrolling) {
      _jumpToIndex(widget.rulerController.index);
    }
  }

  EdgeInsets _getPadding(Axis axis, BoxConstraints constraints) {
    switch (axis) {
      case (Axis.horizontal):
        return EdgeInsets.only(
          left: constraints.maxWidth / 2,
          right: constraints.maxWidth / 2,
        );
      case (Axis.vertical):
        return EdgeInsets.only(
          top: constraints.maxHeight / 2,
          bottom: constraints.maxHeight / 2,
        );
    }
  }

  double _indexToOffset(int index) =>
      index * widget.indicatorExtend + _scrollOffset;

  int _offsetToIndex(double offset) {
    final index = offset ~/ widget.indicatorExtend;
    if (index < 0) {
      return 0;
    } else if (index > widget.rulerController.length - 1) {
      return widget.rulerController.length - 1;
    } else {
      return index;
    }
  }

  void _jumpToIndex(int index) {
    final double position = _indexToOffset(index);
    _scrollController.jumpTo(position);
  }

  bool _checkIfMajorIndicator(int index, int majorIndicatorInterval) =>
      index % majorIndicatorInterval == 0;

  void _hapticFeedback() {
    if ((!kIsWeb && Platform.isIOS) &&
        _lastHapticFeedbackIndex != widget.rulerController.index) {
      _lastHapticFeedbackIndex = widget.rulerController.index;
      unawaited(HapticFeedback.selectionClick());
    }
  }
}
