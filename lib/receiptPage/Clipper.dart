
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:math' as math;

import 'ClipShadowPath.dart';


class NotchClipper extends CustomClipper<Path> {
  final double radius;
  final double corner;
  final double notchWidthFactor;
  final double notchDivFactor;
  final double gap;
  final Size? notchSize;
  final bool notch;

  NotchClipper(
      {this.radius = 40,
        this.corner = 25,
        this.notchWidthFactor = 12,
        this.gap = 10,
        this.notchDivFactor = 5,
        this.notchSize,
        this.notch = false});

  @override
  Path getClip(Size size) {
    return notchSize != null ? _notch0(size) : _curve(size);
  }

  Path _curve(Size size) {
    Path path = Path();
    double sw = size.width;
    var h = radius;
    var gap = radius - this.gap;

    var area = Rect.fromLTWH(0, radius, size.width, size.height - radius);
    path.addRRect(RRect.fromRectAndRadius(area, Radius.circular(corner)));

    var wd = notchWidthFactor;
    Path p = Path();
    p.moveTo(sw / 2 - sw / notchDivFactor, h);
    p.cubicTo(sw / 2 - sw / wd, h, sw / 2 - sw / wd, h - gap, sw / 2, h - gap);
    p.cubicTo(sw / 2 + sw / wd, h - gap, sw / 2 + sw / wd, h,
        sw / 2 + sw / notchDivFactor, h);
    p.close();

    return Path.combine(PathOperation.union, path, p);
  }

  Path _notch0(Size size) {
    var width = notchSize?.width.toDouble() ?? 75;
    var height = notchSize?.height.toDouble() ?? 25;
    var gap = height.toDouble();
    var notch = this.notch;

    var guest =
    Rect.fromLTWH(size.width / 2 - (width / 2), gap * 2, width, height);
    var host = Rect.fromLTWH(0, gap * 2, size.width, size.height - (gap * 2));

    final double notchRadius = guest.width / 2.0;
    const double s1 = 15.0;
    const double s2 = 1.0;

    final double r = notchRadius;
    final double a = -1.0 * r - s2;
    final double b = host.top - guest.center.dy;

    final double n2 = math.sqrt(b * b * r * r * (a * a + b * b - r * r));
    final double p2xA = ((a * r * r) - n2) / (a * a + b * b);
    final double p2xB = ((a * r * r) + n2) / (a * a + b * b);
    final double p2yA = math.sqrt(r * r - p2xA * p2xA);
    final double p2yB = math.sqrt(r * r - p2xB * p2xB);

    final List<Offset?> p = List<Offset?>.filled(6, null);

    // p0, p1, and p2 are the control points for segment A.
    p[0] = Offset(a - s1, b);
    p[1] = Offset(a, b);
    final double cmp = b < 0 ? -1.0 : 1.0;
    p[2] = cmp * p2yA > cmp * p2yB ? Offset(p2xA, p2yA) : Offset(p2xB, p2yB);

    // p3, p4, and p5 are the control points for segment B, which is a mirror
    // of segment A around the y axis.
    p[3] = Offset(-1.0 * p[2]!.dx, p[2]!.dy);
    p[4] = Offset(-1.0 * p[1]!.dx, p[1]!.dy);
    p[5] = Offset(-1.0 * p[0]!.dx, p[0]!.dy);

    // translate all points back to the absolute coordinate system.
    for (int i = 0; i < p.length; i += 1) {
      p[i] = p[i]! + guest.center;
    }

    if (!notch) {
      p[2] = Offset(p[2]!.dx, p[2]!.dy - gap);
      p[3] = Offset(p[3]!.dx, p[3]!.dy - gap);
    }

    if (notch) {
      var path = Path();
      path.addRRect(RRect.fromRectAndRadius(host, Radius.circular(corner)));
      return Path.combine(
          notch ? PathOperation.difference : PathOperation.union,
          path,
          Path()
            ..moveTo(host.left, host.top)
            ..lineTo(p[0]!.dx, p[0]!.dy)
            ..quadraticBezierTo(p[1]!.dx, p[1]!.dy, p[2]!.dx, p[2]!.dy)
            ..arcToPoint(
              p[3]!,
              radius: Radius.circular(notchRadius),
              clockwise: !notch,
            )
            ..quadraticBezierTo(p[4]!.dx, p[4]!.dy, p[5]!.dx, p[5]!.dy)
            ..lineTo(host.right, host.top)
            ..close());
    } else {
      var center = Offset(host.width / 2, host.top);
      var radius = guest.width * 0.5;
      var path = Path();
      path.addRRect(RRect.fromRectAndRadius(host, Radius.circular(corner)));
      return Path.combine(
          notch ? PathOperation.difference : PathOperation.union,
          path,
          Path()
            ..moveTo(center.dx - radius - 15, center.dy)
            ..quadraticBezierTo(center.dx - radius - 10, center.dy,
                center.dx - radius, center.dy - 10)
            ..cubicTo(
                center.dx - (radius * 0.6),
                height * 0.4,
                center.dx + (radius * 0.6),
                height * 0.4,
                center.dx + radius,
                center.dy - 10)
            ..quadraticBezierTo(center.dx + radius + 10, center.dy,
                center.dx + radius + 15, center.dy)
            ..close());
    }
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}




class ReceiptRow {
  String label;
  String value;
  String? icon;
  TextDirection direction;
  TextAlign align;

