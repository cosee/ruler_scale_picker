import 'package:flutter/foundation.dart';

/// Interface for a Controller to be used with [RulerPicker<T>].
abstract interface class RulerScalePickerController<T>
    implements ChangeNotifier {
  /// Sets a new value.
  void setValue(T value);

  /// Returns the current value.
  T get value;

  /// Returns the value at [index].
  T getValueAt(int index);

  /// Returns the current index.
  int get index;

  /// Returns the index of [value].
  int getIndexOf(T value);

  /// Returns the amount of values.
  int get length;

  /// Decreases the index by 1.
  void decrease();

  /// Increase the index by 1.
  void increase();
}
