import 'dart:convert';

import 'package:eventsapp/Network/storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:eventsapp/Network/global.dart';
import 'package:eventsapp/models/reservation_model.dart';

// ignore: camel_case_types
class reservation2 extends StatefulWidget {
  reservation2({
    Key? key,
  }) : super(key: key);

  @override
  State<reservation2> createState() => _reservationState();
}

Future<Reservation> accept() async {
  final response = await http.post(
    Uri.parse('http://192.168.43.9:8000/api/reservation/confirm/1'),
    headers: <String, String>{
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    },
    body: <String, dynamic>{},
  );
  print(response.body);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Reservation.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to update album.');
  }
}

Future<Reservation> decline() async {
  final http.Response response = await http.delete(
    Uri.parse('http://192.168.43.9:8000/api/food/1'),
    headers: <String, String>{
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    },
  );
  print('the new res${response.statusCode}');
  print('the new res${response.body}');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON. After deleting,
    // you'll get an empty JSON `{}` response.
    // Don't return `null`, otherwise `snapshot.hasData`
    // will always return false on `FutureBuilder`.
    return Reservation.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a "200 OK response",
    // then throw an exception.
    throw Exception('Failed to delete album.');
  }
}

Future getData() async {
  try {
    final response =
        await http.get(Uri.parse('http://192.168.43.9:8000/api/reservation/s'));
    if (response.statusCode == 200) {
      print(response.body);

      Iterable iterable = jsonDecode(response.body);
      List<Reservation> bookList =
          iterable.map((e) => Reservation.fromJson(e)).toList();
      return bookList;
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // ignore: avoid_print
    } else {
      throw Exception('Failed to load photographers info');
    }
  } catch (e) {
    return e.toString();
  }
}

Future<List<Reservation>> fetchReservationData() async {
  final response = await http.get(Uri.parse(
      'https://7bd57481-2a38-4847-a1dc-7d43f3e55d0f.mock.pstmn.io/api/reservation/show/3'));

  if (response.statusCode == 200) {
    //final mylist = List<Food>.from(Food).toList();
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
        .map<Reservation>((item) => Reservation.fromJson(item))
        .toList();

    // return Photographers.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('accepted reservations are Empty');
  }
}

// ignore: camel_case_types
class _reservationState extends State<reservation2> {
  late Future<List<Reservation>> book;
  late List<Reservation> bookList = [];
  _getData() async {
    bookList = await getData();
    setState(() {});
  }

  @override
  void initState() {
    //_getMediaData();
    super.initState();
    _getData();
    book = fetchReservationData();

    // تهيئة البيانات عند تشغيل الصفحة
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        backgroundColor: darkpink,
        title: Text("Manage Reservations"),
      ),
      body: FutureBuilder<List<Reservation>>(
        future: book,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == null) {
              return const Center(child: Text('Loading ...'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                primary: false,
                itemBuilder: (context, index) {
                  final reservationFood =
                      List<Food>.from(snapshot.data![index].foods);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFE4AAAD),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 8, bottom: 8, right: 40, left: 40),
                                child: Text(
                                  snapshot.data![index].hallName,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text('user name :'),
                              subtitle: Text(
                                snapshot.data![index].userName,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const ListTile(
                              title: Text('Phone number:'),
                              subtitle: Text(
                                '0999999999',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text('Event Type'),
                              subtitle: Text(
                                snapshot.data![index].type,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text('Reservation Date'),
                              subtitle: Text(
                                snapshot.data![index].startDate.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text('chairs number'),
                              subtitle: Text(
                                snapshot.data![index].chairsNum.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text('Photographer :'),
                              subtitle: Text(
                                snapshot.data![index].camName,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text('Number of Photos :'),
                              subtitle: Text(
                                snapshot.data![index].photoNum.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text('Number of Films :'),
                              subtitle: Text(
                                snapshot.data![index].filmNum.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                ...reservationFood.map((element) {
                                  return Row(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                            color: lightpink,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(element.name),
                                          )),
                                      SizedBox(
                                        width: 15,
                                      )
                                    ],
                                  );
                                }).toList(),
                              ],
                            ),

                            /* reservationFood.forEach(( element) {
                              Container(
                                child: Text(''),
                              );
                            }),*/
                            /*reservationFood.asMap().forEach((index, value) {
                              return Container(child: ,);
                            }),
                            Container(
                              child: Text(),),*/
                            // child:
                            //     Text(snapshot.data![index].foods),
                            /*child: ListView.builder(
                                  itemCount: 1,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        Container(
                                          child: Text('data'),
                                        ),
                                      ],
                                    );
                                  }),*/
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator());
        },
      ),
    );
  }
  /*Column(children: [
      const SizedBox(
        height: 30,
      ),
      /* Container(
            decoration: const BoxDecoration(
              color: lightpink,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Manage reservations',
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),*/

      /* Column(
            children: [
              Container(
                child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('username'),
                                  )),
                              const Divider(),
                              const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('username'),
                                  )),
                              const Divider(),
                              const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('username'),
                                  )),
                              const Divider(),
                              const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('username'),
                                  )),
                              const Divider(),
                              const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('username'),
                                  )),
                              const Divider(),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 120,
                                      child: ElevatedButton(
                                          onPressed: () {}, child: Text('Accept')),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ],
              )*/
    ]));
  */
}
