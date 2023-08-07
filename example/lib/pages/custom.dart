import 'package:flutter/material.dart';
import 'package:ruler_scale_picker/ruler_scale_picker.dart';

// ignore_for_file: avoid-non-ascii-symbols

class CustomPage extends StatefulWidget {
  const CustomPage({super.key});

  @override
  State<CustomPage> createState() => _CustomPageState();
}

class _CustomPageState extends State<CustomPage> {
  final _controller = _CustomRulerPickerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom implementation'),
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: 200,
              child: _CustomRulerPicker(
                controller: _controller,
              ),
            ),
            _ControllerBox(controller: _controller),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _CustomRulerPickerController extends ChangeNotifier
    implements RulerScalePickerController<String> {
  final _values = [
    '😀',
    '😃',
    '😄',
    '😁',
    '😆',
    '🥹',
    '😅',
    '😂',
    '🤣',
    '🥲',
    '😊',
    '😇',
    '🙂',
    '🙃',
    '😉',
    '😌',
    '😍',
    '🥰',
    '😘',
  ];
  int _index = 0;

  @override
  void decrease() {
    if (_index > 0) {
      _index--;
      notifyListeners();
    }
  }

  @override
  int get index => _index;

  @override
  int getIndexOf(String value) => _values.indexOf(value);

  @override
  int get length => _values.length;

  @override
  String get value => _values[_index];

  @override
  String getValueAt(int index) {
    if (index >= 0 && index < _values.length) {
      return _values[index];
    } else {
      return _values.first;
    }
  }

  @override
  void increase() {
    if (_index < _values.length - 1) {
      _index++;
      notifyListeners();
    }
  }

  @override
  void setValue(String value) {
    final newIndex = getIndexOf(value);
    if (newIndex > _values.length - 1) {
      _index = _values.length - 1;
    } else if (newIndex < 0) {
      _index = 0;
    } else {
      _index = newIndex;
    }
    notifyListeners();
  }
}

class _CustomRulerPicker extends StatelessWidget {
  const _CustomRulerPicker({required this.controller});

  final RulerScalePickerController<String> controller;

  @override
  Widget build(BuildContext context) {
    return RulerScalePicker(
      controller: controller,
      options: const RulerScalePickerOptions(indicatorExtend: 60),
      increaseButtonBuilder: _increaseButtonBuilder,
      decreaseButtonBuilder: _decreaseButtonBuilder,
      valueDisplayBuilder: _valueDisplayBuilder,
      scaleIndicatorBuilder: _scaleIndicatorBuilder,
      scaleMarkerBuilder: _scaleMarkerBuilder,
    );
  }

  Widget _scaleIndicatorBuilder(
    // Needed for builder.
    // ignore: avoid-unused-parameters
    BuildContext context,

    // Needed for builder.
    // ignore: avoid-unused-parameters
    Axis orientation,
    String value, {
    // Needed for builder.
    // ignore: avoid-unused-parameters
    required bool isMajorIndicator,
  }) {
    return Center(
      child: Text(
        value,
        style: const TextStyle(fontSize: 30),
      ),
    );
  }

  // Needed for builder.
  // ignore: avoid-unused-parameters
  Widget _valueDisplayBuilder(BuildContext context, String value) => Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          value,
          style: const TextStyle(fontSize: 30),
        ),
      );

  // Needed for builder.
  // ignore: avoid-unused-parameters
  Widget _decreaseButtonBuilder(BuildContext context, VoidCallback action) {
    return ElevatedButton(
      onPressed: action,
      child: const Text(
        '👈',
        style: TextStyle(fontSize: 30),
      ),
    );
  }

  // Needed for builder.
  // ignore: avoid-unused-parameters
  Widget _increaseButtonBuilder(BuildContext context, VoidCallback action) {
    return ElevatedButton(
      onPressed: action,
      child: const Text(
        '👉',
        style: TextStyle(fontSize: 30),
      ),
    );
  }

  // Needed for builder.
  // ignore: avoid-unused-parameters
  Widget _scaleMarkerBuilder(BuildContext context, Axis orientation) {
    return Container(
      height: 60,
      width: 60,
      decoration: const BoxDecoration(
        border: Border.fromBorderSide(
          BorderSide(color: Colors.amber, width: 5),
        ),
        shape: BoxShape.circle,
      ),
    );
  }
}

class _ControllerBox extends StatelessWidget {
  const _ControllerBox({required this.controller});

  final _CustomRulerPickerController controller;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        return ColoredBox(
          color: Colors.amber,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('INDEX: ${controller.index}'),
                Text('VALUE: ${controller.value}'),
                TextButton(
                  onPressed: controller.increase,
                  child: const Text('INCREASE'),
                ),
                TextButton(
                  onPressed: controller.decrease,
                  child: const Text('DECREASE'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
