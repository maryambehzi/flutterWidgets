import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widgets/Calender/custom_calendar.dart';
import 'package:widgets/CardBalance/CollapsingScreen.dart';
import 'package:widgets/InternetPackage/internetTabBar.dart';
import 'package:widgets/receiptPage/NotchClipperCustom.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFF28292B),
      statusBarColor: Color(0xFF28292B),
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:CollapsingScreen(),
    );
  }
}

// Items That we Can Show as home to Material App
//
//    CollapsingScreen()
//    ShareReceiptPage()
//    CalendarPopupView()
//    MyInternetHomePage()