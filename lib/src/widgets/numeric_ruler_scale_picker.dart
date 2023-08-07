import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ruler_scale_picker/src/controller/controller.dart';
import 'package:ruler_scale_picker/src/controller/numeric_controller.dart';
import 'package:ruler_scale_picker/src/options.dart';
import 'package:ruler_scale_picker/src/types.dart';
import 'package:ruler_scale_picker/src/widgets/default/button.dart';
import 'package:ruler_scale_picker/src/widgets/default/scale_indicator.dart';
import 'package:ruler_scale_picker/src/widgets/default/scale_marker.dart';
import 'package:ruler_scale_picker/src/widgets/default/value_view.dart';
import 'package:ruler_scale_picker/src/widgets/ruler_scale_picker.dart';

/// A picker widget styled like a ruler with [int] values.
base class NumericRulerScalePicker extends StatefulWidget {
  /// Creates a [NumericRulerScalePicker].
  const NumericRulerScalePicker({
    super.key,
    this.options,
    this.controller,
    this.increaseButtonBuilder,
    this.decreaseButtonBuilder,
    this.valueDisplayBuilder,
    this.scaleMarkerBuilder,
    this.scaleIndicatorBuilder,
  });

  /// Options to customize the RulerScalePicker.
  final RulerScalePickerOptions? options;

  /// A controller to handle value changes.
  final RulerScalePickerController<int>? controller;

  /// The function used to build the increase button.
  final ActionButtonBuilder? increaseButtonBuilder;

  /// The function used to build the decrease button.
  final ActionButtonBuilder? decreaseButtonBuilder;

  /// The function used to build the widget that displays the current value.
  final ValueDisplayBuilder<int>? valueDisplayBuilder;

  /// The function used to build the widget that marks the current value
  /// on the scale.
  final ScaleMarkerBuilder? scaleMarkerBuilder;

  /// The function used to build the widget that represents the current value
  /// on the scale.
  final ScaleIndicatorBuilder<int>? scaleIndicatorBuilder;

  @override
  State<NumericRulerScalePicker> createState() =>
      _NumericRulerScalePickerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<RulerScalePickerOptions?>('options', options))
      ..add(
        DiagnosticsProperty<RulerScalePickerController<int>?>(
          'controller',
          controller,
        ),
      )
      ..add(
        ObjectFlagProperty<ActionButtonBuilder?>.has(
          'increaseButtonBuilder',
          increaseButtonBuilder,
        ),
      )
      ..add(
        ObjectFlagProperty<ActionButtonBuilder?>.has(
          'decreaseButtonBuilder',
          decreaseButtonBuilder,
        ),
      )
      ..add(
        ObjectFlagProperty<ValueDisplayBuilder<int>?>.has(
          'valueDisplayBuilder',
          valueDisplayBuilder,
        ),
      )
      ..add(
        ObjectFlagProperty<ScaleMarkerBuilder?>.has(
          'scaleMarkerBuilder',
          scaleMarkerBuilder,
        ),
      )
      ..add(
        ObjectFlagProperty<ScaleIndicatorBuilder<int>?>.has(
          'scaleIndicatorBuilder',
          scaleIndicatorBuilder,
        ),
      );
  }
}

class _NumericRulerScalePickerState extends State<NumericRulerScalePicker> {
  late final RulerScalePickerOptions _rulerPickerOptions;
  late final RulerScalePickerController<int> _rulerPickerController;

  @override
  void initState() {
    _rulerPickerOptions = widget.options ?? const RulerScalePickerOptions();

    _rulerPickerController =
        widget.controller ?? NumericRulerScalePickerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RulerScalePicker<int>(
      controller: _rulerPickerController,
      options: _rulerPickerOptions,
      decreaseButtonBuilder:
          widget.decreaseButtonBuilder ?? _decreaseButtonBuilder,
      valueDisplayBuilder: widget.valueDisplayBuilder ?? _valueDisplayBuilder,
      scaleMarkerBuilder: widget.scaleMarkerBuilder ?? _scaleMarkerBuilder,
      scaleIndicatorBuilder:
          widget.scaleIndicatorBuilder ?? _scaleIndicatorBuilder,
      increaseButtonBuilder:
          widget.increaseButtonBuilder ?? _increaseButtonBuilder,
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _rulerPickerController.dispose();
    }
    super.dispose();
  }

  Widget _scaleIndicatorBuilder(
    _,
    Axis orientation,
    int value, {
    required bool isMajorIndicator,
  }) {
    return RulerScaleIndicator(
      orientation: orientation,
      value: value.toString(),
      isMajorIndicator: isMajorIndicator,
    );
  }

  Widget _scaleMarkerBuilder(_, Axis orientation) {
    return RulerScaleMarker(orientation: orientation);
  }

  Widget _valueDisplayBuilder(_, int value) {
    return RulerValueView(
      maxLetterCount: _neededPositions(
        _rulerPickerController.getValueAt(0),
        _rulerPickerController.getValueAt(_rulerPickerController.length - 1),
      ),
      value: value.toString(),
      style: const TextStyle(fontSize: 30),
    );
  }

  Widget _decreaseButtonBuilder(_, VoidCallback action) {
    return RulerButton(
      onPressed: action,
      icon: Icons.remove,
    );
  }

  Widget _increaseButtonBuilder(_, VoidCallback action) {
    return RulerButton(
      onPressed: action,
      icon: Icons.add,
    );
  }

  int _neededPositions(int minValue, int maxValue) {
    return max(_digitCount(minValue), _digitCount(maxValue));
  }

  int _digitCount(int number) {
    int remainder = number;
    int count = 1;
    while (remainder > 9 || remainder < -1) {
      count++;
      remainder ~/= 10;
    }
    return count;
  }
}
