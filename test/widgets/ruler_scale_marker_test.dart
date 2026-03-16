import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:ruler_scale_picker/src/widgets/default/scale_marker.dart';

void main() {
  testGoldens('RulerScaleMarker', (tester) async {
    final builder = GoldenBuilder.column(
      wrap: (widget) => SizedBox.square(
        dimension: 200,
        child: widget,
      ),
    )
      ..addScenario(
        'horizontal',
        const Center(
          child: RulerScaleMarker(
            orientation: Axis.horizontal,
          ),
        ),
      )
      ..addScenario(
        'vertical',
        const Center(
          child: RulerScaleMarker(
            orientation: Axis.vertical,
          ),
        ),
      );

    await tester.pumpWidgetBuilder(
      builder.build(),
      surfaceSize: const Size(200, 525),
    );
    await screenMatchesGolden(tester, 'ruler_scale_marker');
  });
}