  ReceiptRow(
      {required this.label,
        required this.value,
        this.icon,
        this.direction = TextDirection.rtl,
        this.align = TextAlign.left});


}

enum ReceiptType {
  success,
  failure,
  unknown,
}


class SuccessReceiptStyle extends ReceiptStyle {
  SuccessReceiptStyle(
      {required super.background,
        required super.dispenser,
        required super.label,
        required super.action,
        required super.value,
        required super.shadow});

  @override
  Object get type => SuccessReceiptStyle;
}

class ErrorReceiptStyle extends ReceiptStyle {
  ErrorReceiptStyle(
      {required super.background,
        required super.dispenser,
        required super.label,
        required super.action,
        required super.value,
        required super.shadow});

  @override
  Object get type => ErrorReceiptStyle;
}

class UnknownReceiptStyle extends ReceiptStyle {
  UnknownReceiptStyle(
      {required super.background,
        required super.dispenser,
        required super.label,
        required super.action,
        required super.value,
        required super.shadow});

  @override
  Object get type => UnknownReceiptStyle;
}


class ReceiptStyle extends ThemeExtension<ReceiptStyle> {
  final Gradient background;
  final Gradient dispenser;
  final TextStyle label;
  final TextStyle value;
  final String action;
  final BoxShadow shadow;

  ReceiptStyle({
    required this.background,
    required this.dispenser,
    required this.label,
    required this.value,
    required this.action,
    required this.shadow,
  });

  @override
  ThemeExtension<ReceiptStyle> copyWith() {
    return this;
  }

  @override
  ThemeExtension<ReceiptStyle> lerp(
      ThemeExtension<ReceiptStyle>? other, double t) {
    return this;
  }
}

class TicketWidget extends StatelessWidget {
  final double width;
  final double? height;
  final double cornerRadius;
  final double topRadius;
  final double ovalRadius;
  final double ratio;
  final double? punchPosition;
  final Widget child;
  final Color color;
  final Color dashColor;
  final Gradient? gradient;
  final BoxShadow? boxShadow;
  final bool isCornerRounded;

