import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:widgets/receiptPage/ClipShadowPath.dart';

class TopHeader extends StatelessWidget {
  const TopHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: false,
      delegate: TopHeaderDelegate(),
    );
  }
}

class TopHeaderDelegate extends SliverPersistentHeaderDelegate {
  const TopHeaderDelegate();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var small = Container(
      key: const ValueKey("small"),
      color: const Color(0XFF28292B),
      child: const Center(
        child: SingleChildScrollView(
          child: BalanceWidget(
            expand: false,
          ),
        ),
      ),
    );

    var large = Container(
      key: const ValueKey("large"),
      color: const Color(0XFF28292B),
      child: const Center(
        child: SingleChildScrollView(
          child: BalanceWidget(
            expand: true,
          ),
        ),
      ),
    );
    return shrinkOffset > 90 ? small : large;
  }

  @override
  double get maxExtent => 265;

  @override
  double get minExtent => 110;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class TransactionHeader extends StatelessWidget {
  final String date;

  const TransactionHeader({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: false,
      delegate: TransactionHeaderDelegate(date: date),
    );
  }
}

class TransactionHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String date;

  const TransactionHeaderDelegate({required this.date});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 50,
      color: Color(0XFF28292B),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Spacer(),
          Text("title test"),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class DialogHeader extends StatelessWidget {
  final String title;

  const DialogHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: false,
      delegate: DialogHeaderDelegate(title: title),
    );
  }
}

class DialogHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;

  const DialogHeaderDelegate({required this.title});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 40,
      color: Color(0XFF28292B),
      child: Center(
        child: Text(title),
      ),
    );
  }

  @override
  double get maxExtent => 40;

  @override
  double get minExtent => 40;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class BalanceWidget extends StatelessWidget {
  final bool expand;

  const BalanceWidget({super.key, this.expand = true});

  @override
  Widget build(BuildContext context) {
    return expand
        ? DashWidget(
            width: 255,
            height: 234,
            cornerRadius: 24,
            dashColor: Color(0xFF232526),
            punchPosition: 136,
            boxShadow: const BoxShadow(color: Colors.transparent),
            gradient: const LinearGradient(
                colors: [Color(0xff324A48), Color(0xff32393D)]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    width: 44,
                    height: 44,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: Color(0xff1C3231), shape: BoxShape.circle),
                    child: Image.asset("images/green_tick.png"),
                    // child: drawables().check.svg(
                    //     colorFilter: primaryFilter(), height: 18.h, width: 18.h),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    "کارت بانک آینده",
                    style: TextStyle(fontSize: 18, color: Color(0xFFCCCCCC)),
                  ),
                ),
                Text("۶۳۶۹  ۸۷۶۵  ۵۴۳۵  ۱۲۹۸",
                    style: TextStyle(fontSize: 12, color: Color(0xFFCCCCCC))),
                SizedBox(
                  height: 50,
                ),
                Text("موجودی",
                    style: TextStyle(fontSize: 12, color: Color(0xFFCCCCCC))),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: const Text.rich(
                    TextSpan(
                        text: "۵٬۸۰۰٬۰۰۰",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFCCCCCC)),
                        children: [
                          TextSpan(
                              text: " ریال",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFCCCCCC)))
                        ]),
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ],
            ))
        : Container(
            width: 255,
            height: 96,
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Color(0xff324A48), Color(0xff32393D)]),
                borderRadius: BorderRadius.circular(23)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("موجودی",
                    style: TextStyle(fontSize: 12, color: Color(0xFFCCCCCC))),
                SizedBox(
                  height: 6,
                ),
                const Text.rich(
                  TextSpan(
                      text: "۵٬۸۰۰٬۰۰۰",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFCCCCCC)),
                      children: [
                        TextSpan(
                            text: " ریال",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFCCCCCC)))
                      ]),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          );
  }
}

class DashWidget extends StatelessWidget {
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

  const DashWidget(
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
        center: Offset(size.width, punchPosition ?? (size.height / ratio)),
        radius: ovalRadius));

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
