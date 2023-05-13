import 'package:flutter/material.dart';
import 'DailyPackages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
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
        appBar: AppBar(
          title: Text('انتخاب بسته اینترنتی'),
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                alignment: AlignmentDirectional.topCenter,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(25.0)
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    color: Colors.yellow[200],
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(text: 'روزانه',),
                    Tab(text: 'هفتگی',),
                    Tab(text: 'ماهانه',),
                    Tab(text: 'انواع دیگر',),
                  ],
                ) ,
              ),
              const Expanded(child: TabBarView(
                children: [
                  DailyPackages(),
                  Center(child: Text('Weekly Packages'),),
                  Center(child: Text('Monthly Packages'),),
                  Center(child: Text('Other Packages'),),
                ],
              ))
            ],
          ),
        )
      ),
    );
  }
}

