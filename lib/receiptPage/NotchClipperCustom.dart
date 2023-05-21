import 'package:flutter/material.dart';


class ShareReceiptPage extends StatefulWidget {
  const ShareReceiptPage({Key? key}) : super(key: key);

  @override
  State<ShareReceiptPage> createState() => _ShareReceiptPageState();
}

class _ShareReceiptPageState extends State<ShareReceiptPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              padding: EdgeInsets.only(top: 96.0),
              child: Text("کارت به کارت با موفقیت انجام شد", style: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w500),),
            ),

            //green container receipt
            Padding(
              padding: const EdgeInsets.only(right: 24.0, left: 24.0, top: 154.0),
              child: Container(
                width: 279,
                height: 295,
                decoration: const BoxDecoration(
                  color: Color(0xFF2A4A45),
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30),),
                ),
              ),
            ),

            //green container receipt gradiant
            Padding(
              padding: const EdgeInsets.only(right: 24.0, left: 24.0, top: 154.0),
              child: Container(
                width: 279,
                height: 295,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30),),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: <Color>[
                        Color(0xBB1A1D1F),
                        Colors.transparent,
                      ],)
                ),
              ),
            ),

            // //receipt_out_put_gradiant
            Padding(
              padding: const EdgeInsets.only(top: 154.0),
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
              padding: const EdgeInsets.only(top: 154.0),
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
                // child: Column(
                //   children: [
                //     const ListTile(
                //       title: Text('انواع دیگر نوع بسته', style: TextStyle(color: Colors.white ),),
                //     ),
                //     ListTile(
                //       title: const Text('بسته‌های شگفت انگیز', style: TextStyle(color: Colors.white),),
                //
                //     ),
                //     ListTile(
                //       title: const Text('بسته‌های مکالمه', style: TextStyle(color: Colors.white),),
                //     ),
                //     ListTile(
                //       title: const Text('یکساله', style: TextStyle(color: Colors.white),),
                //     ),
                //   ],
                // ),
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