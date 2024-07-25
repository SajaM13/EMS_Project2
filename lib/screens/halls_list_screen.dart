import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:eventsapp/Network/global.dart';
import 'package:eventsapp/Network/storage.dart';
import 'package:eventsapp/providers/language.dart';
import 'package:eventsapp/screens/book.dart';
import 'package:eventsapp/screens/halls_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;

import 'package:eventsapp/models/halls_var.dart';
import 'package:eventsapp/screens/drawer.dart';

// ignore: camel_case_types
class halles_screen extends StatefulWidget {
  halles_screen({
    Key? key,
  }) : super(key: key);

  @override
  State<halles_screen> createState() => _halles_screenState();
}

Future<List<Halls>> fetchHallsData() async {
  final response = await http.get(
      Uri.parse('http://192.168.43.9:8000/api/hall/'),
      headers: {'Authorization': 'Bearer $token'});
  //print('token ----------$token');

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
    return parsed.map<Halls>((item) => Halls.fromJson(item)).toList();
    // return Photographers.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load hall info');
  }
}

getImage(String image) {
  Uint8List bytes = const Base64Decoder().convert(image);
  // ignore: unnecessary_null_comparison
  if (image == null) {
    return Container(
      child: const Text('no Image!'),
    );
  }

  return Image.memory(bytes);
}

// ignore: camel_case_types
class _halles_screenState extends State<halles_screen> {
  late Future<List<Halls>> halls;
  GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  double _ratingValue = 0;

  void initState() {
    //_getMediaData();
    super.initState();
    halls = fetchHallsData();

    // تهيئة البيانات عند تشغيل الصفحة
  }

  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffold,
        drawer: drawer_(),
        body: Container(
          color: const Color(0xFFFDD5D9),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.menu),
                      color: Colors.white,
                      onPressed: () {
                        _scaffold.currentState!.openDrawer();
                      },
                    ),
                    /* TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'book', arguments: '');
                        },
                        child: Text('gooo')),*/
                    SizedBox(
                        width: 50.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.filter_list),
                              color: Colors.white,
                              onPressed: () {},
                            ),
                            /* IconButton(
                              icon: Icon(Icons.menu),
                              color: Colors.white,
                              onPressed: () {},
                            )*/
                          ],
                        ))
                  ],
                ),
              ),
              const SizedBox(height: 25.0),
              Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Row(
                  children: <Widget>[
                    Text(getlang('halls'),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0)),
                    SizedBox(width: 10.0),
                  ],
                ),
              ),
              const SizedBox(height: 40.0),
              Container(
                height: MediaQuery.of(context).size.height - 185.0,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(75.0)),
                ),
                child: FutureBuilder<List<Halls>>(
                    future: halls,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data == null) {
                          return const Center(child: Text('Loading ...'));
                        } else {
                          return ListView.builder(
                              itemCount: snapshot.data?.length,
                              primary: false,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Halls_Details(
                                                        id: snapshot
                                                            .data![index].id,
                                                        hallname: snapshot
                                                            .data![index].name,
                                                      )));
                                          /* Navigator.pushNamed(context, 'book',
                                              arguments: {
                                                snapshot.data![index].id,
                                                snapshot.data![index].name
                                              });*/
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.3),
                                                    spreadRadius:
                                                        3.0, // radius of shadow
                                                    blurRadius: 5.0)
                                              ],
                                            ),
                                            margin: const EdgeInsets.fromLTRB(
                                                15,
                                                0,
                                                20,
                                                0), //padding from left ,top,right and bottom
                                            child: AspectRatio(
                                              aspectRatio: 3 / 1,
                                              child: Row(
                                                children: [
                                                  AspectRatio(
                                                    aspectRatio: 1 / 1,
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child: getImage(snapshot
                                                            .data![index]
                                                            .path)),
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  AspectRatio(
                                                      aspectRatio: 4 / 3,
                                                      child: Column(
                                                        children: [
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            snapshot
                                                                .data![index]
                                                                .name,
                                                            style: const TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          const SizedBox(
                                                            height: 15,
                                                          ),
                                                          Text(
                                                            snapshot
                                                                .data![index]
                                                                .locationName,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .grey),
                                                          ),
                                                          // implement the rating bar
                                                          Row(
                                                            children: [
                                                              RatingBar(
                                                                  itemSize: 25,
                                                                  initialRating:
                                                                      0,
                                                                  direction: Axis
                                                                      .horizontal,
                                                                  allowHalfRating:
                                                                      true,
                                                                  itemCount: 4,
                                                                  ratingWidget:
                                                                      RatingWidget(
                                                                          full:
                                                                              const Icon(
                                                                            Icons.star,
                                                                            color:
                                                                                Color(0xFFFFF38D),
                                                                          ),
                                                                          half:
                                                                              const Icon(
                                                                            Icons.star_half,
                                                                            color:
                                                                                Color(0xFFFFF38D),
                                                                          ),
                                                                          empty:
                                                                              const Icon(
                                                                            Icons.star_outline,
                                                                            color:
                                                                                Color(0xFFFFF38D),
                                                                          )),
                                                                  onRatingUpdate:
                                                                      (value) {
                                                                    setState(
                                                                        () {
                                                                      snapshot
                                                                          .data![
                                                                              index]
                                                                          .rateValue = value;
                                                                    });
                                                                  }),
                                                              const Spacer(),
                                                              Container(
                                                                width: 25,
                                                                height: 20,
                                                                color: const Color(
                                                                    0xFFFDD5D9),
                                                                child: Text(
                                                                  // ignore: unnecessary_null_comparison
                                                                  snapshot.data![index].rateValue !=
                                                                          null
                                                                      ? snapshot
                                                                          .data![
                                                                              index]
                                                                          .rateValue
                                                                          .toString()
                                                                      : 'Rate it!',
                                                                  style: const TextStyle(
                                                                      color: Color(
                                                                          0xFFD66E79),
                                                                      fontSize:
                                                                          15),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          // const SizedBox(height: 25),
                                                          // Display the rate in number
                                                        ],
                                                      ))
                                                ],
                                              ),
                                            )),
                                      )
                                    ],
                                  ),
                                );
                              });
                        }
                      } else if (snapshot.hasError) {
                        return Center(child: Text('${snapshot.error}'));
                      }
                      return Container(
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator());
                    }),
              )
            ],
          ),
        ));
  }
}
