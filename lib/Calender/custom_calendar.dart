import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';



class CalendarPopupView extends StatefulWidget {
  const CalendarPopupView(
      {Key? key,
        this.onApplyClick,
        this.onCancelClick,
        this.barrierDismissible = true,})
      : super(key: key);

  final bool barrierDismissible;
  final Function(Jalali, Jalali)? onApplyClick;

  final Function()? onCancelClick;
  @override
  State<CalendarPopupView> createState() => _CalendarPopupViewState();
}

class _CalendarPopupViewState extends State<CalendarPopupView>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
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
                        color: const Color(0x1ACCCCCC),
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
                          children: const <Widget>[
                            CustomCalendarView(),
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


class CustomCalendarView extends StatefulWidget {
  const CustomCalendarView(
      {Key? key,})
      : super(key: key);

  @override
  _CustomCalendarViewState createState() => _CustomCalendarViewState();
}

class _CustomCalendarViewState extends State<CustomCalendarView> {
  List<Jalali> dateList = <Jalali>[];
  List<Jalali> successfulPaymentDays = <Jalali>[];
  List<Jalali> failedPaymentDays = <Jalali>[];
  List<Jalali> planedPaymentDays = <Jalali>[];
  Jalali currentMonthDate = Jalali.now();
  Jalali? startDate;
  Jalali? endDate;

  @override
  void initState() {
    setListOfDate(currentMonthDate);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: <Widget>[
            Row(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 17.0, right: 16.0, left: 16.0),
                      child: Container(
                        height: 60,
                        width: 350,
                        decoration: BoxDecoration(
                          color: const Color(0x0DFFFFFF),
                          borderRadius: BorderRadius.circular(17.0),
                        ),
                        child: Row(
                          children: [
                            IconButton(iconSize: 20, icon: const Icon(Icons.keyboard_arrow_right, color: Colors.white,),
                              onPressed: () {
                                setState(() {
                                  if(currentMonthDate.month - 1 < 1) {
                                  currentMonthDate = Jalali(
                                      currentMonthDate.year-1,
                                      12,
                                      1);
                                } else {
                                    currentMonthDate = Jalali(
                                        currentMonthDate.year,
                                        currentMonthDate.month - 1,
                                        1);
                                  }
                                setListOfDate(currentMonthDate);
                                });
                              },
                            ),
                            Center(child: Padding(
                              padding: const EdgeInsets.only(right: 90.0, left: 90.0,),
                              child: Text(
                                convertToArabicNumber(currentMonthDate.year.toString()) + " " +convertToPersianMonth(currentMonthDate.month),
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white),
                              )
                            )),
                            IconButton(iconSize: 20, icon: const Icon(Icons.keyboard_arrow_left, color: Colors.white,),
                              onPressed: () {
                                setState(() {
                                  if(currentMonthDate.month + 1 > 12) {
                                  currentMonthDate = Jalali(
                                      currentMonthDate.year+1,
                                      1,
                                      1);
                                } else {
                                    currentMonthDate = Jalali(
                                        currentMonthDate.year,
                                        currentMonthDate.month + 1,
                                        1);
                                  }
                                setListOfDate(currentMonthDate);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          // ),
          Padding(
            padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8, top: 10),
            child: Row(
              children: getDaysNameUI(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8, left: 8),
            child: Column(
              children: getDaysNoUI(),
            ),
          ),
        ],
      ),
    );
  }

  void setListOfDate(Jalali monthDate) {

    fillSampleData();

    dateList.clear();
    final Jalali newDate = Jalali(monthDate.year, monthDate.month, 1);
    int previousMothDay = 0;

    if (newDate.weekDay < 8) {
      previousMothDay =newDate.weekDay;

      for (int i = 1; i <= previousMothDay; i++) {
        dateList.add(newDate.toDateTime().subtract(Duration(days: previousMothDay - i)).toJalali());
      }
    }
    for (int i = 0; i < (42 - previousMothDay); i++) {
      dateList.add(newDate.toDateTime().add(Duration(days: i + 1)).toJalali());
    }
    debugPrint('maryam: ${dateList}');


  }

  List<Widget> getDaysNameUI() {
    final List<Widget> listUI = <Widget>[];
    for (int i = 0; i < 7; i++) {
      listUI.add(
        Expanded(
          child: Center(
            child: Text(
              convertToPersianWeek(i),
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF87898C)),
            ),
          ),
        ),
      );
    }
    return listUI;
  }

  List<Widget> getDaysNoUI() {
    final List<Widget> noList = <Widget>[];
    int count = 0;
    for (int i = 0; i < dateList.length / 7; i++) {
      final List<Widget> listUI = <Widget>[];
      for (int i = 0; i < 7; i++) {
        final Jalali date = dateList[count];
        listUI.add(
          Expanded(
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 3, bottom: 3),
                      child: Material(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 2,
                              bottom: 2,),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ),
                    //Planed Payment
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Container(
                        decoration: BoxDecoration(
                          color: getIsItPlanedPayment(date) && !getIsItInTheSameMonth(date)
                            ? Color(0x33FFFFFF)
                            : Colors.transparent,
                          borderRadius:
                            const BorderRadius.all(Radius.circular(32.0)),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 1,
                      right: 0,
                      left: 23,
                      child: Container(
                        height: 12,
                        width: 12,
                        decoration: BoxDecoration(
                            color: getIsItPlanedPayment(date) && getIsItInTheSameMonth(date) ? Colors.transparent : getIsItPlanedPayment(date)
                                ? Colors.deepPurple
                                : Colors.transparent,
                            shape: BoxShape.circle),
                      ),
                    ),
                    //The Day is Today
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Jalali.now().day == date.day &&
                              Jalali.now().month == date.month &&
                              Jalali.now().year == date.year
                              // ? Colors.green
                              ? Color(0xFF244341)
                              : Colors.transparent,
                          borderRadius:
                          const BorderRadius.all(Radius.circular(32.0)),
                        ),
                        child: Center(
                          child: Text(
                            convertToArabicNumber(date.day.toString()),
                            style: TextStyle(
                                color: getIsItInTheSameMonth(date)
                                    ? Colors.transparent
                                    :  getIsItPassedDay(date) ? Color(0xFF87898C) : Colors.white,
                                    // ? Colors.white
                                    // : Colors.grey.withOpacity(0.6),
                                fontSize:
                                MediaQuery.of(context).size.width > 360
                                    ? 18
                                    : 16,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ),
                    //Successful Payment dot
                    Positioned(
                      bottom: 10,
                      right: 0,
                      left: getIsItFailedPayment(date) ? 7 : 0,
                      child: Container(
                        height: 6,
                        width: 6,
                        decoration: BoxDecoration(
                            boxShadow: getIsItInTheSameMonth(date) ? null : getIsItSuccessfulPayment(date)
                                ? <BoxShadow>[
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 4,
                                  offset: const Offset(0, 0)),
                            ]
                                : null,
                          color: getIsItInTheSameMonth(date) ? Colors.transparent : getIsItSuccessfulPayment(date)
                              ? Color(0xFF36F1CD)
                          : Colors.transparent,
                            shape: BoxShape.circle),
                      ),
                    ),
                    //Failed Payment Dot
                    Positioned(
                      bottom: 10,
                      right: getIsItSuccessfulPayment(date) ? 7 : 0,
                      left: 0,
                      child: Container(
                        height: 6,
                        width: 6,
                        decoration: BoxDecoration(
                            boxShadow:  getIsItInTheSameMonth(date) ? null : getIsItFailedPayment(date)
                                ? <BoxShadow>[
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 8,
                                  offset: const Offset(0, 0)),
                            ]
                                : null,
                            color: getIsItInTheSameMonth(date) ? Colors.transparent : getIsItFailedPayment(date)
                                ? Color(0xFFFF8C8C)
                                : Colors.transparent,
                            shape: BoxShape.circle),
                        child :Center(
                          child: Text(
                            convertToArabicNumber(date.day.toString()),
                            style: TextStyle(
                                color: getIsItInTheSameMonth(date) ? Colors.transparent : getIsItInTheSameMonth(date)
                                    ? Color(0xFF87898C)
                                    : Colors.transparent,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        count += 1;
      }
      noList.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: listUI,
      ));
    }
    return noList;
  }


  bool getIsItPlanedPayment(Jalali date) {
    if(planedPaymentDays.contains(date))
      return true;
    else
      return false;
  }
  bool getIsItSuccessfulPayment(Jalali date) {
    if(successfulPaymentDays.contains(date))
      return true;
    else
      return false;
  }
  bool getIsItFailedPayment(Jalali date) {
    if(failedPaymentDays.contains(date))
      return true;
    else
      return false;
  }

  bool getIsItPassedDay(Jalali date) {
    if(Jalali.now().toDateTime().isBefore(date.toDateTime())) {
      return false;
    }else if(Jalali.now().day == date.day &&
        Jalali.now().month == date.month &&
        Jalali.now().year == date.year){
      return false;
    } else {
      return true;
    }
  }

  bool getIsItInTheSameMonth(Jalali date) {
    if(currentMonthDate.month == date.month){
      return false;
    } else {
      return true;
    }
  }

  String convertToArabicNumber(String number) {
    String res = '';

    final arabics = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    number.characters.forEach((element) {
      res += arabics[int.parse(element)];
    });

    return res;
  }

  String convertToPersianMonth(int number) {


    switch(number) {
      case 1: {
        return "فرودین" ;
      }
      case 2: {
        return "اردیبهشت" ;
      }
      case 3: {
        return "خرداد" ;
      }
      case 4: {
        return "تیر" ;
      }
      case 5: {
        return "مرداد" ;
      }
      case 6: {
        return "شهریور" ;
      }
      case 7: {
        return "مهر" ;
      }
      case 8: {
        return "آبان" ;
      }
      case 9: {
        return "آذر" ;
      }
      case 10: {
        return "دی" ;
      }
      case 11: {
        return "بهمن" ;
      }
      case 12: {
        return "اسفند" ;
      }
      default: {
        return "اردیبهشت" ;
      }
    }
  }

  String convertToPersianWeek(int number) {


    switch(number) {
      case 0: {
        return "شنبه" ;
      }
      case 1: {
        return "یک‌‌شنبه" ;
      }
      case 2: {
        return "دوشنبه" ;
      }
      case 3: {
        return "سه‌شنبه" ;
      }
      case 4: {
        return "چهارشنبه" ;
      }
      case 5: {
        return "پنج‌شنبه" ;
      }
      case 6: {
        return "جمعه" ;
      }
      default: {
        return "ov" ;
      }
    }
  }

  void fillSampleData(){
    failedPaymentDays.add(Jalali(1402, 1, 26, 0, 0, 0, 0));
    failedPaymentDays.add(Jalali(1402, 1, 1, 0, 0, 0, 0));
    failedPaymentDays.add(Jalali(1402, 1, 5, 0, 0, 0, 0));
    failedPaymentDays.add(Jalali(1402, 1, 31, 0, 0, 0, 0));
    failedPaymentDays.add(Jalali(1402, 2, 1, 0, 0, 0, 0));
    failedPaymentDays.add(Jalali(1402, 2, 5, 0, 0, 0, 0));
    failedPaymentDays.add(Jalali(1402, 2, 24, 0, 0, 0, 0));

    successfulPaymentDays.add(Jalali(1402, 1, 26, 0, 0, 0, 0));
    successfulPaymentDays.add(Jalali(1402, 1, 4, 0, 0, 0, 0));
    successfulPaymentDays.add(Jalali(1402, 1, 19, 0, 0, 0, 0));
    successfulPaymentDays.add(Jalali(1402, 1, 27, 0, 0, 0, 0));
    successfulPaymentDays.add(Jalali(1402, 2, 4, 0, 0, 0, 0));
    successfulPaymentDays.add(Jalali(1402, 2, 19, 0, 0, 0, 0));
    successfulPaymentDays.add(Jalali(1402, 2, 24, 0, 0, 0, 0));



    planedPaymentDays.add(Jalali(1402,2,30,0, 0, 0, 0));
    planedPaymentDays.add(Jalali(1402,3,16,0, 0, 0, 0));
  }

}
