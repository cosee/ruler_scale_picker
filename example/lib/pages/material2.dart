import 'package:flutter/material.dart';
import 'package:ruler_scale_picker_example/pages/default.dart';

class Material2Page extends StatelessWidget {
  const Material2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        useMaterial3: false,
      ),
      child: const DefaultPage(
        title: 'Material v2',
      ),
    );
  }
}
