import 'dart:convert';
import 'dart:async';
import 'dart:typed_data';
import 'package:eventsapp/Network/global.dart';
import 'package:eventsapp/Network/storage.dart';
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
class food_screen extends StatefulWidget {
  const food_screen({Key? key}) : super(key: key);

  @override
  State<food_screen> createState() => _food_screenState();
}

Future<List<Food>> fetchFoodData(String searchkeyword, String value) async {
  final response = await http.get(
      Uri.parse(
          'http://192.168.43.9:8000/api/food/?search=$searchkeyword&sort=$value'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });

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
    Uri.parse('http://192.168.43.9:8000/api/food/$id'),
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
    return Food.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a "200 OK response",
    // then throw an exception.
    throw Exception('Failed to delete album.');
  }
}

// ignore: camel_case_types
class _food_screenState extends State<food_screen> {
  //final pref = Provider.of<Auth>((context), listen: false);

  // getPref() async {
  //   SharedPreferences shared = await SharedPreferences.getInstance();
  //   if (role_id == 1) {
  //     setState(() {
  //       role_id = shared.getString("role_id");
  //       isAdmin = true;
  //     });
  //   }
  // }

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
    food = fetchFoodData('', '');

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
        /* appBar: AppBar(
        title: const Text('Halls'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Color(0xFFFDD5D9), Color(0xFFFCABB4)]),
          ),
        ),
      ),*/
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
                            textController: textController,
                            onSuffixTap: () {
                              setState(() {
                                food = fetchFoodData(textController.text, '');
                                textController.clear();
                              });
                              // pop current page
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
                              onPressed: () {
                                setState(() {
                                  food = fetchFoodData('', 'price');
                                  textController.clear();
                                });
                              },
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
                                                                  child: getImage(
                                                                      snapshot
                                                                          .data![
                                                                              index]
                                                                          .path)
                                                                  /*  decoration: BoxDecoration(
                                                                      image: DecorationImage(
                                                                          image: 
                                                                          /* AssetImage(snapshot
                                                                              .data![
                                                                                  index]
                                                                              .path)*/
                                                                          ,
                                                                          fit: BoxFit.fitWidth))*/
                                                                  )),
                                                          Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            50),
                                                                child: isAdmin
                                                                    ? IconButton(
                                                                        onPressed:
                                                                            () async {
                                                                          showModalBottomSheet(
                                                                              backgroundColor: Colors.white,
                                                                              //elevation: 200,
                                                                              context: context,
                                                                              builder: (BuildContext ctx) {
                                                                                return SafeArea(
                                                                                  child: SizedBox(
                                                                                    height: 200,
                                                                                    width: double.infinity,
                                                                                    child: Column(
                                                                                      children: [
                                                                                        const SizedBox(
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
                                                                                                              setState(() {
                                                                                                                deleteAlbum(snapshot.data![index].id.toString());
                                                                                                                Navigator.pop(context); // pop current page
                                                                                                                Navigator.pushReplacementNamed(context, "backtofoodScreen");
                                                                                                              });
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

                                                                                                  /* AlertDialog(
                                                                                            title: Text('Delete items'),
                                                                                            content: Text('Are you sure to delete data'),
                                                                                            actions: [
                                                                                              TextButton(
                                                                                                onPressed: () {
                                                                                                  foodprovider.deleteData(snapshot.data![index].id);
                                                                                                },
                                                                                                child: Text('Yes'),
                                                                                              ),
                                                                                              TextButton(
                                                                                                onPressed: () {
                                                                                                  Navigator.pushNamed(context, '/create');
                                                                                                },
                                                                                                child: Text('No'),
                                                                                              )
                                                                                            ],
                                                                                          );*/
                                                                                                },
                                                                                                child: const Align(
                                                                                                  alignment: Alignment.topLeft,
                                                                                                  child: Text(
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
                                                                                                          builder: (context) => editFoodInfo(
                                                                                                                id: snapshot.data![index].id,
                                                                                                              )));
                                                                                                },
                                                                                                child: const Align(
                                                                                                  alignment: Alignment.topLeft,
                                                                                                  child: Text(
                                                                                                    'Edit item',
                                                                                                    style: TextStyle(fontSize: 18),
                                                                                                  ),
                                                                                                )),
                                                                                            trailing: const Icon(Icons.edit)),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              });
                                                                        },
                                                                        icon: const Icon(
                                                                            Icons.more_vert))
                                                                    : Text('')),
                                                          ),
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
                                        //const SizedBox(height: 30.0),
                                        /*  SizedBox(
                                            width: MediaQuery.of(context).size.width -
                                                50.0,
                                            height:
                                                MediaQuery.of(context).size.height -
                                                    50.0,
                                            child: GridView.count(
                                              crossAxisCount: 2,
                                              primary: false,
                                              crossAxisSpacing:
                                                  1, // space between each other
                                              //  mainAxisSpacing: 1.0, //space between each row
                                              childAspectRatio: 0.6,
                                              children: <Widget>[
                                                Padding(
                                                    padding: const EdgeInsets.all(1),
                                                    child: TextButton(
                                                        onPressed: () {
                                                          /* Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CookieDetail(
                          assetPath: imgPath,
                          cookieprice:price,
                          cookiename: name
                        )));*/
                                                        },
                                                        child: Container(
                                                            width: 400,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      color: Colors
                                                                          .grey
                                                                          .withOpacity(
                                                                              0.3),
                                                                      spreadRadius:
                                                                          3.0, // radius of shadow
                                                                      blurRadius: 5.0)
                                                                ],
                                                                color: Colors.white),
                                                            child:
                                                                SingleChildScrollView(
                                                              child:
                                                                  Column(children: [
                                                                Hero(
                                                                    tag: snapshot
                                                                        .data![index]
                                                                        .path,
                                                                    child: Container(
                                                                        height: 130.0,
                                                                        width: 140.0,
                                                                        decoration: BoxDecoration(
                                                                            image: DecorationImage(
                                                                                image: AssetImage(snapshot
                                                                                    .data![index]
                                                                                    .path),
                                                                                fit: BoxFit.fitWidth)))),
                                                                const SizedBox(
                                                                  height: 3.0,
                                                                ),
                                                                Text(
                                                                    snapshot
                                                                        .data![index]
                                                                        .name,
                                                                    style: const TextStyle(
                                                                        color: Color(
                                                                            0xFF575E67),
                                                                        fontSize:
                                                                            14.0)),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          left: 4),
                                                                  child: Text(
                                                                      snapshot
                                                                          .data![
                                                                              index]
                                                                          .description,
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .blueGrey,
                                                                          fontSize:
                                                                              10.0)),
                                                                ),
                                                                const Divider(
                                                                    color:
                                                                        Colors.grey),
                                                                Text(
                                                                    '${snapshot.data![index].price}',
                                                                    style: const TextStyle(
                                                                        color: Color(
                                                                            0xFFCC8053),
                                                                        fontSize:
                                                                            14.0)),
                                                              ]),
                                                            ))))
                                              ],
                                            )),*/
                                        //  const SizedBox(height: 15.0)
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
                isAdmin
                    ? SizedBox(
                        width: double.infinity,
                        height: 850,
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
                                  Navigator.pushNamed(context, 'addfood');
                                },
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container()
              ]),
            ])));
  }
}
/*
  Widget _buildCard(
      String name, String price, String imgPath, String decription) {
    return Padding(
        padding: const EdgeInsets.all(1),
        child: TextButton(
            onPressed: () {
              /* Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CookieDetail(
                    assetPath: imgPath,
                    cookieprice:price,
                    cookiename: name
                  )));*/
            },
            child: Container(
                width: 400,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 3.0, // radius of shadow
                          blurRadius: 5.0)
                    ],
                    color: Colors.white),
                child: SingleChildScrollView(
                  child: Column(children: [
                    Hero(
                        tag: imgPath,
                        child: Container(
                            height: 130.0,
                            width: 140.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(imgPath),
                                    fit: BoxFit.fitWidth)))),
                    const SizedBox(
                      height: 3.0,
                    ),
                    Text(name,
                        style: const TextStyle(
                            color: Color(0xFF575E67), fontSize: 14.0)),
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(decription,
                          style: const TextStyle(
                              color: Colors.blueGrey, fontSize: 10.0)),
                    ),
                    const Divider(color: Colors.grey),
                    Text(price,
                        style: const TextStyle(
                            color: Color(0xFFCC8053), fontSize: 14.0)),
                  ]),
                ))));
  }
}*/
/* Card(
        margin: EdgeInsets.all(10),
        color: Colors.pink.shade50,
        shadowColor: Colors.blueGrey,
        elevation: 20,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage("assets/image/login.png"),
              ),
              title: Text(
                "Cub Cake",
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text('choclate cub cake with strawberry sauce'),
            ),
          ],
        ),
      ),*/

/*ListView.builder(itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextButton(
                onPressed: () {},
                child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/image/cake1.jpg"),
                            fit: BoxFit.fitWidth))),
              ),
              Card(
                elevation: 10,
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 8, left: 8, bottom: 4),
                      child: Text(
                        'CheeseCake',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 0, left: 8, bottom: 4),
                      child: Text(
                          'Strawberry cheesecake filled with berry sauce',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 12)),
                    ),
                    /* Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/image/cake1.jpg"),
                                fit: BoxFit.fill))),*/
                    /* ListTile(
                      title: const Text('CheeseCake'),
                      subtitle: Text(
                        'Strawberry cheesecake filled with berry sauce',
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),*/
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '10000 S.P',
                        style: TextStyle(color: darkpink),
                      ),
                    ),
                    /* ListTile(
                      title: Text(
                        '10000 S.P',
                        style: TextStyle(color: darkpink),
                      ),
                    ),*/
                  ],
                ),
              ),
            ],
          ),
        );
      }*/
