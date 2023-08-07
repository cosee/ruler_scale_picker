import 'package:flutter/widgets.dart';

/// A [ScrollPhysics] that latches onto offsets.
class LatchingScrollPhysics extends ScrollPhysics {
  /// Creates [ScrollPhysics] used by [RulerScrollArea<T>].
  ///
  /// Latches onto offsets of size [itemExtend].
  const LatchingScrollPhysics(double itemExtend, {super.parent})
      : _itemExtend = itemExtend;

  final double _itemExtend;

  @override
  LatchingScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return LatchingScrollPhysics(_itemExtend, parent: buildParent(ancestor));
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    final double offset = _itemExtend / 2;

    final double remainder = position.pixels % _itemExtend;
    double target = 0;
    if (remainder <= _itemExtend - remainder) {
      target = position.pixels - remainder + offset;
    } else if (remainder > _itemExtend - remainder) {
      target = position.pixels + (_itemExtend - remainder) - offset;
    }

    if (velocity.abs() >= Tolerance.defaultTolerance.velocity ||
        position.pixels > position.maxScrollExtent ||
        position.pixels < position.minScrollExtent) {
      return BouncingScrollSimulation(
        spring: spring,
        position: position.pixels,
        velocity: velocity,
        leadingExtent: position.minScrollExtent,
        trailingExtent: position.maxScrollExtent,
        constantDeceleration: 900,
      );
    } else if (target != position.pixels) {
      return ScrollSpringSimulation(
        spring,
        position.pixels,
        target,
        velocity,
      );
    }
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}
