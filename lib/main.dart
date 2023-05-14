import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'InternetPackage/DailyPackages.dart';
import 'InternetPackage/OtherPackagesDialog.dart';
import 'custom_calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFF28292B),
      statusBarColor: Color(0xFF28292B),
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:CalendarPopupView(),
    );
  }
}


class CalendarPopupView extends StatefulWidget {
  const CalendarPopupView(
      {Key? key,
        this.initialStartDate,
        this.initialEndDate,
        this.onApplyClick,
        this.onCancelClick,
        this.barrierDismissible = true,
        this.minimumDate,
        this.maximumDate})
      : super(key: key);

  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final bool barrierDismissible;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final Function(DateTime, DateTime)? onApplyClick;

  final Function()? onCancelClick;
  @override
  _CalendarPopupViewState createState() => _CalendarPopupViewState();
}

class _CalendarPopupViewState extends State<CalendarPopupView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    if (widget.initialStartDate != null) {
      startDate = widget.initialStartDate;
    }
    if (widget.initialEndDate != null) {
      endDate = widget.initialEndDate;
    }
    animationController?.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: const Color(0x33000000),
        body: AnimatedBuilder(
          animation: animationController!,
          builder: (BuildContext context, Widget? child) {
            return AnimatedOpacity(
              duration: const Duration(milliseconds: 100),
              opacity: animationController!.value,
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  if (widget.barrierDismissible) {
                    Navigator.pop(context);
                  }
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      width: 385,
                      height: 440,
                      decoration: BoxDecoration(
                        color: Color(0x1ACCCCCC),
                        borderRadius:
                        const BorderRadius.all(Radius.circular(24.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: const Offset(4, 4),
                              blurRadius: 8.0),
                        ],
                      ),
                      child: InkWell(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(24.0)),
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            CustomCalendarView(
                              minimumDate: widget.minimumDate,
                              maximumDate: widget.maximumDate,
                              initialEndDate: widget.initialEndDate,
                              initialStartDate: widget.initialStartDate,
                              startEndDateChange: (DateTime startDateData,
                                  DateTime endDateData) {
                                setState(() {
                                  startDate = startDateData;
                                  endDate = endDateData;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
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

