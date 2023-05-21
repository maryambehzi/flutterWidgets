import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widgets/CardBalance/CollapsingScreen.dart';
import 'InternetPackage/DailyPackages.dart';
import 'InternetPackage/OtherPackagesDialog.dart';

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


//Internet Package
late _MyInternetHomePageState homePageState;

class MyInternetHomePage extends StatefulWidget {
  const MyInternetHomePage({Key? key}) : super(key: key);

  @override
  State<MyInternetHomePage> createState() {
    homePageState = _MyInternetHomePageState();
  return homePageState;}
}

class _MyInternetHomePageState extends State<MyInternetHomePage> {

  var dynamicTitle = "انواع دیگر";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Color(0xFF28292B),
        body: Padding(
          padding: const EdgeInsets.all(17.0),
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.only(top:54.0),
                child: Image.asset("images/back_drop_down.png"),
              ),

              const Padding(
                padding: EdgeInsets.only(top:24.0, bottom: 24.0),
                child: Center(child: Text('انتخاب بسته اینترنتی',
                style: TextStyle(color: Colors.white, fontWeight : FontWeight.w600 ,fontSize: 16.0),)),
              ),
              Container(
                alignment: AlignmentDirectional.topCenter,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xff191A1B),
                  borderRadius: BorderRadius.circular(37.0)
                ),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                  child: TabBar(
                    indicator: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.black
                      ),
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    labelPadding: const EdgeInsets.only(left : 5,right : 5),
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.white,
                    tabs: [
                      const Tab(text: 'روزانه',),
                      const Tab(text: 'هفتگی',),
                      const Tab(text: 'ماهانه',),
                      Tab(
                        child: Container(
                          width: 102,
                          height: 34,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: const Color(0xFF454545)
                            ),
                            color: const Color(0x1ACCCCCC),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            // textDirection: TextDirection.rtl,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Image(image: AssetImage("images/arrow_down.png"),),
                              const Icon( Icons.keyboard_arrow_down),
                              // SizedBox(width: 1),
                              SizedBox(
                                width: 53,
                                child: Text(
                                        "$dynamicTitle",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ) ,
              ),
              const Expanded(child: TabBarView(
                children: [
                  DailyPackages(),
                  Center(child: Text('Weekly Packages', style: TextStyle(color: Colors.white),),),
                  Center(child: Text('Monthly Packages', style: TextStyle(color: Colors.white),),),
                  OtherPackagesDialog(),
                ],
              ))
            ],
          ),
        )
      ),
    );
  }
}

