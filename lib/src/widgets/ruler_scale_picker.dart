import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:ruler_scale_picker/src/controller/controller.dart';
import 'package:ruler_scale_picker/src/options.dart';
import 'package:ruler_scale_picker/src/types.dart';
import 'package:ruler_scale_picker/src/widgets/control_area/control_area.dart';
import 'package:ruler_scale_picker/src/widgets/ruler_area/ruler_area.dart';

/// A picker widget styled like a ruler.
class RulerScalePicker<T> extends StatelessWidget {
  /// Creates a [RulerScalePicker] of type [T].
  const RulerScalePicker({
    required this.controller,
    required this.options,
    required this.increaseButtonBuilder,
    required this.decreaseButtonBuilder,
    required this.valueDisplayBuilder,
    required this.scaleIndicatorBuilder,
    required this.scaleMarkerBuilder,
    super.key,
  });

  /// Options to customize the RulerScalePicker.
  final RulerScalePickerOptions options;

  /// A controller to handle value changes.
  final RulerScalePickerController<T> controller;

  /// The function used to build the increase button.
  final ActionButtonBuilder increaseButtonBuilder;

  /// The function used to build the decrease button.
  final ActionButtonBuilder decreaseButtonBuilder;

  /// The function used to build the widget that displays the current value.
  final ValueDisplayBuilder<T> valueDisplayBuilder;

  /// The function used to build the widget that marks the current value
  /// on the scale.
  final ScaleMarkerBuilder scaleMarkerBuilder;

  /// The function used to build the widget that represents the value
  /// on the scale.
  final ScaleIndicatorBuilder<T> scaleIndicatorBuilder;

  @override
  Widget build(BuildContext context) {
    return _Deactivated(
      deactivated: !options.isEnabled,
      child: ListenableBuilder(
        listenable: controller,
        builder: (_, __) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (options.showControls)
                ControlArea<T>(
                  decrease: controller.decrease,
                  increase: controller.increase,
                  value: controller.value,
                  decreaseButtonBuilder: decreaseButtonBuilder,
                  increaseButtonBuilder: increaseButtonBuilder,
                  valueDisplayBuilder: valueDisplayBuilder,
                ),
              Expanded(
                child: RulerArea<T>(
                  rulerController: controller,
                  indicatorBuilder: scaleIndicatorBuilder,
                  scaleMarkerBuilder: scaleMarkerBuilder,
                  majorIndicatorInterval: options.majorIndicatorInterval,
                  indicatorExtend: options.indicatorExtend,
                  orientation: options.orientation,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<RulerScalePickerOptions>('options', options))
      ..add(
        DiagnosticsProperty<RulerScalePickerController<T>>(
          'controller',
          controller,
        ),
      )
      ..add(
        ObjectFlagProperty<ActionButtonBuilder>.has(
          'increaseButtonBuilder',
          increaseButtonBuilder,
        ),
      )
      ..add(
        ObjectFlagProperty<ActionButtonBuilder>.has(
          'decreaseButtonBuilder',
          decreaseButtonBuilder,
        ),
      )
      ..add(
        ObjectFlagProperty<ValueDisplayBuilder<T>>.has(
          'valueDisplayBuilder',
          valueDisplayBuilder,
        ),
      )
      ..add(
        ObjectFlagProperty<ScaleMarkerBuilder>.has(
          'scaleMarkerBuilder',
          scaleMarkerBuilder,
        ),
      )
      ..add(
        ObjectFlagProperty<ScaleIndicatorBuilder<T>>.has(
          'scaleIndicatorBuilder',
          scaleIndicatorBuilder,
        ),
      );
  }
}

class _Deactivated extends StatelessWidget {
  const _Deactivated({required this.deactivated, required this.child});

  final bool deactivated;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: deactivated ? 0.5 : 1,
      child: IgnorePointer(
        ignoring: deactivated,
        child: child,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('deactivated', deactivated));
  }
}
