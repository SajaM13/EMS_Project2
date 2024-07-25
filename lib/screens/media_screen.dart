import 'dart:convert';
import 'dart:async';
//import 'package:eventsapp/Network/api.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:eventsapp/Network/global.dart';
import 'package:eventsapp/Network/storage.dart';
import 'package:eventsapp/models/photographers_model.dart';
import 'package:eventsapp/providers/photographer.dart';
import 'package:eventsapp/providers/shared.dart';
import 'package:eventsapp/screens/addphotographers.dart';
import 'package:eventsapp/screens/editphotoginfo.dart';
import 'package:http/http.dart' as http;
//import 'package:eventsapp/models/halls_var.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class media_screen extends StatefulWidget {
  const media_screen({Key? key}) : super(key: key);

  @override
  State<media_screen> createState() => _media_screenState();
}

// ignore: camel_case_types
class _media_screenState extends State<media_screen> {
  //API _api = API();

//test
  // ignore: non_constant_identifier_names
  Future<List<Photographers>> FetchPhotographersData(
      String searchKeyword) async {
    var response = await http.get(
        Uri.parse(
            'http://192.168.43.9:8000/api/camerawoman/search?value=$searchKeyword'),
        headers: {'Authorization': 'Bearer $token'});
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

  Future<Photographers> deleteAlbum(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('http://192.168.43.9:8000/api/camerawoman/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
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
      return Photographers.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a "200 OK response",
      // then throw an exception.
      throw Exception('Failed to delete album.');
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
                      onPressed: () {},
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          AnimSearchBar(
                            suffixIcon: Icon(Icons.check),
                            width: 220,
                            textController: searchtextController,
                            onSuffixTap: () {
                              setState(() {
                                // searchBar(textController.text);

                                print(searchtextController);
                                FetchPhotographersData(
                                    searchtextController.text);
                              });
                              Navigator.pop(context); // pop current page
                              Navigator.pushReplacementNamed(
                                  context, "backtomediaScreen");
                            },
                          )
                        ],
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
                                          trailing: isAdmin
                                              ? IconButton(
                                                  icon: Icon(Icons.more_vert),
                                                  onPressed: () async {
                                                    showModalBottomSheet(
                                                        backgroundColor:
                                                            Colors.white,
                                                        //elevation: 200,
                                                        context: context,
                                                        builder:
                                                            (BuildContext ctx) {
                                                          return SafeArea(
                                                            child: SizedBox(
                                                              height: 200,
                                                              width: double
                                                                  .infinity,
                                                              child: Column(
                                                                children: [
                                                                  SizedBox(
                                                                    height: 15,
                                                                  ),
                                                                  ListTile(
                                                                      title: TextButton(
                                                                          onPressed: () async {
                                                                            return showDialog<void>(
                                                                              context: context,
                                                                              barrierDismissible: false, // user must tap button!
                                                                              builder: (BuildContext context) {
                                                                                return AlertDialog(
                                                                                  title: const Text('Delete Item'),
                                                                                  content: SingleChildScrollView(
                                                                                    child: ListBody(
                                                                                      children: const <Widget>[
                                                                                        Text('are you sure you want to delete data'),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  actions: <Widget>[
                                                                                    TextButton(
                                                                                      child: const Text('Yes'),
                                                                                      onPressed: () {
                                                                                        print('----------------');
                                                                                        print(photog.id);
                                                                                        setState(() {
                                                                                          deleteAlbum(photog.id.toString());
                                                                                          Navigator.pop(context); // pop current page
                                                                                          Navigator.pushReplacementNamed(context, "backtomediaScreen");
                                                                                        });

                                                                                        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => super.widget));
                                                                                      },
                                                                                    ),
                                                                                    TextButton(
                                                                                      child: const Text('No'),
                                                                                      onPressed: () {
                                                                                        Navigator.of(context).pop();
                                                                                      },
                                                                                    ),
                                                                                  ],
                                                                                );
                                                                              },
                                                                            );
                                                                          },
                                                                          child: const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              'Delete item',
                                                                              style: TextStyle(fontSize: 18),
                                                                            ),
                                                                          )),
                                                                      trailing: const Icon(Icons.delete)),
                                                                  const Divider(),
                                                                  ListTile(
                                                                    title: TextButton(
                                                                        onPressed: () {
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                  builder: (context) => editphotog(
                                                                                        id: photog.id,
                                                                                      )));
                                                                        },
                                                                        child: const Align(
                                                                          alignment:
                                                                              Alignment.topLeft,
                                                                          child:
                                                                              Text(
                                                                            'Edit item',
                                                                            style:
                                                                                TextStyle(fontSize: 18),
                                                                          ),
                                                                        )),
                                                                    trailing:
                                                                        const Icon(
                                                                            Icons.edit),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                    // _photographerlist
                                                    //     .deleteData(photog.id);

                                                    /* bool response =
                                                  await deleteData(photog.id);
                                              if (response) {
                                                Navigator.pop(context, true);
                                              } else {
                                                Navigator.pop(context, false);
                                              }*/
                                                    /* return showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title:
                                                          Text('Delete items'),
                                                      content: Text(
                                                          'Are you sure to delete data'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            _photographerlist
                                                                .deleteData(
                                                                    photog.id);
                                                          },
                                                          child: Text('Yes'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pushNamed(
                                                                context,
                                                                '/create');
                                                          },
                                                          child: Text('No'),
                                                        )
                                                      ],
                                                    );
                                                  });*/
                                                  },
                                                )
                                              : Text(''),
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

                  /* Container(
                    child: Consumer<addPhotographers>(
                      builder: (_, value, __) => ListView.builder(
                          itemCount: value.add.length,
                          itemBuilder: (BuildContext context, int index) {
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
                                              value.photographerlist[index].name,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            subtitle: Text(
                                              value.photographerlist[index]
                                                  .description,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                          ListTile(
                                            title: Text("contact number",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 16, color: pink1)),
                                            subtitle: Text(
                                              value.photographerlist[index]
                                                  .contact,
                                              textAlign: TextAlign.left,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  ),*/
                ]),
                isAdmin
                    ? SizedBox(
                        width: double.infinity,
                        height: 900,
                        child: Center(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: FloatingActionButton(
                                backgroundColor: darkpink,
                                tooltip: ' add a product',
                                child: const Icon(
                                  Icons.add,
                                  color: Color(0xFFEDE7F6),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/first');
                                },
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ]),
            ])));
  }
  /*  FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == null) {
                    return const Center(child: Text('Loading ...'));
                  } else {
                    return 
                    Consumer<photographerslist>(
                      builder: (context, value, child) => ListView.builder(
                          itemCount: _photographerlist.add.length,
                          itemBuilder: (BuildContext context, int index) {
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
                                              value.name,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            subtitle: Text(
                                              value.desc,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                          ListTile(
                                            title: Text("contact number",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: pink1)),
                                            subtitle: Text(
                                              value.contact,
                                              textAlign: TextAlign.left,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    );
                  }
                } else if (snapshot.hasError) {
                  return Center(child: Text('${snapshot.error}'));
                }
                return Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator());
              },
            ),*/
  /* */

}
