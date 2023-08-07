import 'package:flutter/material.dart';
import 'package:ruler_scale_picker/ruler_scale_picker.dart';

class DefaultPage extends StatelessWidget {
  const DefaultPage({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? 'Default'),
        scrolledUnderElevation: 0,
      ),
      body: const SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(child: NumericRulerScalePicker()),
            Expanded(
              child: NumericRulerScalePicker(
                options: RulerScalePickerOptions(orientation: Axis.vertical),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
