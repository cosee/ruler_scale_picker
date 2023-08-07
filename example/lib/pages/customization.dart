import 'package:flutter/material.dart';
import 'package:ruler_scale_picker/ruler_scale_picker.dart';

class CustomizationPage extends StatelessWidget {
  const CustomizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customization'),
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          itemExtent: 180,
          children: [
            const NumericRulerScalePicker(
              options: RulerScalePickerOptions(showControls: false),
            ),
            const Divider(),
            const NumericRulerScalePicker(
              options: RulerScalePickerOptions(indicatorExtend: 70),
            ),
            const Divider(),
            const NumericRulerScalePicker(
              options: RulerScalePickerOptions(majorIndicatorInterval: 2),
            ),
            const Divider(),
            const NumericRulerScalePicker(
              options: RulerScalePickerOptions(isEnabled: false),
            ),
            const Divider(),
            NumericRulerScalePicker(
              decreaseButtonBuilder: (context, action) {
                return ElevatedButton(
                  onPressed: action,
                  child: const Text('DECREASE'),
                );
              },
              increaseButtonBuilder: (context, action) {
                return ElevatedButton(
                  onPressed: action,
                  child: const Text('INCREASE'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
