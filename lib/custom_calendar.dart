import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

class CustomCalendarView extends StatefulWidget {
  const CustomCalendarView(
      {Key? key,})
      : super(key: key);

  @override
  _CustomCalendarViewState createState() => _CustomCalendarViewState();
}

class _CustomCalendarViewState extends State<CustomCalendarView> {
  List<DateTime> dateList = <DateTime>[];
  List<DateTime> successfulPaymentDays = <DateTime>[];
  List<DateTime> failedPaymentDays = <DateTime>[];
  List<DateTime> planedPaymentDays = <DateTime>[];
  DateTime currentMonthDate = DateTime.now();
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    setListOfDate(currentMonthDate);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setListOfDate(DateTime monthDate) {
    dateList.clear();
    final DateTime newDate = DateTime(monthDate.year, monthDate.month, 0);
    int previousMothDay = 0;
    if (newDate.weekday < 7) {
      previousMothDay = newDate.weekday;
      for (int i = 1; i <= previousMothDay; i++) {
        dateList.add(newDate.subtract(Duration(days: previousMothDay - i)));
      }
    }
    for (int i = 0; i < (42 - previousMothDay); i++) {
      dateList.add(newDate.add(Duration(days: i + 1)));
    }
    // if (dateList[dateList.length - 7].month != monthDate.month) {
    //   dateList.removeRange(dateList.length - 7, dateList.length);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[

            Row(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 17.0, right: 16.0, left: 16.0),
                      child: Container(
                        height: 42,
                        width: 350,
                        decoration: BoxDecoration(
                          color: const Color(0x0DFFFFFF),
                          borderRadius: BorderRadius.circular(17.0),
                        ),
                        child: Row(
                          children: [
                            IconButton(iconSize: 20, icon: const Icon(Icons.keyboard_arrow_left, color: Colors.white,),
                              onPressed: () {
                                setState(() {
                                  currentMonthDate = DateTime(currentMonthDate.year,
                                      currentMonthDate.month, 0);
                                  setListOfDate(currentMonthDate);
                                });
                              },
                            ),
                            Center(child: Padding(
                              padding: const EdgeInsets.only(right: 90.0, left: 90.0,),
                              child: Text(
                                convertToArabicNumber(currentMonthDate.toJalali().year.toString()) + " " +convertToPersianMonth(currentMonthDate.toJalali().month),
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white),
                              )
                            )),
                            IconButton(iconSize: 20, icon: const Icon(Icons.keyboard_arrow_right, color: Colors.white,),
                              onPressed: () {
                                setState(() {
                                  currentMonthDate = DateTime(currentMonthDate.year,
                                      currentMonthDate.month + 2, 0);
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

  List<Widget> getDaysNameUI() {
    final List<Widget> listUI = <Widget>[];
    for (int i = 0; i < 7; i++) {
      listUI.add(
        Expanded(
          child: Center(
            child: Text(
              convertToPersianWeek(i),
              style: TextStyle(
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
    debugPrint('maryam: $dateList');
    int count = 0;
    for (int i = 0; i < dateList.length / 7; i++) {
      final List<Widget> listUI = <Widget>[];
      for (int i = 0; i < 7; i++) {
        final DateTime date = dateList[count];
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
                          padding: EdgeInsets.only(
                              top: 2,
                              bottom: 2,),
                          child: Container(
                            decoration: BoxDecoration(
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
                          color: getIsItPlanedPayment(date)
                            ? Color(0x33FFFFFF)
                            : Colors.transparent,
                          borderRadius:
                            const BorderRadius.all(Radius.circular(32.0)),
                        ),
                      ),
                    ),

                    //The Day is Today
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Container(
                        decoration: BoxDecoration(
                          color: DateTime.now().day == date.day &&
                              DateTime.now().month == date.month &&
                              DateTime.now().year == date.year
                              // ? Colors.green
                              ? Color(0xFF244341)
                              : Colors.transparent,
                          borderRadius:
                          const BorderRadius.all(Radius.circular(32.0)),
                        ),
                        child: Center(
                          child: Text(
                            convertToArabicNumber(date.toJalali().day.toString()),
                            style: TextStyle(
                                color: getIsItPassedDay(date)
                                    ? Color(0xFF87898C)
                                    : Colors.white,
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
                            boxShadow: getIsItSuccessfulPayment(date)
                                ? <BoxShadow>[
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.6),
                                  blurRadius: 4,
                                  offset: const Offset(0, 0)),
                            ]
                                : null,
                          color:getIsItSuccessfulPayment(date)
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
                            boxShadow: getIsItSuccessfulPayment(date)
                                ? <BoxShadow>[
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.6),
                                  blurRadius: 4,
                                  offset: const Offset(0, 0)),
                            ]
                                : null,
                            color:getIsItFailedPayment(date)
                                ? Color(0xFFFF8C8C)
                                : Colors.transparent,
                            shape: BoxShape.circle),
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


  bool getIsItPlanedPayment(DateTime date) {
    if(planedPaymentDays.contains(date))
      return true;
    else
      return false;
  }
  bool getIsItSuccessfulPayment(DateTime date) {
    if(successfulPaymentDays.contains(date))
      return true;
    else
      return false;
  }
  bool getIsItFailedPayment(DateTime date) {
    if(failedPaymentDays.contains(date))
      return true;
    else
      return false;
  }

  bool getIsItPassedDay(DateTime date) {
    if(DateTime.now().isBefore(date)) {
      return false;
    }else if(DateTime.now().day == date.day &&
        DateTime.now().month == date.month &&
        DateTime.now().year == date.year){
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

/*   final latins = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']; */
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
      case 5: {
        return "شنبه" ;
      }
      case 6: {
        return "یک‌‌شنبه" ;
      }
      case 0: {
        return "دوشنبه" ;
      }
      case 1: {
        return "سه‌شنبه" ;
      }
      case 2: {
        return "چهارشنبه" ;
      }
      case 3: {
        return "پنج‌شنبه" ;
      }
      case 4: {
        return "جمعه" ;
      }
      default: {
        return "ov" ;
      }
    }
  }

}
