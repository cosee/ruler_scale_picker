import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ruler_scale_picker/src/controller/controller.dart';
import 'package:ruler_scale_picker/src/types.dart';
import 'package:ruler_scale_picker/src/widgets/ruler_area/scroll_area.dart';

/// A widget styled like a ruler with a marking over the ruler.
class RulerArea<T> extends StatelessWidget {
  /// Creates a [RulerArea] of type [T].
  const RulerArea({
    required this.rulerController,
    required this.majorIndicatorInterval,
    required this.indicatorExtend,
    required this.orientation,
    required this.indicatorBuilder,
    required this.scaleMarkerBuilder,
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

  /// The function used to build the widget that marks the current value
  /// on the scale.
  final ScaleMarkerBuilder scaleMarkerBuilder;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RulerScrollArea<T>(
          rulerController: rulerController,
          indicatorBuilder: indicatorBuilder,
          majorIndicatorInterval: majorIndicatorInterval,
          indicatorExtend: indicatorExtend,
          orientation: orientation,
        ),
        IgnorePointer(
          child: Center(
            child: scaleMarkerBuilder.call(
              context,
              orientation == Axis.horizontal ? Axis.vertical : Axis.horizontal,
            ),
          ),
        ),
      ],
    );
  }

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
      )
      ..add(
        ObjectFlagProperty<ScaleMarkerBuilder>.has(
          'scaleMarkerBuilder',
          scaleMarkerBuilder,
        ),
      );
  }
}
