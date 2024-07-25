import 'dart:convert';
import 'dart:async';
//import 'package:eventsapp/Network/api.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:eventsapp/Network/global.dart';
import 'package:eventsapp/models/photographers_model.dart';
import 'package:eventsapp/providers/photographer.dart';
import 'package:eventsapp/screens/addphotographers.dart';
import 'package:eventsapp/screens/editphotoginfo.dart';
import 'package:eventsapp/screens/login_screen.dart';
import 'package:http/http.dart' as http;
//import 'package:eventsapp/models/halls_var.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class media_screen2 extends StatefulWidget {
  const media_screen2({Key? key}) : super(key: key);

  @override
  State<media_screen2> createState() => _media_screenState();
}

// ignore: camel_case_types
class _media_screenState extends State<media_screen2> {
  //API _api = API();

//test
  // ignore: non_constant_identifier_names
  Future<List<Photographers>> FetchPhotographersData(
      String searchKeyword) async {
    var response = await http
        .get(Uri.parse('http://192.168.43.9:8000/api/guest/camerawoman'));
    if (response.statusCode == 200) {
      print(response.body);
      List<Photographers> photoglistnew = photographersFromJson(response.body);
      return photoglistnew;

      // If the server did return a 200 OK response,
      // then parse the JSON.
      // ignore: avoid_print
    } else {
      throw Exception('Failed to load photographers info');
    }
  }

//  final _photographerlist =
//       Provider.of<addPhotographers>((context), listen: false);
  late Future<List<Photographers>> photograph;
  List<Photographers> photographerList = [];

  //media_screen obj = media_screen();
  _getData() async {
    photographerList = await FetchPhotographersData('');
    setState(() {});
  }

  @override
  void initState() {
    _getData();

    //_getMediaData();
    super.initState();

    // تهيئة البيانات عند تشغيل الصفحة
  }

  TextEditingController searchtextController = TextEditingController();

  int _counter = 0;
  // List<String> listofphotographers =
  //     Provider.of<addPhotographers>(context,listen: true).addPhotographer;
  @override
  Widget build(BuildContext context) {
    //
    final _photographerlist =
        Provider.of<addPhotographers>((context), listen: false);
    //
    return Scaffold(
        body: Container(
            color: const Color(0xFFFDD5D9),
            child: ListView(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.menu),
                      color: Colors.white,
                      onPressed: () async {
                        return showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Access Denied !'),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: const <Widget>[
                                    const Text(
                                        'please login to access this tab'),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('ok'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => super.widget));
                                  },
                                ),
                                TextButton(
                                  child: const Text('signIn'),
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const login_screen()));
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [],
                      ),
                    ),
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
                          ],
                        ))
                  ],
                ),
              ),
              SizedBox(height: 25.0),
              Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Row(
                  children: const <Widget>[
                    Text('Photographers',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0)),
                    //  SizedBox(width: 10.0),
                  ],
                ),
              ),
              SizedBox(height: 40.0),
              Stack(children: [
                Column(children: [
                  Container(
                      height: MediaQuery.of(context).size.height - 185.0,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(75.0)),
                      ),
                      child: ListView.builder(
                        itemCount: photographerList.length,
                        primary: false,
                        itemBuilder: (BuildContext context, int index) {
                          Photographers photog = photographerList[index];
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 25),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    elevation: 10,
                                    shadowColor: Colors.grey.withOpacity(0.3),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: Text(
                                            photog.name,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            photog.description,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        ListTile(
                                          title: Text("contact number",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 16, color: pink1)),
                                          subtitle: Text(
                                            photog.contact,
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      )),
                ]),
              ]),
            ])));
  }
}
