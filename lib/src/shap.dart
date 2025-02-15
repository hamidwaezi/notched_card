import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'cliper.dart';

class CircularDirectionalNotchedRectangle extends NotchedShape {
  final NotchCardDirs direction;
  CircularDirectionalNotchedRectangle({this.direction = NotchCardDirs.top});

  Offset _getP1(Rect host, Rect guest, double r) => switch (direction) {
        NotchCardDirs.top => Offset(-r, host.top - guest.center.dy),
        NotchCardDirs.bottom => Offset(-r, host.bottom - guest.center.dy),
        NotchCardDirs.left => Offset(host.left - guest.center.dx, r),
        NotchCardDirs.right => Offset(host.right - guest.center.dx, r),
      };

  Offset _getP0(double a, double b, double s) =>
      direction.isSide ? Offset(a, b + s) : Offset(a - s, b);

  @override
  Path getOuterPath(Rect host, Rect? guest) {
    if (guest == null || !host.overlaps(guest)) {
      return Path()..addRect(host);
    }

    final double r = (direction.isSide ? guest.height : guest.width) / 2.0;

    final Radius notchRadius = Radius.circular(r);

    final double invertMultiplier = direction.isInverted ? -1.0 : 1.0;

    const double s1 = 15.0;
    const double s2 = 1.0;

    final p1 = _getP1(host, guest, r + s2);
    final double a = p1.dx; //-r - s2;
    final double b = p1.dy;
    //(inverted ? host.bottom : host.top) - guest.center.dy;

    final double n2 = math.sqrt(b * b * r * r * (a * a + b * b - r * r));
    final double p2xA = ((a * r * r) - n2) / (a * a + b * b);
    final double p2xB = ((a * r * r) + n2) / (a * a + b * b);
    final double p2yA = math.sqrt(r * r - p2xA * p2xA) * invertMultiplier;
    final double p2yB = math.sqrt(r * r - p2xB * p2xB) * invertMultiplier;

    final List<Offset> p = List<Offset>.filled(6, Offset.zero);

    // p0, p1, and p2 are the control points for segment A.
    p[0] = _getP0(a, b, s1); //Offset(a - s1, b);
    p[1] = Offset(a, b);

    final double cmp = (direction.isSide
        ? a < 0
            ? 1.0
            : -1.0
        : b < 0
            ? -1.0
            : 1.0);

    p[2] = cmp * p2yA > cmp * p2yB ? Offset(p2xA, p2yA) : Offset(p2xB, p2yB);

    final double m = direction.isSide ? -1.0 : 1.0;
    p[3] = Offset(m * -1.0 * p[2].dx, m * p[2].dy);
    p[4] = Offset(m * -1.0 * p[1].dx, m * p[1].dy);
    p[5] = Offset(m * -1.0 * p[0].dx, m * p[0].dy);

    for (int i = 0; i < p.length; i += 1) {
      p[i] += guest.center;
    }

    final Path path = Path();

    switch (direction) {
      case NotchCardDirs.top:
        path
          ..moveTo(host.left, host.top)
          ..lineTo(p[0].dx, p[0].dy)
          ..quadraticBezierTo(p[1].dx, p[1].dy, p[2].dx, p[2].dy)
          ..arcToPoint(p[3], radius: notchRadius, clockwise: false)
          ..quadraticBezierTo(p[4].dx, p[4].dy, p[5].dx, p[5].dy)
          ..lineTo(host.right, host.top)
          ..lineTo(host.right, host.bottom)
          ..lineTo(host.left, host.bottom);
        break;
      case NotchCardDirs.bottom:
        path
          ..moveTo(host.left, host.top)
          ..lineTo(host.right, host.top)
          ..lineTo(host.right, host.bottom)
          ..lineTo(p[5].dx, p[5].dy)
          ..quadraticBezierTo(p[4].dx, p[4].dy, p[3].dx, p[3].dy)
          ..arcToPoint(p[2], radius: notchRadius, clockwise: false)
          ..quadraticBezierTo(p[1].dx, p[1].dy, p[0].dx, p[0].dy)
          ..lineTo(host.left, host.bottom);
      case NotchCardDirs.left:
        path
          ..moveTo(host.left, host.bottom)
          ..lineTo(p[0].dx, p[0].dy)
          ..quadraticBezierTo(p[1].dx, p[1].dy, p[2].dx, p[2].dy)
          ..arcToPoint(p[3], radius: notchRadius, clockwise: false)
          ..quadraticBezierTo(p[4].dx, p[4].dy, p[5].dx, p[5].dy)
          ..lineTo(host.left, host.top)
          ..lineTo(host.right, host.top)
          ..lineTo(host.right, host.bottom);
      case NotchCardDirs.right:
        path
          ..moveTo(host.left, host.bottom)
          ..lineTo(host.left, host.top)
          ..lineTo(host.right, host.top)
          ..lineTo(p[5].dx, p[5].dy)
          ..quadraticBezierTo(p[4].dx, p[4].dy, p[2].dx, p[2].dy)
          ..arcToPoint(p[3], radius: notchRadius, clockwise: false)
          ..quadraticBezierTo(p[1].dx, p[1].dy, p[0].dx, p[0].dy)
          ..lineTo(host.right, host.bottom);
    }

    return path..close();
  }
}
