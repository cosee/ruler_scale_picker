import 'package:flutter/foundation.dart';
import 'package:ruler_scale_picker/src/controller/controller.dart';

/// Implementation of [RulerPickerController<T>] using [int].
class NumericRulerScalePickerController extends ChangeNotifier
    implements RulerScalePickerController<int> {
  /// Creates a [NumericRulerScalePickerController]
  ///
  /// Values are a range of numbers from [firstValue] to [lastValue].
  /// Optionally a [interval] can be set.
  NumericRulerScalePickerController({
    this.firstValue = 0,
    this.lastValue = 10,
    this.interval = 1,
    int initialValue = 0,
  }) : assert(
         firstValue < lastValue,
         '[lastValue] must be greater than [firstValue]',
       ),
       assert(
         interval > 0,
         '[interval] must not be smaller 1',
       ) {
    _length = _calculateLength(firstValue, lastValue, interval);

    final isValidValue = _isValidValue(initialValue);
    if (isValidValue) {
      _currentIndex = getIndexOf(initialValue);
    } else {
      _currentIndex = getIndexOf(_getNearestValidValue(initialValue));
    }
  }

  late int _currentIndex;

  /// The first value.
  final int firstValue;

  /// The last value.
  final int lastValue;

  /// The interval of the values.
  ///
  /// [firstValue] 1, [lastValue] 13 and [interval] 3 would be:
  /// [1, 4, 7, 10]
  final int interval;

  late final int _length;

  @override
  int get value => getValueAt(_currentIndex);

  /// Sets a new value.
  ///
  /// if [newValue] is not a valid value for this configuration,
  /// the nearest valid value will be chosen.
  @override
  void setValue(int newValue) {
    final isValid = _isValidValue(newValue);
    if (isValid) {
      _currentIndex = getIndexOf(newValue);
    } else {
      _currentIndex = getIndexOf(_getNearestValidValue(newValue));
    }
    notifyListeners();
  }

  @override
  int get index => _currentIndex;

  @override
  int get length => _length;

  /// Increases the index by 1.
  ///
  /// If the index is already at minimum it does not change the index.
  @override
  void increase() {
    final nextHigherIndex = _getNextHigherIndex(_currentIndex);
    if (_currentIndex != nextHigherIndex) {
      _currentIndex = nextHigherIndex;
      notifyListeners();
    }
  }

  /// Decreases the index by 1.
  ///
  /// If the index is already at minimum it does not change the index.
  @override
  void decrease() {
    final nextLowerIndex = _getNextLowerIndex(_currentIndex);
    if (_currentIndex != nextLowerIndex) {
      _currentIndex = nextLowerIndex;
      notifyListeners();
    }
  }

  int _getNextLowerIndex(int index) {
    if (index > 0) {
      return index - 1;
    } else {
      return index;
    }
  }

  int _getNextHigherIndex(int index) {
    if (_currentIndex < _length - 1) {
      return index + 1;
    } else {
      return index;
    }
  }

  int _calculateLength(int firstValue, int lastValue, int interval) =>
      (lastValue - firstValue) ~/ interval + 1;

  /// Returns the index of [value].
  ///
  /// The returned index could be out of range.
  @override
  int getIndexOf(int value) => (value - firstValue) ~/ interval;

  /// Returns the value at [index].
  ///
  /// The returned value could be out of range.
  @override
  int getValueAt(int index) => index * interval + firstValue;

  int _getNearestValidValue(int value) {
    final remainder = (value - firstValue) % interval;
    final int newValue;

    if (remainder / interval < 0.5) {
      newValue = value - remainder;
    } else {
      newValue = value + interval - remainder;
    }

    if (newValue > lastValue) {
      return lastValue;
    } else if (newValue < firstValue) {
      return firstValue;
    } else {
      return newValue;
    }
  }

  bool _isValidValue(int value) {
    if ((value - firstValue) % interval != 0) {
      return false;
    }
    if (value < firstValue) {
      return false;
    }
    if (value > lastValue) {
      return false;
    }
    return true;
  }
}
