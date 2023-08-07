import 'package:flutter/widgets.dart';

/// A [ScrollPositionWithSingleContext] with an padding at both ends.
class PaddedScrollPositionWithSingleContext
    extends ScrollPositionWithSingleContext {
  /// Creates a [PaddedScrollPositionWithSingleContext]
  /// with [padding] to calculate [minScrollExtent] and [maxScrollExtent].
  PaddedScrollPositionWithSingleContext({
    required super.physics,
    required super.context,
    required this.padding,
    super.initialPixels,
    super.keepScrollOffset,
    super.debugLabel,
    super.oldPosition,
  }) : assert(padding >= 0, '[padding] must not be negative.');

  /// The padding used to calculate the scroll extend.
  final double padding;

  @override
  double get maxScrollExtent {
    return super.maxScrollExtent - padding;
  }

  @override
  double get minScrollExtent {
    return super.minScrollExtent + padding;
  }
}
