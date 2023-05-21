import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

import 'TopHeader.dart';


class CollapsingScreen extends StatefulWidget {
  const CollapsingScreen({super.key});

  @override
  _CollapsingScreen createState() => _CollapsingScreen();
}

class _CollapsingScreen extends State<CollapsingScreen>
    with TickerProviderStateMixin {



  @override
  void initState() {


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: _buildReceipt(),
        )

    );
  }



  Widget _buildReceipt() {


    return Container(
      color: Color(0xFF28292B),
      child: Expanded(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // DialogHeader(title: "دریافت موجودی و 10 تراکنش"),
            DialogHeader(title: "دریافت موجودی و 10 تراکنش"),
            TopHeader(),
            BelowTopHeader(),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: 10,
                      (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: _StatementItem(),
                    );
                  },
                ))
          ],
        ),
      ),
    );
  }

}


class BelowTopHeader extends StatelessWidget {


  const BelowTopHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverPersistentHeader(
      delegate: TransactionHeaderDelegate(),
    );
  }
}

class TransactionHeaderDelegate extends SliverPersistentHeaderDelegate {


  const TransactionHeaderDelegate();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 50,
      color: Color(0XFF28292B),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 9),
              child: Text(
              "۱۴۰۱/۰۶/۱۲ - ۱۸:۴۳",
                style: TextStyle(fontSize:14 ,color: Color(0xFFCCCCCC) )

              ),
            ),
            Spacer(),
            Padding(
                padding: EdgeInsets.only(right: 9),
                child: Text("تراکنش های اخیر", style: TextStyle(fontSize:14 ,color: Color(0xFFCCCCCC) ),)),

          ],
        ),
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

class _StatementItem extends StatelessWidget {


  const _StatementItem();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
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
              // Container(
              //   width: double.infinity,
              //   padding: EdgeInsets.all(10),
              //   color: Color(0xFF191A1B),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       const Spacer(),
              //       Text("+ ۶۰٬۰۰۰", style: TextStyle(color: Color(0xFF36F1CD)),),
              //     ],
              //   ),
              // )
            ],
          )
      ),
    );
  }
}
