

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class ClipShadowPath extends StatelessWidget {
  final BoxShadow? shadow;
  final CustomClipper<Path> clipper;
  final Widget child;
  final BorderSide? side;

  const ClipShadowPath({

    this.shadow,
    required this.clipper,
    required this.child,
    this.side,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClipShadowShadowPainter(
          clipper: clipper, shadow: shadow, side: side),
      child: ClipPath(child: child, clipper: clipper),
    );
  }
}



class _ClipShadowShadowPainter extends CustomPainter {
  final BoxShadow? shadow;
  final BorderSide? side;
  final CustomClipper<Path> clipper;

  _ClipShadowShadowPainter({this.shadow, required this.clipper, this.side});

  @override
  void paint(Canvas canvas, Size size) {
    if (shadow != null) {
      var paint = shadow!.toPaint()
        ..maskFilter = MaskFilter.blur(
          BlurStyle.normal,
          shadow!.spreadRadius,
        );
      var clipPath = clipper.getClip(size).shift(shadow!.offset);
      canvas.drawPath(clipPath, paint);
    }

    if (side != null) {
      var paint = Paint()
        ..color = side!.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = side!.width;
      var clipPath = clipper.getClip(size) /*.shift(shadow.offset)*/;
      canvas.drawPath(clipPath, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}