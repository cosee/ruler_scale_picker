import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:ruler_scale_picker/ruler_scale_picker.dart';

/// Widget that displays the current value.
///
/// Used by [NumericRulerScalePicker] as default.
class RulerValueView extends StatelessWidget {
  /// Creates a value displaying widget.
  ///
  /// [maxLetterCount] is used to determine the maximal width used by [value].
  /// If [style] is null, [DefaultTextStyle] will be used.
  const RulerValueView({
    required this.maxLetterCount,
    required this.value,
    this.style,
    this.alignment = AlignmentDirectional.center,
    super.key,
  });

  /// The maximal amount of letters [value] can be.
  ///
  /// The length will not be enforced and can be exceeded by [value].
  final int maxLetterCount;

  /// The value to show.
  final String value;

  /// The [TextStyle] of the text.
  final TextStyle? style;

  /// The alignment of the text.
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: alignment,
      children: [
        Visibility(
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          visible: false,
          child: Text(
            'X' * maxLetterCount,
            style: style,
            maxLines: 1,
          ),
        ),
        Text(
          value,
          style: style,
          maxLines: 1,
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('maxLetterCount', maxLetterCount))
      ..add(StringProperty('value', value))
      ..add(DiagnosticsProperty<TextStyle?>('style', style))
      ..add(DiagnosticsProperty<AlignmentGeometry>('alignment', alignment));
  }
}
