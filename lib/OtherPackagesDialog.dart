import 'package:flutter/material.dart';
import 'dart:ui';

class OtherPackagesDialog extends StatefulWidget {
  const OtherPackagesDialog({Key? key}) : super(key: key);

  @override
  State<OtherPackagesDialog> createState() => _OtherPackagesDialogState();
}

class _OtherPackagesDialogState extends State<OtherPackagesDialog> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showBottomSheet();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: Visibility(
          visible: true,
          child: Text('Other Packages'),
        ),
        onPressed: () {
          showBottomSheet();
        },
      ),
    );
  }

  void showBottomSheet() => showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
                height:250,
              decoration: BoxDecoration(
                color: Color(0xFF28292B),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text('انواع دیگر نوع بسته', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600 ),),
                  ),
                  ListTile(
                    title: Text('بسته‌های شگفت انگیز', style: TextStyle(color: Colors.white),),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text('بسته‌های مکالمه', style: TextStyle(color: Colors.white),),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text('یکساله', style: TextStyle(color: Colors.white),),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      )
  );

}
