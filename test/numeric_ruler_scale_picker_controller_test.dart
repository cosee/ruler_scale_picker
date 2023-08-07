import 'package:flutter_test/flutter_test.dart';
import 'package:ruler_scale_picker/src/controller/numeric_controller.dart';

void main() {
  group('value modification', () {
    test('increase value', () {
      final controller = NumericRulerScalePickerController()..increase();
      expect(controller.value, 1);
    });

    test('increase value from negative', () {
      final controller =
          NumericRulerScalePickerController(firstValue: -5, initialValue: -4)
            ..increase();
      expect(controller.value, -3);
    });

    test('decrease value', () {
      final controller = NumericRulerScalePickerController(initialValue: 2)
        ..decrease();
      expect(controller.value, 1);
    });

    test('decrease value from negative', () {
      final controller =
          NumericRulerScalePickerController(firstValue: -5, initialValue: -4)
            ..decrease();
      expect(controller.value, -5);
    });

    test('increase value above range', () {
      final controller = NumericRulerScalePickerController(
        initialValue: 9,
        lastValue: 9,
      )..increase();
      expect(controller.value, 9);
    });

    test('decrease value below range', () {
      final controller = NumericRulerScalePickerController(
        initialValue: 1,
        firstValue: 1,
      )..decrease();
      expect(controller.value, 1);
    });

    test('decrease with set interval', () {
      final controller = NumericRulerScalePickerController(
        interval: 5,
        initialValue: 5,
      );

      expect(controller.value, 5);
      controller.decrease();
      expect(controller.value, 0);
      controller.decrease();
      expect(controller.value, 0);
    });

    test('increase with set interval', () {
      final controller = NumericRulerScalePickerController(
        interval: 5,
        initialValue: 5,
      );

      expect(controller.value, 5);
      controller.increase();
      expect(controller.value, 10);
      controller.increase();
      expect(controller.value, 10);
    });

    test('get value', () {
      final controller = NumericRulerScalePickerController();
      expect(controller.value, 0);
    });

    test('set value', () {
      final controller = NumericRulerScalePickerController()..setValue(5);
      expect(controller.value, 5);
    });

    test('set value below range', () {
      final controller = NumericRulerScalePickerController()..setValue(-9);
      expect(controller.value, 0);
    });

    test('set value above range', () {
      final controller = NumericRulerScalePickerController()..setValue(99);
      expect(controller.value, 10);
    });

    test('set value between intervals (round off)', () {
      final controller = NumericRulerScalePickerController(
        interval: 5,
      )..setValue(2);
      expect(controller.value, 0);
    });

    test('set value between intervals (round up)', () {
      final controller = NumericRulerScalePickerController(
        interval: 5,
      )..setValue(3);
      expect(controller.value, 5);
    });
  });

  group('index', () {
    test('get start index', () {
      final controller = NumericRulerScalePickerController();
      expect(controller.index, 0);
    });

    test('get start index of', () {
      final controller = NumericRulerScalePickerController();
      expect(controller.getIndexOf(5), 5);
    });

    test('get start index of negative value', () {
      final controller =
          NumericRulerScalePickerController(initialValue: -5, firstValue: -10);
      expect(controller.index, 5);
    });

    test('get index of with interval', () {
      final controller = NumericRulerScalePickerController(interval: 5);
      expect(controller.getIndexOf(5), 1);
    });

    test('get index of negative value', () {
      final controller =
          NumericRulerScalePickerController(initialValue: -5, firstValue: -10);
      expect(controller.getIndexOf(-4), 6);
    });

    test('get value at index', () {
      final controller = NumericRulerScalePickerController();
      expect(controller.getValueAt(5), 5);
    });

    test('get value at index with interval', () {
      final controller = NumericRulerScalePickerController(interval: 5);
      expect(controller.getValueAt(1), 5);
    });
  });

  group('initialization', () {
    test('initial value below range', () {
      final controller = NumericRulerScalePickerController(
        initialValue: 2,
        firstValue: 5,
      );
      expect(controller.value, 5);
    });

    test('initial value above range', () {
      final controller = NumericRulerScalePickerController(
        initialValue: 15,
        lastValue: 9,
      );
      expect(controller.value, 9);
    });

    test('initial value between intervals (round off)', () {
      final controller = NumericRulerScalePickerController(
        initialValue: 2,
        interval: 5,
      );
      expect(controller.value, 0);
    });

    test('initial value between intervals (round up)', () {
      final controller = NumericRulerScalePickerController(
        initialValue: 3,
        interval: 5,
      );
      expect(controller.value, 5);
    });

    test('initial value between intervals (round up)', () {
      final controller = NumericRulerScalePickerController(
        initialValue: 3,
        interval: 5,
      );
      expect(controller.value, 5);
    });

    test('invalid range', () {
      expect(
        () => NumericRulerScalePickerController(
          firstValue: 3,
          lastValue: 1,
        ),
        throwsA(
          const TypeMatcher<AssertionError>(),
        ),
      );
    });

    test('invalid range (same value)', () {
      expect(
        () => NumericRulerScalePickerController(
          firstValue: 3,
          lastValue: 3,
        ),
        throwsA(
          const TypeMatcher<AssertionError>(),
        ),
      );
    });

    test('length with set interval', () {
      final controller = NumericRulerScalePickerController(
        interval: 5,
      );
      expect(controller.length, 3);
    });
  });

  group('listener', () {
    test('add listener', () {
      int calls = 0;
      NumericRulerScalePickerController().addListener(() => calls++);
      expect(calls, 0);
    });

    test('getValue', () {
      int calls = 0;
      NumericRulerScalePickerController()
        ..addListener(() => calls++)
        ..value;
      expect(calls, 0);
    });

    test('call listener', () {
      int calls = 0;
      NumericRulerScalePickerController()
        ..addListener(() => calls++)
        ..increase();
      expect(calls, 1);
    });
  });
}
