import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:http/http.dart' as http;

import 'package:eventsapp/models/halls_details.dart';

class calendar extends StatefulWidget {
  List<String>? times;
  calendar({
    Key? key,
    this.times,
  }) : super(key: key);

  @override
  State<calendar> createState() => _calendarState();
}

class _calendarState extends State<calendar> {
  Future<HallsDetails> getData() async {
    final response = await http.get(Uri.parse(
        'https://b2076ef5-00b8-42cf-bd41-3be85e8a6b01.mock.pstmn.io/api/hall/2'));

    if (response.statusCode == 200) {
      return HallsDetails.fromJson(jsonDecode(response.body));
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Halls info');
    }
  }

  // late Future<HallsDetails> futurecalendar;

  @override
  void initState() {
    super.initState();
    // futurecalendar = getData();
  }

  DateTime? selectedDay;
  List<CleanCalendarEvent>? selectedEvent;

  Map<DateTime, List<CleanCalendarEvent>> events = {
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day): [
      CleanCalendarEvent(
        //اسم الايفينت
        'Wedding  ',
        //توقيت الحفلة
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 8, 0),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 12, 0),
        //
        description: 'A Special event',
        color: Color(0XFFD66E79),
      ),
    ],
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2):
        [
      CleanCalendarEvent(
        //
        'Second Event ',
        //
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 10, 0),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 12, 0),
        color: Color(0XFFD66E79),
      ),
      CleanCalendarEvent(
        ' Third Event ',
        //
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 14, 30),
        //
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 17, 0),
        color: Color(0XFFD66E79),
      ),
    ],
  };

  // void handleDate(date) {
  //   setState(() {
  //     selectedDay = date;
  //     selectedEvent = events[selectedDay] ?? [];
  //   });
  //   print(selectedDay);
  // }

  /*@override
  void initState() {
    selectedEvent = events[selectedDay] ?? [];
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calendar'),
          centerTitle: true,
          backgroundColor: Color(0XFFE4AAAD),
        ),
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: Calendar(
                    startOnMonday: true,
                    selectedColor: Color(0XFFE4AAAD),
                    todayColor: Colors.blue,
                    eventColor: Colors.red,
                    eventDoneColor: Colors.amber,
                    bottomBarColor: Colors.deepOrange,
                    onRangeSelected: (range) {
                      print('selected Day ${range.from}, ${range.to}');
                    },
                    onDateSelected: (date) {
                      setState(() {
                        selectedDay = date;
                        selectedEvent = events[selectedDay] ?? [];
                      });
                    },
                    events: events,
                    isExpanded: true,
                    dayOfWeekStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.black12,
                      fontWeight: FontWeight.w100,
                    ),
                    bottomBarTextStyle: TextStyle(
                      color: Colors.white,
                    ),
                    hideBottomBar: false,
                    hideArrows: false,
                    weekDays: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                  ),
                ))));
  }
}
