import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ruler_scale_picker/ruler_scale_picker.dart';

/// The default button used by [NumericRulerScalePicker].
class RulerButton extends StatelessWidget {
  /// Creates a Button for [NumericRulerScalePicker].
  const RulerButton({
    required this.onPressed,
    required this.icon,
    super.key,
  });

  /// Called when the button is tapped.
  final VoidCallback onPressed;

  /// Icon to use
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: null,
      onPressed: onPressed,
      mini: true,
      child: Icon(
        icon,
        size: 30,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<VoidCallback>.has('onPressed', onPressed))
      ..add(DiagnosticsProperty<IconData>('icon', icon));
  }
}
