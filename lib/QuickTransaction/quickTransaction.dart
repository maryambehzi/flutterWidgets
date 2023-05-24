import 'package:flutter/material.dart';

class QuickTransactionDialog extends StatelessWidget {
  const QuickTransactionDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF28292B),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        )
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "تراکنش سریع",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  width: 1, color: const Color(0xFF454545)),
              color: Colors.black.withOpacity(0.8)
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
              child: Text('افزودن تراکنش سریع', style: TextStyle(color: Colors.white),),
            ),
          ),

          const Padding(
            padding: EdgeInsets.only(top: 11.0),
            child: Text('۳ از ۵ تراکنش', style: TextStyle(color: Color(0xFFCCCCCC)),),
          ),
          Padding(
            padding: const EdgeInsets.only(top:16.0),
            child: Container(
              height: 580,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                  // padding: const EdgeInsets.only(bottom: 40.0),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                      child: Container(
                          width: double.infinity,
                          clipBehavior: Clip.antiAlias,
                          // height: 63.h,
                          decoration: BoxDecoration(
                            color: Color(0xFF191A1B),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                    Container(
                                      width: 115,
                                      height: 32,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.05),
                                          borderRadius: BorderRadius.circular(7)),
                                      child: const Text(
                                        "۱۴۰۱/۰۷/۲۰ - ۱۲:۰۰",
                                        style: TextStyle(fontSize: 14,color: Color(0xFFCCCCCC) ),

                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 90.0),
                                        child: Column(
                                          children: const [
                                            Padding(
                                              padding: EdgeInsets.all(8),
                                              child: Text(
                                                "برداشت از کارت ",
                                                softWrap: true,
                                                textAlign: TextAlign.right,
                                                textDirection: TextDirection.rtl,
                                                style: TextStyle(fontSize: 14,color: Color(0xFFCCCCCC) ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 40.0),
                                              child: Text("+ ۶۰٬۰۰۰", style: TextStyle(color: Color(0xFF36F1CD)),),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 40,
                                      height: 40,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(9),
                                          border: Border.all(color: Color(0xFF454545))),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                      ),
                    );
                  },
                ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}