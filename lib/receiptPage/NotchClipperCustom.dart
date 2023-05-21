import 'package:flutter/material.dart';
import 'package:widgets/CardBalance/TopHeader.dart';


class ShareReceiptPage extends StatefulWidget {
  const ShareReceiptPage({Key? key}) : super(key: key);

  @override
  State<ShareReceiptPage> createState() => _ShareReceiptPageState();
}

class _ShareReceiptPageState extends State<ShareReceiptPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D0E0E),
      body: Padding(
        // padding: const EdgeInsets.only(top: 102.0, right: 32.0, left: 32.0, bottom: 64.0),
        padding: const EdgeInsets.only(top: 42),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [

            // notch
            Padding(
              padding: const EdgeInsets.only(left: 33.0),
              child: ClipPath(
                clipper: NotchClipper(),
                child: Container(
                  color: Color(0xFF232526),
                ),
              ),
            ),

            //payment status icon
            Padding(
              padding: const EdgeInsets.only(top: 34.0),
              child: Image.asset("images/failed_smiley.png", width: 40.0,height: 40.0,),
            ),

            // Payment description
            const Padding(
              padding: EdgeInsets.only(top: 85.0),
              child: Text("کارت به کارت با موفقیت انجام شد", style: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w500),),
            ),

            Padding(
              padding: const EdgeInsets.only(right: 24.0, left: 24.0, top: 144.0),
              child: Container(
                height: 280,
                child: DashWidget(
                    width: 260,
                    cornerRadius: 24,
                    dashColor: Color(0xFF232526),
                    punchPosition: 85,
                    boxShadow: const BoxShadow(color: Colors.transparent),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xff324A48), Color(0xff32393D)]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Row(
                              children: const [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 16.0),
                                    child: Text(
                                      " ریال ۴۶۰،۰۰۰",
                                      style: TextStyle(fontSize: 12, color: Color(0xFFCCCCCC), fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 16.0),
                                  child: Text(
                                    ":مبلغ",
                                    style: TextStyle(fontSize: 12, color: Color(0xFFCCCCCC), fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: const [
                              Expanded(
                                child: Text(
                                    "هدیه احمدی",
                                    style: TextStyle(fontSize: 12, color: Color(0xFFCCCCCC), fontWeight: FontWeight.w600),
                                  ),
                              ),
                              Text(
                                  ":صاحب کارت",
                                  style: TextStyle(fontSize: 12, color: Color(0xFFCCCCCC), fontWeight: FontWeight.w400),
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: const [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 20.0),
                                  child: Text(
                                    "بانک سامان",
                                    style: TextStyle(fontSize: 12, color: Color(0xFFCCCCCC), fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: Text(
                                  ":بانک",
                                  style: TextStyle(fontSize: 12, color: Color(0xFFCCCCCC), fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: const [
                              Expanded(
                                child: Text(
                                    "IR۸۹۰۹۵۸ ۰۰۰۰۹۶۸۸۵۵۵۵۷۷۰۲۲۱",
                                    style: TextStyle(fontSize: 12, color: Color(0xFFCCCCCC), fontWeight: FontWeight.w600),
                                  ),
                              ),
                              Text(
                                  ":شماره شبا",
                                  style: TextStyle(fontSize: 12, color: Color(0xFFCCCCCC), fontWeight: FontWeight.w400),
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: const [
                              Expanded(
                                child: Text(
                                    " ۲٬۰۰۰ ریال",
                                    style: TextStyle(fontSize: 12, color: Color(0xFFCCCCCC), fontWeight: FontWeight.w600),
                                  ),
                              ),
                              Text(
                                  ":کارمزد",
                                  style: TextStyle(fontSize: 12, color: Color(0xFFCCCCCC), fontWeight: FontWeight.w400),
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: const [
                              Expanded(
                                child: Text(
                                    "۱۴۰۱/۰۶/۱۲ - ۱۸:۴۳",
                                    style: TextStyle(fontSize: 12, color: Color(0xFFCCCCCC), fontWeight: FontWeight.w600),
                                  ),
                              ),
                              Text(
                                  ":تاریخ و زمان",
                                  style: TextStyle(fontSize: 12, color: Color(0xFFCCCCCC), fontWeight: FontWeight.w400),
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: const [
                              Expanded(
                                child: Text(
                                    "۱۸۲۷۶۴۸۹۰۱",
                                    style: TextStyle(fontSize: 12, color: Color(0xFFCCCCCC), fontWeight: FontWeight.w600),
                                  ),
                              ),
                              Text(
                                  ":شماره پیگیری",
                                  style: TextStyle(fontSize: 12, color: Color(0xFFCCCCCC), fontWeight: FontWeight.w400),
                                ),
                            ],
                          ),
                        ),
                        ],
                    ),
                ),
              ),
            ),

            // //receipt_out_put_gradiant
            Padding(
              padding: const EdgeInsets.only(top: 144.0),
              child: Container(
                width: 295,
                height: 20,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(24.0)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Colors.black,
                        Colors.transparent,
                      ],)
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 440.0),
              child: Container(
                width: 280,
                height: 70,
                decoration: BoxDecoration(
                  color: Color(0x1ACCCCCC),
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


class NotchClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 113);
    path.conicTo(0, 66, 44, 63, 2);
    path.lineTo(82, 63);
    path.conicTo( 125, 63,145, 32, 1 );
    path.conicTo( 169, 10,198, 32, 1 );
    path.conicTo( 212, 63,276, 63, 1 );
    path.lineTo(314, 63);
    path.conicTo(343, 66, 343, 113, 2);
    path.lineTo(343, 498);
    path.conicTo(343, 525, 314, 528, 2);
    path.lineTo(44, 528);
    path.conicTo(0, 525, 0, 511, 2);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

}


class ReceiptClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 113);
    path.conicTo(0, 66, 44, 63, 2);
    path.lineTo(82, 63);
    path.conicTo( 125, 63,145, 32, 1 );
    path.conicTo( 169, 10,198, 32, 1 );
    path.conicTo( 212, 63,276, 63, 1 );
    path.lineTo(314, 63);
    path.conicTo(343, 66, 343, 113, 2);
    path.lineTo(343, 498);
    path.conicTo(343, 525, 314, 528, 2);
    path.lineTo(44, 528);
    path.conicTo(0, 525, 0, 511, 2);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

}