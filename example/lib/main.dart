import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ruler_scale_picker_example/pages/custom.dart';
import 'package:ruler_scale_picker_example/pages/customization.dart';
import 'package:ruler_scale_picker_example/pages/default.dart';
import 'package:ruler_scale_picker_example/pages/material2.dart';
import 'package:ruler_scale_picker_example/pages/rtl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
      ),
      title: 'RulerScalePicker Demo',
      home: const _Home(),
    );
  }
}

class _Home extends StatelessWidget {
  const _Home();

  static const _padding = EdgeInsets.all(8);
  static final List<(String, WidgetBuilder)> _pages = [
    ('Default', (_) => const DefaultPage()),
    ('RTL', (_) => const RTLPage()),
    ('Material v2', (_) => const Material2Page()),
    ('Customization', (_) => const CustomizationPage()),
    ('Custom implementation', (_) => const CustomPage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text('Examples'),
      ),
      body: ListView.builder(
        itemCount: _pages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: _padding,
            child: ElevatedButton(
              onPressed: () => unawaited(
                _navigateToPage(context, _pages[index].$2.call(context)),
              ),
              child: Text(_pages[index].$1),
            ),
          );
        },
      ),
    );
  }

  Future<void> _navigateToPage(BuildContext context, Widget page) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }
}
