import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:ruler_scale_picker/src/controller/numeric_controller.dart';
import 'package:ruler_scale_picker/src/options.dart';
import 'package:ruler_scale_picker/src/widgets/default/button.dart';
import 'package:ruler_scale_picker/src/widgets/default/scale_indicator.dart';
import 'package:ruler_scale_picker/src/widgets/default/scale_marker.dart';
import 'package:ruler_scale_picker/src/widgets/default/value_view.dart';
import 'package:ruler_scale_picker/src/widgets/numeric_ruler_scale_picker.dart';
import 'package:ruler_scale_picker/src/widgets/ruler_area/scroll_area.dart';

void main() {
  testGoldens('NumericRulerPicker', (tester) async {
    final builder = GoldenBuilder.column(
      wrap: (widget) => SizedBox.square(
        dimension: 400,
        child: widget,
      ),
    )
      ..addScenario(
        'horizontal',
        const NumericRulerScalePicker(),
      )
      ..addScenario(
        'vertical',
        const NumericRulerScalePicker(
          options: RulerScalePickerOptions(orientation: Axis.vertical),
        ),
      )
      ..addScenario(
        'horizontal, last position',
        NumericRulerScalePicker(
          controller: NumericRulerScalePickerController(initialValue: 10),
        ),
      )
      ..addScenario(
        'vertical, last position',
        NumericRulerScalePicker(
          controller: NumericRulerScalePickerController(initialValue: 10),
          options: const RulerScalePickerOptions(orientation: Axis.vertical),
        ),
      )
      ..addScenario(
        'horizontal, very long',
        NumericRulerScalePicker(
          controller: NumericRulerScalePickerController(lastValue: 1000),
        ),
      )
      ..addScenario(
        'vertical, very long',
        NumericRulerScalePicker(
          options: const RulerScalePickerOptions(orientation: Axis.vertical),
          controller: NumericRulerScalePickerController(lastValue: 1000),
        ),
      )
      ..addScenario(
        'horizontal, very long, last position',
        NumericRulerScalePicker(
          controller: NumericRulerScalePickerController(
            lastValue: 1000,
            initialValue: 1000,
          ),
        ),
      )
      ..addScenario(
        'vertical, very long, last position',
        NumericRulerScalePicker(
          options: const RulerScalePickerOptions(orientation: Axis.vertical),
          controller: NumericRulerScalePickerController(
            lastValue: 1000,
            initialValue: 1000,
          ),
        ),
      )
      ..addScenario(
        'horizontal, very extended',
        NumericRulerScalePicker(
          options: const RulerScalePickerOptions(indicatorExtend: 66),
          controller: NumericRulerScalePickerController(
            initialValue: 3,
          ),
        ),
      )
      ..addScenario(
        'vertical, very extended',
        NumericRulerScalePicker(
          options: const RulerScalePickerOptions(
            indicatorExtend: 66,
            orientation: Axis.vertical,
          ),
          controller: NumericRulerScalePickerController(
            initialValue: 4,
          ),
        ),
      )
      ..addScenario(
        'disabled',
        const NumericRulerScalePicker(
          options: RulerScalePickerOptions(
            isEnabled: false,
          ),
        ),
      )
      ..addScenario(
        'no controls',
        const NumericRulerScalePicker(
          options: RulerScalePickerOptions(
            showControls: false,
          ),
        ),
      );

    await tester.pumpWidgetBuilder(
      builder.build(),
      surfaceSize: const Size(400, 6000),
    );
    await screenMatchesGolden(tester, 'numeric_ruler_picker');
  });

  Widget increaseButtonBuilder(_, VoidCallback action) {
    return RulerButton(
      key: const ValueKey('ButtonAdd'),
      onPressed: action,
      icon: Icons.add,
    );
  }

  Widget decreaseButtonBuilder(_, VoidCallback action) {
    return RulerButton(
      key: const ValueKey('ButtonRemove'),
      onPressed: action,
      icon: Icons.remove,
    );
  }

  Widget valueDisplayBuilder(_, int value) {
    return RulerValueView(
      key: const ValueKey('Value'),
      maxLetterCount: 2,
      value: value.toString(),
    );
  }

  Widget scaleIndicatorBuilder(
    _,
    Axis orientation,
    int value, {
    required bool isMajorIndicator,
  }) {
    return SizedBox(
      key: ValueKey('ScaleIndicator$value'),
      child: RulerScaleIndicator(
        key: const ValueKey('ScaleIndicator'),
        orientation: orientation,
        value: value.toString(),
        isMajorIndicator: isMajorIndicator,
      ),
    );
  }

  Widget scaleMarkerBuilder(_, Axis orientation) {
    return RulerScaleMarker(
      key: const ValueKey('ScaleMarker'),
      orientation: orientation,
    );
  }

  testWidgets('NumericRulerPicker is complete', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NumericRulerScalePicker(
          options: const RulerScalePickerOptions(),
          increaseButtonBuilder: increaseButtonBuilder,
          decreaseButtonBuilder: decreaseButtonBuilder,
          valueDisplayBuilder: valueDisplayBuilder,
          scaleMarkerBuilder: scaleMarkerBuilder,
          scaleIndicatorBuilder: scaleIndicatorBuilder,
        ),
      ),
    );

    final addButton = find.byKey(const ValueKey('ButtonAdd'));
    final removeButton = find.byKey(const ValueKey('ButtonRemove'));
    final valueView = find.byKey(const ValueKey('Value'));
    final scaleIndicator = find.byKey(const ValueKey('ScaleIndicator'));
    final scaleMarker = find.byKey(const ValueKey('ScaleMarker'));

    expect(addButton, findsOneWidget);
    expect(removeButton, findsOneWidget);
    expect(valueView, findsOneWidget);
    expect(scaleIndicator, findsNWidgets(11));
    expect(scaleMarker, findsOneWidget);
  });

  testWidgets('increase value by button', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NumericRulerScalePicker(
          controller: NumericRulerScalePickerController(
            lastValue: 2,
            initialValue: 1,
          ),
          increaseButtonBuilder: increaseButtonBuilder,
          valueDisplayBuilder: valueDisplayBuilder,
        ),
      ),
    );

    final addButton = find.byKey(const ValueKey('ButtonAdd'));
    final valueView = find.byKey(const ValueKey('Value'));
    var valueViewText =
        find.descendant(of: valueView, matching: find.text('1'));
    expect(valueViewText, findsOneWidget);

    await tester.tap(addButton);
    await tester.pumpAndSettle();
    valueViewText = find.descendant(of: valueView, matching: find.text('2'));
    expect(valueViewText, findsOneWidget);

    await tester.tap(addButton);
    await tester.pumpAndSettle();
    valueViewText = find.descendant(of: valueView, matching: find.text('2'));
    expect(valueViewText, findsOneWidget);
  });

  testWidgets('decrease value by button', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NumericRulerScalePicker(
          controller: NumericRulerScalePickerController(
            lastValue: 2,
            initialValue: 1,
          ),
          decreaseButtonBuilder: decreaseButtonBuilder,
          valueDisplayBuilder: valueDisplayBuilder,
        ),
      ),
    );

    final removeButton = find.byKey(const ValueKey('ButtonRemove'));
    final valueView = find.byKey(const ValueKey('Value'));
    var valueViewText =
        find.descendant(of: valueView, matching: find.text('1'));
    expect(valueViewText, findsOneWidget);

    await tester.tap(removeButton);
    await tester.pumpAndSettle();
    valueViewText = find.descendant(of: valueView, matching: find.text('0'));
    expect(valueViewText, findsOneWidget);

    await tester.tap(removeButton);
    await tester.pumpAndSettle();
    valueViewText = find.descendant(of: valueView, matching: find.text('0'));
    expect(valueViewText, findsOneWidget);
  });

  testWidgets('increase value by swipe', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NumericRulerScalePicker(
            options: const RulerScalePickerOptions(indicatorExtend: 30),
            controller: NumericRulerScalePickerController(
              lastValue: 2,
              initialValue: 1,
            ),
            valueDisplayBuilder: valueDisplayBuilder,
            scaleMarkerBuilder: scaleMarkerBuilder,
          ),
        ),
      ),
    );

    final rulerScrollArea = find.byType(RulerScrollArea<int>);
    final valueView = find.byKey(const ValueKey('Value'));
    var valueViewText =
        find.descendant(of: valueView, matching: find.text('1'));
    expect(valueViewText, findsOneWidget);

    await tester.drag(
      rulerScrollArea,
      const Offset(-30, 0),
    );
    await tester.pumpAndSettle();
    valueViewText = find.descendant(of: valueView, matching: find.text('2'));
    expect(valueViewText, findsOneWidget);

    await tester.drag(
      rulerScrollArea,
      const Offset(-30, 0),
    );
    await tester.pumpAndSettle();
    valueViewText = find.descendant(of: valueView, matching: find.text('2'));
    expect(valueViewText, findsOneWidget);
  });

  testWidgets('decrease value by swipe', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NumericRulerScalePicker(
            options: const RulerScalePickerOptions(indicatorExtend: 30),
            controller: NumericRulerScalePickerController(
              lastValue: 2,
              initialValue: 1,
            ),
            valueDisplayBuilder: valueDisplayBuilder,
            scaleMarkerBuilder: scaleMarkerBuilder,
          ),
        ),
      ),
    );

    final rulerScrollArea = find.byType(RulerScrollArea<int>);
    final valueView = find.byKey(const ValueKey('Value'));
    var valueViewText =
        find.descendant(of: valueView, matching: find.text('1'));
    expect(valueViewText, findsOneWidget);

    await tester.drag(
      rulerScrollArea,
      const Offset(30, 0),
    );
    await tester.pumpAndSettle();
    valueViewText = find.descendant(of: valueView, matching: find.text('0'));
    expect(valueViewText, findsOneWidget);

    await tester.drag(
      rulerScrollArea,
      const Offset(30, 0),
    );
    await tester.pumpAndSettle();
    valueViewText = find.descendant(of: valueView, matching: find.text('0'));
    expect(valueViewText, findsOneWidget);
  });
}
