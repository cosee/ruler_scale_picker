import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:ruler_scale_picker/src/widgets/default/scale_indicator.dart';

void main() {
  testGoldens('RulerScaleIndicator', (tester) async {
    final builder = GoldenBuilder.column(
      wrap: (widget) => SizedBox.square(
        dimension: 200,
        child: widget,
      ),
    )
      ..addScenario(
        'horizontal, non-major',
        const RulerScaleIndicator(
          orientation: Axis.horizontal,
          value: '12345',
          isMajorIndicator: false,
        ),
      )
      ..addScenario(
        'horizontal, major',
        const RulerScaleIndicator(
          orientation: Axis.horizontal,
          value: '12345',
          isMajorIndicator: true,
        ),
      )
      ..addScenario(
        'vertical, non-major',
        const RulerScaleIndicator(
          orientation: Axis.vertical,
          value: '12345',
          isMajorIndicator: false,
        ),
      )
      ..addScenario(
        'vertical, major',
        const RulerScaleIndicator(
          orientation: Axis.vertical,
          value: '12345',
          isMajorIndicator: true,
        ),
      );

    await tester.pumpWidgetBuilder(
      builder.build(),
      surfaceSize: const Size(300, 1100),
    );
    await screenMatchesGolden(tester, 'ruler_scale_indicator');
  });
}
