import 'package:flutter/widgets.dart';

/// Signature for a function that creates a button for [RulerPicker<T>].
typedef ActionButtonBuilder = Widget Function(
  BuildContext context,
  VoidCallback action,
);

/// Signature for a function that creates a value display for [RulerPicker<T>].
typedef ValueDisplayBuilder<T> = Widget Function(
  BuildContext context,
  T value,
);

/// Signature for a function that creates a scale marker for [RulerPicker<T>].
typedef ScaleMarkerBuilder = Widget Function(
  BuildContext context,
  Axis orientation,
);

/// Signature for a function that creates a scale indicator
/// for [RulerPicker<T>].
typedef ScaleIndicatorBuilder<T> = Widget Function(
  BuildContext context,
  Axis orientation,
  T value, {
  required bool isMajorIndicator,
});
