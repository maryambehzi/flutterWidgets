import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyScannerApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'Photo Scanner',
      home: ScannerScreen(),
      theme: CupertinoThemeData(
          brightness: Brightness.dark
      ),
    );
  }
}

class ScannerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ScannerScreenState();
  }
}

class ScannerScreenState extends State<ScannerScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  bool _animationStopped = false;
  String scanText = "Scan";
  bool scanning = false;

  @override
  void initState() {
    _animationController = new AnimationController(
        upperBound: 0.55,
        duration: new Duration(milliseconds: 1500), vsync: this);
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animateScanAnimation(true);
      } else if (status == AnimationStatus.dismissed) {
        animateScanAnimation(false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text("Scanning Animation")),
      child: SafeArea(
        child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(children: [

                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 70.0, left: 250),
                          child: Container(
                            height: 20,
                            width: 80,
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 150),
                          child: Container(
                            height: 20,
                            width: 180,
                            color: Colors.grey,

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50.0,),
                          child: Container(
                            height: 20,
                            width: 90,
                            color: Colors.grey,
                          ),
                        ),

                      ],
                    ),
                    ScannerAnimation(
                      false,
                      350,
                      60,
                      animation: _animationController as Animation<double>,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent),
                        ),
                        child: ClipRRect(
                          // borderRadius: BorderRadius.all(Radius.circular(12)),
                          child: Container(
                            width: 350,
                            height: 200,
                            color: Colors.transparent,
                            child: CustomPaint(
                              foregroundPainter: BorderPainter(),
                              child: Container(
                                width: 350,
                                height: 70,
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                  ]),
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: CupertinoButton(
                      color: CupertinoColors.activeBlue,
                      onPressed: () {
                        if (!scanning) {
                          animateScanAnimation(false);
                          setState(() {
                            _animationStopped = false;
                            scanning = true;
                            scanText = "Stop";
                          });
                        } else {
                          setState(() {
                            _animationStopped = true;
                            scanning = false;
                            scanText = "Scan";
                          });
                        }
                      },
                      child: Text(scanText),
                    ),
                  )
                ])),
      ),
    );
  }

  void animateScanAnimation(bool reverse) {
    if (reverse) {
      _animationController.reverse(from: 1.0);
    } else {
      _animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class ScannerAnimation extends AnimatedWidget {
  final bool stopped;
  final double width;
  final double height;

  const ScannerAnimation(
      this.stopped,
      this.width,
      this.height, {
        Key? key,
        required Animation<double> animation,
      }) : super(
    key: key,
    listenable: animation,
  );

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    final scorePosition = (animation.value * 440) -40 ;

    Color color1 = Colors.black;
    Color color2 = Colors.transparent;

    if (animation.status == AnimationStatus.reverse) {
      color1 = Colors.transparent;
      color2 = Colors.black;
    }

    return Positioned(
      bottom: scorePosition,
      left: 16.0,
      child: Opacity(
        opacity: (stopped) ? 0.0 : 1.0,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [color1, color2],
            ),
          ),
          height: 60,
          width: 350,
          child: CustomPaint(
            painter: BacgroundPaint(),
            child: Container(
              decoration: BoxDecoration(
                border: animation.status == AnimationStatus.reverse
                    ? const Border(
                  bottom: BorderSide(width: 2.0, color: Colors.teal),)
                    : const Border(
                  top: BorderSide(width: 2.0, color: Colors.teal),),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [color1, color2],
                ),
              ),
              height: 60,
              width: 350,
            ),
          ),
        ),
      ),
    );
  }
}

class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double sh = size.height; // for convenient shortage
    double sw = size.width; // for convenient shortage
    double cornerSide = sh * 0.08; // desirable value for corners side

    Paint paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    Path path = Path()
      ..moveTo(cornerSide, 0)
      ..lineTo(0, 0)
      ..lineTo(0, cornerSide)
      ..moveTo(0, sh - cornerSide)
      ..lineTo(0, sh)
      ..lineTo(cornerSide, sh)
      ..moveTo(sw - cornerSide, sh)
      ..lineTo(sw, sh)
      ..lineTo(sw, sh - cornerSide)
      ..moveTo(sw, cornerSide)
      ..lineTo(sw, 0)
      ..lineTo(sw - cornerSide, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BorderPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BorderPainter oldDelegate) => false;
}

class BacgroundPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    final paint = Paint();
    final gradient = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(15, 0, width, height));

    // canvas.drawPaint(gradient);

    paint.color = Colors.teal;
    gradient.color = Colors.grey;


    const heightLine = 5; // your Horizontal line
    const widthLine = 5; // your Vertical line

    Path linePath = Path();
    linePath.addRect(Rect.fromLTRB(15, 15, 30, 30));
    // gradient.shader = LinearGradient(
    //     colors: [Colors.red.withOpacity(0.2), Colors.red.withOpacity(0.8),Colors.red.withOpacity(0.2)]
    // ).createShader(linePath as Rect);
    canvas.drawPath(linePath, gradient);

    for(int i = 1 ; i < height ; i++){
      if(i % heightLine == 0){
        Path linePath = Path();
        linePath.addRect(Rect.fromLTRB(0, i.toDouble(), width, (i+0.3).toDouble()));
        canvas.drawPath(linePath, paint);
      }
    }
    for(int i = 1 ; i < width ; i++){
      if(i % widthLine == 0){
        Path linePath = Path();
        linePath.addRect(Rect.fromLTRB(i.toDouble(), 0 , (i+0.3).toDouble(), height));
        canvas.drawPath(linePath, paint);
      }
    }

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}