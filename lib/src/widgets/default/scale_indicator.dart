import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ruler_scale_picker/ruler_scale_picker.dart';

/// The default scale indicator used by [NumericRulerScalePicker].
class RulerScaleIndicator extends StatelessWidget {
  /// Creates a scale indicator.
  ///
  /// [isMajorIndicator] creates a longer version.

  /// Creates a scale marker.
  const RulerScaleIndicator({
    required this.orientation,
    required this.value,
    required this.isMajorIndicator,
    this.color,
    super.key,
  });

  /// The orientation of the indicator.
  final Axis orientation;

  /// The value displayed by the indicator.
  final String value;

  /// Whether it is a major indicator or not.
  ///
  /// Major indicators are displayed more prominently.
  final bool isMajorIndicator;

  /// The color of the indicator.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? Theme.of(context).colorScheme.secondary;
    return orientation == Axis.horizontal
        ? _RulerScaleIndicatorHorizontal(
            value: value,
            isMajorIndicator: isMajorIndicator,
            color: color,
          )
        : _RulerScaleIndicatorVertical(
            value: value,
            isMajorIndicator: isMajorIndicator,
            color: color,
          );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<Axis>('orientation', orientation))
      ..add(StringProperty('value', value))
      ..add(DiagnosticsProperty<bool>('isMajorIndicator', isMajorIndicator))
      ..add(ColorProperty('color', color));
  }
}

class _RulerScaleIndicatorHorizontal extends StatelessWidget {
  const _RulerScaleIndicatorHorizontal({
    required this.value,
    required this.isMajorIndicator,
    required this.color,
  });

  final String value;
  final bool isMajorIndicator;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isMajorIndicator) _Invisible(child: _TextHorizontal(text: value)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: _IndicatorHorizontal(
            isMajorIndicator: isMajorIndicator,
            color: color,
          ),
        ),
        if (isMajorIndicator) _TextHorizontal(text: value),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('value', value))
      ..add(DiagnosticsProperty<bool>('isMajorIndicator', isMajorIndicator))
      ..add(ColorProperty('color', color));
  }
}

class _RulerScaleIndicatorVertical extends StatelessWidget {
  const _RulerScaleIndicatorVertical({
    required this.value,
    required this.isMajorIndicator,
    required this.color,
  });

  final String value;
  final bool isMajorIndicator;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: _IndicatorVertical(
            isMajorIndicator: isMajorIndicator,
            color: color,
          ),
        ),
        _TextVertical(
          text: isMajorIndicator ? value : '',
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('value', value))
      ..add(DiagnosticsProperty<bool>('isMajorIndicator', isMajorIndicator))
      ..add(ColorProperty('color', color));
  }
}

class _IndicatorHorizontal extends StatelessWidget {
  const _IndicatorHorizontal({
    required this.isMajorIndicator,
    required this.color,
  });

  final bool isMajorIndicator;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isMajorIndicator ? 40 : 25,
      height: 3,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: color,
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('isMajorIndicator', isMajorIndicator))
      ..add(ColorProperty('color', color));
  }
}

class _IndicatorVertical extends StatelessWidget {
  const _IndicatorVertical({
    required this.isMajorIndicator,
    required this.color,
  });

  final bool isMajorIndicator;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: 3,
          height: isMajorIndicator ? 40 : 25,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              color: color,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('isMajorIndicator', isMajorIndicator))
      ..add(ColorProperty('color', color));
  }
}

class _TextHorizontal extends StatelessWidget {
  const _TextHorizontal({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    // TODO find a solution to avoid IntrinsicWidth
    return IntrinsicWidth(
      child: OverflowBox(
        maxHeight: double.infinity,
        child: Text(
          text,
          maxLines: 1,
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('text', text));
  }
}

class _TextVertical extends StatelessWidget {
  const _TextVertical({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    // TODO find a solution to avoid IntrinsicHeight
    return IntrinsicHeight(
      child: OverflowBox(
        maxWidth: double.infinity,
        child: Text(
          text,
          maxLines: 1,
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('text', text));
  }
}

class _Invisible extends StatelessWidget {
  const _Invisible({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      visible: false,
      child: child,
    );
  }
}
