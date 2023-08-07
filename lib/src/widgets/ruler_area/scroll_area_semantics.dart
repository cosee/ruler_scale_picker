import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:ruler_scale_picker/src/controller/controller.dart';

///  A widget adding semantics to values represented by a
///  [RulerScalePickerController].
class RulerScrollAreaSemantics<T> extends StatelessWidget {
  /// Creates [RulerScrollAreaSemantics] with Type [T]
  ///
  /// Uses [rulerController] to represent and control the state of it.
  const RulerScrollAreaSemantics({
    required this.rulerController,
    required this.child,
    super.key,
  });

  /// A controller to handle and represent value.
  final RulerScalePickerController<T> rulerController;

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final currentIndex = rulerController.index;
    return Semantics(
      container: true,
      onIncrease: rulerController.increase,
      onDecrease: rulerController.decrease,
      value: rulerController.getValueAt(currentIndex).toString(),
      decreasedValue: rulerController.getValueAt(currentIndex - 1).toString(),
      increasedValue: rulerController.getValueAt(currentIndex + 1).toString(),
      excludeSemantics: true,
      child: child,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<RulerScalePickerController<T>>(
        'rulerController',
        rulerController,
      ),
    );
  }
}
