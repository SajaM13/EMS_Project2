import 'dart:convert';
import 'dart:async';
import 'dart:typed_data';
import 'package:eventsapp/Network/global.dart';
import 'package:eventsapp/models/food_model.dart';
//import 'package:eventsapp/providers/auth.dart';
import 'package:eventsapp/providers/foodcontroller.dart';
import 'package:eventsapp/providers/shared.dart';
import 'package:eventsapp/screens/editfoodinfo.dart';
//import 'package:eventsapp/screens/addfood.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class food_screen2 extends StatefulWidget {
  const food_screen2({Key? key}) : super(key: key);

  @override
  State<food_screen2> createState() => _food_screenState();
}

Future<List<Food>> fetchFoodData() async {
  final response = await http.get(
      Uri.parse('http://192.168.43.9:8000/api/guest/food'),
      headers: {'Accept': 'application/json'});

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
    return parsed.map<Food>((item) => Food.fromJson(item)).toList();
    // return Photographers.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load food info');
  }
}

getImage(String image) {
  Uint8List bytes = const Base64Decoder().convert(image);
  // ignore: unnecessary_null_comparison
  if (image == null) {
    return const Text('no Image!');
  }

  return Image.memory(bytes);
}

Future<Food> deleteAlbum(String id) async {
  final http.Response response = await http.delete(
    Uri.parse('http://192.168.1.110:8000/api/guest/food'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
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
    return Food.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a "200 OK response",
    // then throw an exception.
    throw Exception('Failed to delete album.');
  }
}

// ignore: camel_case_types
class _food_screenState extends State<food_screen2> {
  //final pref = Provider.of<Auth>((context), listen: false);

  getPref() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    if (role_id == 1) {
      setState(() {
        role_id = shared.getString("role_id");
        isAdmin = true;
      });
    }
  }

  //Auth instance = Auth();
  shared ins = shared();
  getpref() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    setState(() {
      if (role_id == 1) {
        isAdmin = true;
      }
    });
  }

  late Future<List<Food>> food;
  @override
  void initState() {
    //_getMediaData();
    super.initState();
    // getPref();
    getpref();
    food = fetchFoodData();

    // تهيئة البيانات عند تشغيل الصفحة
  }

  late Uint8List _uint8list;
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final foodprovider = Provider.of<foodController>((context), listen: false);
    // final pref = Provider.of<Auth>((context), listen: false);

    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                  children: const <Widget>[
                    Text('Food List',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0)),
                    SizedBox(width: 10.0),
                  ],
                ),
              ),
              const SizedBox(height: 40.0),
              Stack(children: [
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height - 185.0,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(75.0)),
                      ),
                      child: FutureBuilder<List<Food>>(
                          future: food,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data == null) {
                                return const Center(child: Text('Loading ...'));
                              } else {
                                return GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 190,
                                    childAspectRatio: 0.66,
                                    crossAxisSpacing: 1,
                                  ),
                                  itemCount: snapshot.data?.length,
                                  primary: false,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: <Widget>[
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.all(1),
                                            child: TextButton(
                                              onPressed: () {},
                                              child: Container(
                                                  width: 400,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.3),
                                                            spreadRadius:
                                                                3.0, // radius of shadow
                                                            blurRadius: 5.0)
                                                      ],
                                                      color: Colors.white),
                                                  child: SingleChildScrollView(
                                                    child: Column(children: [
                                                      Stack(
                                                        children: [
                                                          Hero(
                                                              tag: snapshot
                                                                  .data![index]
                                                                  .path,
                                                              child: SizedBox(
                                                                  height: 130.0,
                                                                  width: 190.0,
                                                                  child: getImage(snapshot
                                                                      .data![
                                                                          index]
                                                                      .path))),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 3.0,
                                                      ),
                                                      Text(
                                                          snapshot.data![index]
                                                              .name,
                                                          style: const TextStyle(
                                                              color: Color(
                                                                  0xFF575E67),
                                                              fontSize: 14.0)),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        child: Text(
                                                            snapshot
                                                                .data![index]
                                                                .description,
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .blueGrey,
                                                                fontSize:
                                                                    10.0)),
                                                      ),
                                                      const Divider(
                                                          color: Colors.grey),
                                                      Text(
                                                          '${snapshot.data![index].price}',
                                                          style: const TextStyle(
                                                              color: Color(
                                                                  0xFFCC8053),
                                                              fontSize: 14.0)),
                                                    ]),
                                                  )),
                                            ))
                                      ],
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
                          }),
                    ),
                  ],
                ),
              ]),
            ])));
  }
}
