import 'package:flutter/material.dart';
import 'package:ruler_scale_picker_example/pages/default.dart';

class RTLPage extends StatelessWidget {
  const RTLPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultPage(
        title: 'RTL',
      ),
    );
  }
}
