import 'package:flutter/material.dart';
import 'DailyPackages.dart';
import 'OtherPackagesDialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:Directionality(
        textDirection: TextDirection.rtl,
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Color(0xFF28292B),
        appBar: AppBar(
          title: Text('انتخاب بسته اینترنتی'),
        ),
        body: Padding(
          padding: EdgeInsets.all(17.0),
          child: Column(
            children: [
              Container(
                alignment: AlignmentDirectional.topCenter,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xff191A1B),
                  borderRadius: BorderRadius.circular(25.0)
                ),
                child: Padding(
                    padding: EdgeInsets.all(8.0),
                  child: TabBar(
                    indicator: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Color(0xFFEDC76C)
                      ),
                      color: Color(0x804A411C),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    labelPadding: EdgeInsets.only(left : 5,right : 5),
                    labelColor: Color(0xFFEDC76C),
                    unselectedLabelColor: Colors.white,
                    tabs: [
                      Tab(text: 'روزانه',),
                      Tab(text: 'هفتگی',),
                      Tab(text: 'ماهانه',),
                      Tab(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Image(image: AssetImage("images/arrow_down.png"),),
                            Icon( Icons.keyboard_arrow_down),
                            SizedBox(width: 1),
                            Text('انواع دیگر'),
                          ],
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

