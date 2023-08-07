import 'package:flutter/widgets.dart';

/// Options to customize a [RulerPicker<T>].
class RulerScalePickerOptions {
  /// Creates the configuration for a [RulerPicker<T>].
  const RulerScalePickerOptions({
    this.isEnabled = true,
    this.orientation = Axis.horizontal,
    this.majorIndicatorInterval = 10,
    this.indicatorExtend = 10,
    this.showControls = true,
  })  : assert(
          indicatorExtend > 0,
          '[indicatorExtend] must be greater 0',
        ),
        assert(
          majorIndicatorInterval > 0,
          '[majorIndicatorInterval] must be greater 0',
        );

  /// Whether the widget should be enabled or not.
  final bool isEnabled;

  /// Declares the orientation.
  ///
  /// This can be either [Axis.horizontal] or [Axis.vertical].
  final Axis orientation;

  /// Declares after how many steps the value should be highlighted.
  final int majorIndicatorInterval;

  /// Declares the extend of the widgets used to represent a scale indicator.
  ///
  /// When [orientation] is [Axis.horizontal] this is the height of the widgets
  /// When [orientation] is [Axis.vertical] this is the width of the widgets.
  final double indicatorExtend;

  /// Whether controls should be shown.
  final bool showControls;
}
