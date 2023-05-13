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
      home:const Directionality(
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
          title: const Text('انتخاب بسته اینترنتی'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(17.0),
          child: Column(
            children: [
              Container(
                alignment: AlignmentDirectional.topCenter,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xff191A1B),
                  borderRadius: BorderRadius.circular(25.0)
                ),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                  child: TabBar(
                    indicator: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: const Color(0xFFEDC76C)
                      ),
                      color: const Color(0x804A411C),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    labelPadding: const EdgeInsets.only(left : 5,right : 5),
                    labelColor: const Color(0xFFEDC76C),
                    unselectedLabelColor: Colors.white,
                    tabs: [
                      const Tab(text: 'روزانه',),
                      const Tab(text: 'هفتگی',),
                      const Tab(text: 'ماهانه',),
                      Tab(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
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

