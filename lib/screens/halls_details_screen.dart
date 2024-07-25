import 'dart:convert';

import 'package:eventsapp/Network/global.dart';
import 'package:eventsapp/Network/storage.dart';
import 'package:eventsapp/models/halls_details.dart';
import 'package:eventsapp/screens/book.dart';
import 'package:eventsapp/screens/calander_screen.dart';
import 'package:eventsapp/screens/update_details.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;

class Halls_Details extends StatefulWidget {
  String hallname;
  int id;
  Halls_Details({
    Key? key,
    required this.hallname,
    required this.id,
  }) : super(key: key);

  @override
  _Halls_DetailsState createState() => _Halls_DetailsState();
}

class _Halls_DetailsState extends State<Halls_Details> {
  /*Future<Details> getData() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.110:8000/api/hall/'));

    if (response.statusCode == 200) {
      return Details.fromJson(jsonDecode(response.body));
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Halls info');
    }
  }
*/
  Future<List<HallsDetails>> fetchHallsDetailsData(int id) async {
    final response = await http
        .get(Uri.parse('http://192.168.43.9:8000/api/hall/$id'), headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    });
    //print('token ----------$token');
    print("stateee${response.statusCode}");
    print('responseee${response.body}');
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // ignore: avoid_print
      print(response.body);
      /* List parsed = json.decode(response.body);
      return parsed
          .map((photographer) => Photographers.fromJson(photographer))
          .toList();*/
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<HallsDetails>((item) => HallsDetails.fromJson(item))
          .toList();
      // return Photographers.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load food info');
    }
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

  void handleDate(date) {
    setState(() {
      selectedDay = date;
      selectedEvent = events[selectedDay] ?? [];
    });
    print(selectedDay);
  }

  double rating = 0;

  late Future<List<HallsDetails>> futureDetails;

  @override
  void initState() {
    super.initState();
    futureDetails = fetchHallsDetailsData(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.hallname),
        backgroundColor: Color(0XFFE4AAAD),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => update_Details(
                              id: widget.id,
                              hallname: widget.hallname,
                            )));
              },
              icon: Icon(Icons.edit))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FutureBuilder<List<HallsDetails>>(
              future: futureDetails,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == null) {
                    return Text('Loading ...');
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final offersList =
                            List<Offer>.from(snapshot.data![index].offers);
                        // final timesList =
                        //     List<String>.from(snapshot.data![index].times);
                        return Stack(children: [
                          Column(children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                height: 190,
                                initialPage: 0,
                                autoPlay: true,
                                enlargeCenterPage: true,
                                enableInfiniteScroll: true,
                                autoPlayInterval: Duration(seconds: 2),
                              ),
                              items: const [
                                Image(
                                  //  image: NetworkImage(''),
                                  image: AssetImage('assets/image/hall1.jpg'),
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                ),
                                Image(
                                  image: AssetImage('assets/image/hall3.jpg'),
                                  // image: AssetImage('assets/images/on_board/image2.jpg'),
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                ),
                                Image(
                                  image: AssetImage('assets/image/hall2.jpg'),
                                  //image: AssetImage('assets/images/on_board/image3.jpg'),
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              width: 300,
                              child: Column(
                                children: [
                                  Row(
                                    children: const [
                                      Icon(Icons.location_on_outlined),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        'LOCATION',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          overflow: TextOverflow.fade,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 30),
                                        child: Text(
                                          snapshot.data![index].locationName,
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    children: const [
                                      Icon(Icons.phone),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        ' Contact With Us',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          overflow: TextOverflow.fade,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 30),
                                        child: Text(
                                          snapshot.data![index].contact
                                              .toString(),
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    children: const [
                                      Icon(Icons.chair_alt_outlined),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        ' Hall Capacity',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          overflow: TextOverflow.fade,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 30),
                                        child: Text(
                                          '${snapshot.data![index].sizeMin.toString()} -- ${snapshot.data![index].sizeMax.toString()} chairs',
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    children: const [
                                      Icon(Icons.price_change_outlined),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        'Price Per Chair',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          overflow: TextOverflow.fade,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 30),
                                        child: Text(
                                          snapshot.data![index].chairPrice
                                              .toString(),
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    'Rating: $rating',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  RatingBar.builder(
                                    minRating: 1,
                                    itemSize: 45,
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    updateOnDrag: true,
                                    onRatingUpdate: (rating) => setState(() {
                                      this.rating = rating;
                                    }),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            // ExpansionTile(
                            //   title: const Text(
                            //     "Hall's Calander",
                            //     style: TextStyle(
                            //         color: Colors.blueGrey, fontSize: 17),
                            //   ),
                            //   children: [
                            //     const Divider(),
                            //     ListTile(
                            //       title: Column(
                            //         children: [
                            //           Calendar(
                            //             startOnMonday: true,
                            //             selectedColor: Color(0XFFE4AAAD),
                            //             todayColor: Colors.blue,
                            //             eventColor: Colors.red,
                            //             eventDoneColor: Colors.amber,
                            //             bottomBarColor: Colors.deepOrange,
                            //             onRangeSelected: (range) {
                            //               print(
                            //                   'selected Day ${range.from}, ${range.to}');
                            //             },
                            //             onDateSelected: (date) {
                            //               return handleDate(date);
                            //             },
                            //             events: events,
                            //             isExpanded: true,
                            //             dayOfWeekStyle: TextStyle(
                            //               fontSize: 15,
                            //               color: Colors.black12,
                            //               fontWeight: FontWeight.w100,
                            //             ),
                            //             bottomBarTextStyle: TextStyle(
                            //               color: Colors.white,
                            //             ),
                            //             hideBottomBar: false,
                            //             hideArrows: false,
                            //             weekDays: [
                            //               'Mon',
                            //               'Tue',
                            //               'Wed',
                            //               'Thu',
                            //               'Fri',
                            //               'Sat',
                            //               'Sun'
                            //             ],
                            //           ),
                            //         ],
                            //       ),
                            //       onTap: () {},
                            //     ),
                            //   ],
                            // ),
                            Container(
                              color: Color(0XFFFDBAC1),
                              width: 300,
                              child: MaterialButton(
                                  child: Text(
                                    'take look on the reservation calander',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             calendar(times: timesList)));

                                    //  MaterialPageRoute(
                                    //                     builder: (context) =>
                                    //                         Halls_Details(
                                    //                           id: snapshot
                                    //                               .data!.,
                                    //                           hallname: snapshot
                                    //                               .data![index].name,
                                    //                         ));
                                  }),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            /*Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Expanded(
                                 
                                    flex: 2,
                                    child: Calendar(
                                      startOnMonday: true,
                                      selectedColor: Color(0XFFE4AAAD),
                                      todayColor: Colors.blue,
                                      eventColor: Colors.red,
                                      eventDoneColor: Colors.amber,
                                      bottomBarColor: Colors.deepOrange,
                                      onRangeSelected: (range) {
                                        print(
                                            'selected Day ${range.from}, ${range.to}');
                                      },
                                      onDateSelected: (date) {
                                        setState(() {
                                          selectedDay = date;
                                          selectedEvent =
                                              events[selectedDay] ?? [];
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
                                      weekDays: [
                                        'Mon',
                                        'Tue',
                                        'Wed',
                                        'Thu',
                                        'Fri',
                                        'Sat',
                                        'Sun'
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),*/
                            SizedBox(
                              height: 20,
                            ),
                            ExpansionTile(
                              //backgroundColor: lightpink.withOpacity(0.3),
                              title: const Text(
                                "Offers ",
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 17),
                              ),
                              children: [
                                const Divider(),
                                ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        ...offersList.map((element) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Column(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xFFE4AAAD),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                            'offer number :${element.id.toString()}'),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    const Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Offers name :',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.blueGrey,
                                                            fontSize: 15),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(element.name,
                                                          style: TextStyle(
                                                              fontSize: 13)),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    const Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Offers description :',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.blueGrey,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          element.description,
                                                          style: TextStyle(
                                                              fontSize: 13)),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    const Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Dicount value :',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.blueGrey,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          element.value
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 13)),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    const Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Offers startDate :',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.blueGrey,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          element.startDate
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 13)),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    const Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Offers EndDate :',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.blueGrey,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          element.endDate
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 13)),
                                                    ),
                                                    const Divider(),
                                                  ],
                                                ),
                                                // Container(
                                                //     decoration: BoxDecoration(
                                                //       borderRadius:
                                                //           BorderRadius.circular(5),
                                                //     ),
                                                //     child: Column(
                                                //       children: [
                                                //         Text(),
                                                //         Text(element.description),
                                                //         Text(
                                                //            ),
                                                //         Text(element.endDate.toString()),
                                                //         Text(element.value.toString())
                                                //       ],
                                                //     )),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ],
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                width: 240,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE4AAAD),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => addBook(
                                                    id: widget.id,
                                                    hallname: widget.hallname,
                                                  )));
                                      //  postData(Reservation(id: 1, type: occasionController.text, chairsNum: int.parse(numchairController.text), startDate: currentdate, userName: usernameController.text, hallName: widget.hallname, issueDate: issueDate, camName: camName, filmNum: filmNum, photoNum: photoNum, adminName: adminName, foods: foods));
                                    },
                                    child: const Text(' Book now',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ))),
                              ),
                            ),
                          ]),
                        ]);
                      },
                    );
                  }
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              }

              //زر العروض بدو نقل للdrawer
              /*    Container(
                  color: Color(0XFFFDBAC1),
                  width: 300,
                  child: MaterialButton(
                      child: Text(
                        'Offers',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        navigateTo(context, Offers_Screen());
                      }),
                ),*/

              ),
        ),
      ),
    );
  }
}
