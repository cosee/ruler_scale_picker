import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:ruler_scale_picker/src/types.dart';
import 'package:ruler_scale_picker/src/widgets/ruler_scale_picker.dart';

/// A widget used by [RulerScalePicker] to display buttons and current value.
class ControlArea<T> extends StatelessWidget {
  /// Creates a [ControlArea] for [RulerScalePicker].
  const ControlArea({
    required this.decrease,
    required this.increase,
    required this.value,
    required this.increaseButtonBuilder,
    required this.decreaseButtonBuilder,
    required this.valueDisplayBuilder,
    super.key,
  });

  /// The [VoidCallback] to be called if the value should decrease.
  final VoidCallback decrease;

  /// The [VoidCallback] to be called if the value should increase.
  final VoidCallback increase;

  /// The current to display.
  final T value;

  /// The function used to build the decrease button.
  final ActionButtonBuilder decreaseButtonBuilder;

  /// The function used to build the increase button.
  final ActionButtonBuilder increaseButtonBuilder;

  /// The function used to build the widget that displays the current value.
  final ValueDisplayBuilder<T> valueDisplayBuilder;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        decreaseButtonBuilder.call(context, decrease),
        valueDisplayBuilder.call(context, value),
        increaseButtonBuilder.call(context, increase),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<VoidCallback>.has('decrease', decrease))
      ..add(ObjectFlagProperty<VoidCallback>.has('increase', increase))
      ..add(DiagnosticsProperty<T>('value', value))
      ..add(
        ObjectFlagProperty<ActionButtonBuilder>.has(
          'decreaseButtonBuilder',
          decreaseButtonBuilder,
        ),
      )
      ..add(
        ObjectFlagProperty<ActionButtonBuilder>.has(
          'increaseButtonBuilder',
          increaseButtonBuilder,
        ),
      )
      ..add(
        ObjectFlagProperty<ValueDisplayBuilder<T>>.has(
          'valueDisplayBuilder',
          valueDisplayBuilder,
        ),
      );
  }
}