  const TicketWidget(
      {super.key,
        required this.width,
        this.height,
        this.cornerRadius = 20,
        this.topRadius = -1,
        this.ovalRadius = 15,
        this.ratio = 2,
        this.punchPosition,
        this.color = Colors.white,
        this.dashColor = Colors.black,
        this.gradient,
        this.boxShadow,
        this.isCornerRounded = false,
        required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipShadowPath(
      clipper: TicketClipper(
          ovalRadius: ovalRadius,
          ratio: ratio,
          punchPosition: punchPosition,
          topRadius: topRadius,
          cornerRadius: cornerRadius),
      shadow: boxShadow ??
          const BoxShadow(
              color: Colors.black,
              offset: Offset(2, 2),
              blurRadius: 10,
              spreadRadius: 5),
      child: /*AnimatedContainer*/ Container(
        // duration: const Duration(seconds: 3),
        width: width,
        // height: height,
        decoration: BoxDecoration(
          // boxShadow: widget.boxShadow,
            color: color,
            gradient: gradient,
            borderRadius: isCornerRounded
                ? topRadius == -1
                ? BorderRadius.circular(cornerRadius)
                : BorderRadius.only(
                topLeft: Radius.circular(topRadius),
                topRight: Radius.circular(topRadius),
                bottomLeft: Radius.circular(cornerRadius),
                bottomRight: Radius.circular(cornerRadius))
                : BorderRadius.circular(0.0)),
        child: CustomPaint(
            painter: CustomDashPaint(
                ratio: ratio,
                punchPosition: punchPosition,
                ovalRadius: ovalRadius,
                color: dashColor),
            child: child),
      ),
    );
  }
}


class TicketClipper extends CustomClipper<Path> {
  final double ovalRadius;

  final double ratio;
  final double? punchPosition;

  final double cornerRadius;
  final double topRadius;

  const TicketClipper(
      {this.ovalRadius = 15,
        this.ratio = 2,
        this.punchPosition,
        this.cornerRadius = 20,
        this.topRadius = 0});

  @override
  Path getClip(Size size) {
    Path path = Path();
    var topRadius = this.topRadius == -1 ? cornerRadius : this.topRadius;

    path.addRRect(RRect.fromRectAndCorners(
        Rect.fromLTWH(0, 0, size.width, size.height),
        topLeft: Radius.circular(topRadius),
        topRight: Radius.circular(topRadius),
        bottomLeft: Radius.circular(cornerRadius),
        bottomRight: Radius.circular(cornerRadius)));

    Path leftNotch = Path();
    leftNotch.addOval(Rect.fromCircle(
        center: Offset(0.0, punchPosition ?? (size.height / ratio)),
        radius: ovalRadius));
    Path rightNotch = Path();
    rightNotch.addOval(Rect.fromCircle(
        center: Offset(size.width, punchPosition ??( size.height / ratio)), radius: ovalRadius));

    path = Path.combine(PathOperation.difference, path, leftNotch);
    path = Path.combine(PathOperation.difference, path, rightNotch);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}


class CustomDashPaint extends CustomPainter {
  final double ratio;
  final double? punchPosition;
  final double ovalRadius;
  final Color color;

  const CustomDashPaint(
      {this.ratio = 2,
        this.ovalRadius = 15,
        this.color = Colors.black,
        this.punchPosition});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.5;

    _drawDashedLine(canvas, size, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  void _drawDashedLine(Canvas canvas, Size size, Paint paint) {
    // Chage to your preferred size
    const int dashWidth = 8;
    const int dashSpace = 8;

    // Start to draw from left size.
    // Of course, you can change it to match your requirement.
    double startX = ovalRadius * 1 /*.5*/;
    double y = punchPosition ?? (size.height / ratio);

    // Repeat drawing until we reach the right edge.
    // In our example, size.with = 300 (from the SizedBox)
    var width = size.width - (startX);
    while (startX < (width)) {
      // Draw a small line.
      canvas.drawLine(Offset(startX, y), Offset(startX + dashWidth, y), paint);

      // Update the starting X
      startX += dashWidth + dashSpace;
    }
  }
}



