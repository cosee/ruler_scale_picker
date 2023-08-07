import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:ruler_scale_picker/src/widgets/default/button.dart';

void main() {
  testGoldens('RulerButton', (tester) async {
    final builder = GoldenBuilder.column(
      wrap: (widget) => SizedBox.square(
        dimension: 100,
        child: widget,
      ),
    )..addScenario(
        'button',
        RulerButton(
          // No action needed for test.
          // ignore: no-empty-block
          onPressed: () {},
          icon: Icons.remove,
        ),
      );

    await tester.pumpWidgetBuilder(
      builder.build(),
      surfaceSize: const Size(100, 200),
    );
    await screenMatchesGolden(tester, 'ruler_button');
  });
}
