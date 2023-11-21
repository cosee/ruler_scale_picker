import 'package:flutter/widgets.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:ruler_scale_picker/src/widgets/default/value_view.dart';

void main() {
  testGoldens('RulerValueView', (tester) async {
    final builder = GoldenBuilder.column(
      wrap: (widget) => SizedBox.square(
        dimension: 50,
        child: widget,
      ),
    )
      ..addScenario(
        'one digit, one used',
        const RulerValueView(
          maxLetterCount: 1,
          value: '9',
        ),
      )
      ..addScenario(
        'five digits, one used',
        const RulerValueView(
          maxLetterCount: 5,
          value: '0',
        ),
      )
      ..addScenario(
        'five digits, five used',
        const RulerValueView(
          maxLetterCount: 5,
          value: '99999',
        ),
      );

    await tester.pumpWidgetBuilder(
      builder.build(),
      surfaceSize: const Size(100, 625),
    );
    await screenMatchesGolden(tester, 'ruler_value_view');
  });
}
