import 'dart:convert';

import 'package:eventsapp/Network/storage.dart';
import 'package:eventsapp/models/offers_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:eventsapp/Network/global.dart';
import 'package:eventsapp/models/reservation_model.dart';

// ignore: camel_case_types
class offers_screen extends StatefulWidget {
  offers_screen({
    Key? key,
  }) : super(key: key);

  @override
  State<offers_screen> createState() => _reservationState();
}

Future<List<off>> fetchoffers() async {
  final response = await http
      .get(Uri.parse('http://192.168.43.9:8000/api/offer/'), headers: {
    'Accept': 'application/json',
    'Authorization': 'Bearer $token'
  });
  print(response.statusCode);
  print('sssssssss${response.body}');
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
    throw Exception('Failed to load food info');
  }
}

// ignore: camel_case_types
class _reservationState extends State<offers_screen> {
  late Future<List<off>> listt;
  // late List<Reservation> bookList = [];

  @override
  void initState() {
    //_getMediaData();
    super.initState();
    listt = fetchoffers();

    // تهيئة البيانات عند تشغيل الصفحة
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        backgroundColor: darkpink,
        title: Text("Hall\'s Offers"),
      ),
      body: FutureBuilder<List<off>>(
        future: listt,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == null) {
              return const Center(child: Text('Loading ...'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                primary: false,
                itemBuilder: (context, index) {
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
                                  snapshot.data![index].name,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text('descreiption :'),
                              subtitle: Text(
                                snapshot.data![index].description,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text('Discount Value :'),
                              subtitle: Text(
                                snapshot.data![index].value.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text('Offer StartDate'),
                              subtitle: Text(
                                snapshot.data![index].startDate.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text('Offers End Date'),
                              subtitle: Text(
                                snapshot.data![index].endDate.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
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
