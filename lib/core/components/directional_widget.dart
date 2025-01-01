import 'package:flutter/material.dart';

class DirectionalWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final AlignmentDirectional? alignment;
  final bool flipHorizontally;
  final bool flipVertically;
  final bool mirror;

  const DirectionalWidget({
    super.key,
    required this.child,
    this.padding,
    this.alignment,
    this.flipHorizontally = false,
    this.flipVertically = false,
    this.mirror = false,
  });

  @override
  Widget build(BuildContext context) {
    bool isRTL = Directionality.of(context) == TextDirection.rtl;

    // Adjust padding for RTL
    EdgeInsets adjustedPadding = padding ?? EdgeInsets.zero;
    if (isRTL && padding != null) {
      adjustedPadding = EdgeInsets.fromLTRB(
        padding!.right,
        padding!.top,
        padding!.left,
        padding!.bottom,
      );
    }

    // Adjust alignment for RTL
    AlignmentDirectional adjustedAlignment =
        alignment ?? AlignmentDirectional.topStart;
    if (isRTL && alignment != null) {
      if (alignment == AlignmentDirectional.topStart) {
        adjustedAlignment = AlignmentDirectional.topEnd;
      } else if (alignment == AlignmentDirectional.topEnd) {
        adjustedAlignment = AlignmentDirectional.topStart;
      } else if (alignment == AlignmentDirectional.bottomStart) {
        adjustedAlignment = AlignmentDirectional.bottomEnd;
      } else if (alignment == AlignmentDirectional.bottomEnd) {
        adjustedAlignment = AlignmentDirectional.bottomStart;
      } else {
        adjustedAlignment = alignment!;
      }
    }

    // Flip horizontally and/or vertically based on parameters
    Matrix4 transformation = Matrix4.identity();
    if (flipHorizontally) {
      transformation = transformation..rotateY(isRTL ? 0 : 3.14);
    }
    if (flipVertically) {
      transformation = transformation..rotateX(3.14);
    }

    // Mirror transformation for RTL
    if (mirror && isRTL) {
      transformation = transformation..scale(-1.0, 1.0, 1.0);
    }

    return Padding(
      padding: adjustedPadding,
      child: Align(
        alignment: adjustedAlignment,
        child: Transform(
          alignment: Alignment.center,
          transform: transformation,
          child: child,
        ),
      ),
    );
  }
}
