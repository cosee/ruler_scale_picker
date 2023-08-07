import 'package:flutter/widgets.dart';
import 'package:ruler_scale_picker/src/widgets/ruler_area/padded_scroll_position_with_single_context.dart';

/// A [ScrollController] with an padding at both ends.
class PaddedScrollController extends ScrollController {
  /// Creates a [ScrollController] with [padding] at start and end.
  PaddedScrollController({this.padding = 0, super.initialScrollOffset})
      : assert(padding >= 0, '[padding] must not be negative.'),
        super(keepScrollOffset: false);

  /// The padding used to calculate the scroll extend.
  final double padding;

  @override
  ScrollPosition createScrollPosition(
    ScrollPhysics physics,
    ScrollContext context,
    ScrollPosition? oldPosition,
  ) {
    return PaddedScrollPositionWithSingleContext(
      physics: physics,
      context: context,
      initialPixels: initialScrollOffset,
      keepScrollOffset: keepScrollOffset,
      oldPosition: oldPosition,
      debugLabel: debugLabel,
      padding: padding,
    );
  }
}
