import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ruler_scale_picker/ruler_scale_picker.dart';

/// The default scale marker used by [NumericRulerScalePicker].
class RulerScaleMarker extends StatelessWidget {
  /// Creates a scale marker.
  const RulerScaleMarker({
    required this.orientation,
    super.key,
  });

  /// The orientation of the indicator.
  final Axis orientation;

  @override
  Widget build(BuildContext context) {
    return orientation == Axis.horizontal
        ? const _RulerScaleMarkerHorizontal()
        : const _RulerScaleMarkerVertical();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<Axis>('orientation', orientation));
  }
}

class _RulerScaleMarkerHorizontal extends StatelessWidget {
  const _RulerScaleMarkerHorizontal();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 120,
      height: 3,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.red,
        ),
      ),
    );
  }
}

class _RulerScaleMarkerVertical extends StatelessWidget {
  const _RulerScaleMarkerVertical();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 3,
      height: 120,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.red,
        ),
      ),
    );
  }
}
