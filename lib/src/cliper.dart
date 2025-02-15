import 'package:flutter/material.dart';

enum NotchCardDirs {
  top,
  bottom,
  left,
  right;

  bool get isSide => this == NotchCardDirs.left || this == NotchCardDirs.right;

  /// Returns true if the direction is right or bottom.
  bool get isInverted =>
      this == NotchCardDirs.bottom || this == NotchCardDirs.right;
}

final class NotchCardClipper extends CustomClipper<Path> {
  const NotchCardClipper({
    required this.shape,
    this.textDirection,
    this.borderShap,
    required this.hostKey,
    required this.guestKey,
    required this.notchMargin,
  });
  final ShapeBorder? borderShap;
  final NotchedShape shape;
  final TextDirection? textDirection;

  final double notchMargin;
  final GlobalKey hostKey, guestKey;

  Rect? boxToRect(RenderBox? box, {RenderObject? ancestor}) {
    if (box == null) return null;
    final topLeft = box.localToGlobal(Offset.zero, ancestor: ancestor);
    final bottomRight = box.localToGlobal(box.size.bottomRight(Offset.zero),
        ancestor: ancestor);
    return Rect.fromPoints(topLeft, bottomRight);
  }

  @override
  Path getClip(Size size) {
    final hostBox =
        boxToRect(hostKey.currentContext?.findRenderObject() as RenderBox?);
    final top = hostBox?.top ?? 0;
    final left = hostBox?.left ?? 0;

    // final right = hostBox?.right ?? 0;
    // final bottom = hostBox?.bottom ?? 0;

    final guestBox = boxToRect(
      guestKey.currentContext?.findRenderObject() as RenderBox?,
      ancestor: hostKey.currentContext?.findRenderObject(),
    );

    final Rect host = Offset.zero & size;
    final guest = guestBox?.inflate(notchMargin);

    // final g = .getBounds().inflate(notchMargin);

    final path =
        shape.getOuterPath(hostBox!.translate(left * -1, top * -1), guest);
    final pathBorder = borderShap?.getOuterPath(Offset.zero & size,
        textDirection: textDirection);
    // return pathBorder!;
    return Path.combine(
      PathOperation.intersect,
      path,
      pathBorder ?? (Path()..addRect(host)),
    );
  }

  @override
  bool shouldReclip(NotchCardClipper oldClipper) {
    return oldClipper.guestKey != guestKey ||
        oldClipper.hostKey != hostKey ||
        oldClipper.shape != shape ||
        oldClipper.notchMargin != notchMargin;
  }
}
