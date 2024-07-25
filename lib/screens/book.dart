import 'dart:async';
import 'dart:convert';

import 'package:eventsapp/Network/storage.dart';
import 'package:eventsapp/screens/checklist.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:eventsapp/Network/addscreen_ui.dart';
import 'package:eventsapp/Network/checklist.dart';
import 'package:eventsapp/Network/global.dart';
import 'package:eventsapp/models/getinfo_in_reservation.dart';
import 'package:eventsapp/models/reservation_model.dart';
import 'package:eventsapp/screens/halls_list_screen.dart';
import 'package:eventsapp/screens/reservations_list.dart';

/*Future<List<Reservation>> postData(Reservation data) async {
  http.Response? response;
  response = await http.post(
      Uri.parse('http://192.168.1.110:8000/api/camerawoman'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data.toJson()));

  /*<String, String>{
          'name': data.name,
          'desciption': data.description,
          'contact': data.contact,
        }*/

  if (response.statusCode == 201) {
    print(response.body);
    print(data);
    return json.decode(response.body);
    //return Photographers.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to post data');
  }
}*/

Future<void> postDataa(
    int id,
    String type,
    int chairsNum,
    String startDate,
    String userName,
    // DateTime issue,
    String camname,
    int vid,
    int photi,
    List<Foood> list) async {
  Map<String, dynamic> data = {
    'user_name': userName,
    'id': id, //
    'type': type,
    'start_date': startDate,
    'chairs_num': chairsNum,
    'cam_name': camname, //
    'film_num': vid,
    'photo_num': photi,
    'foods': list //
  };
  final response = await http.post(
    Uri.parse('http://192.168.43.9:8000/api/reservation/'),
    headers: <String, String>{
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: json.decode(data.toString()),
    // body: <String, dynamic>{
    //   'user_name': userName,
    //   'id': id, //
    //   'type': type,
    //   'start_date': startDate,
    //   'chairs_num': chairsNum,
    //   'cam_name': camname, //
    //   'film_num': vid,
    //   'photo_num': photi,
    //   'foods': list
    // }
  );
  print(response.statusCode);
  print('sss${response.body}');

  //encoding: Encoding.getByName('utf-8')

  print('sss${response.body}');

  if (response.statusCode == 200) {
    //   Map<String, dynamic> resp = jsonDecode(response.body);
    // ignore: avoid_print
    print(response.body);
    return json.decode(response.body);

    // If the server did return a 200 OK response,
    // then parse the JSON.
  } else {
    // print('${resp['message']}');
    throw Exception('Failed ..');
  }
}

//get
/*Future <List<GetInfo>>getFData() async {
  try {
    final response = await http.get(Uri.parse(
        'https://7bd57481-2a38-4847-a1dc-7d43f3e55d0f.mock.pstmn.io/api/reservation/getinfo'));
    print(response.statusCode);
    print('------------------');
    if (response.statusCode == 200) {
      print(response.body);

      Iterable iterable = jsonDecode(response.body);
      List<GetInfo> foodlist = iterable.map((e) => GetInfo.fromJson(e)).toList();
      return foodlist;
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // ignore: avoid_print
    } else {
      throw Exception('Failed to load photographers info');
    }
  } catch (e) {
    return e.toString();
  }
}*/

/*Future<List<GetInfo>> fetchFoodData() async {
  final response = await http.get(Uri.parse(
      'https://f8ed2526-6be3-4f31-bc62-70bd043c9c90.mock.pstmn.io/api/food?search=Strawberry&sort=price'));

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
    return parsed.map<GetInfo>((item) => GetInfo.fromJson(item)).toList();
    // return Photographers.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load food info');
  }
}
*/

Future<List<GetInfo>> fetchDataaaList() async {
  final response = await http.get(
      Uri.parse('http://192.168.43.9:8000/api/reservation/getinfo'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      });
  print('state--- : ${response.statusCode}');
  print('response ---- : ${response.body}');
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
    return parsed.map<GetInfo>((item) => GetInfo.fromJson(item)).toList();

    // return Photographers.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load food info');
  }
}

class addBook extends StatefulWidget {
  String? hallname;
  int id;
  List<Food>? foodList;
  int? maxvalue;
  int? minValue;

  addBook({
    Key? key,
    this.hallname,
    required this.id,
    this.foodList,
    this.maxvalue,
    this.minValue,
  }) : super(key: key);
  @override
  State<addBook> createState() => _addBookState();
}

class _addBookState extends State<addBook> {
  late Future<List<GetInfo>> reserv;
  halles_screen hallinstance = halles_screen();
  String title = 'food name';
  String task = '';
  var formkey = GlobalKey<FormState>();
  var taskItem;
  int counter = 0;
  DateTime? currentdate;
  bool isChacked = true;
  List<Foood> _selectedFood = [];
  // late Future<List<GetInfo>> getinfo;

  //late DynamicList listClass; //من هون الايرور تبع الليست
  _datepicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2023),
    ).then((value) {
      setState(() {
        currentdate = value!;
      });
    });
  }

  List<CheckBoxListTileModel> checkFoodList = CheckBoxListTileModel.getFood();
  List<Map> foodList = [
    {"name": "cheescake", "isChecked": false},
    {"name": "juice", "isChecked": false},
    {
      "name": "iceCream",
      "isChecked": false,
    },
    {"name": "cupCake ", "isChecked": false},
    {"name": "Dunats", "isChecked": false}
  ];
  List<String> items = [
    'Aya Ahmeed',
    'Muhammed Kashmiri',
    'Muhammed Sumbol',
    'idk'
  ];
  List<String> Times = [
    'AM : from 2-6',
    'PM : from 7-11 ',
  ];
  List<String> FilmPrice = [
    'AM : from 2-6',
    'PM : from 7-11 ',
  ];
  String? selectedvalue;
  String? selectedTime = 'AM : from 2-6';
  late Future<Cam> camera;
  //late Future<List<GetInfo>> getinfo;

  var nameController = TextEditingController();
  var occasionController = TextEditingController();
  var numchairController = TextEditingController();
  var usernameController = TextEditingController();
  var phoneController = TextEditingController();
  var dateController = TextEditingController();
  var vidnumController = TextEditingController();
  var photonumController = TextEditingController();

  String dropValue = 'choose photographer';
  /* List<Food> food_list = [];
  _getData() async {
    food_list = await getFData();
    setState(() {});
  }*/

  void initstate() {
    super.initState();
    fetchDataaaList();

    formkey = GlobalKey();

    // _getData();
    // taskItem = Provider.of<ListProvider>(context, listen: false);
    // listClass = DynamicList(taskItem.list);
  }

  getList() {
    foodList.forEach((element) {});
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //  var _checked;
    //int? index;

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color(0XFFE4AAAD),
      // ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/image/addscreen.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<List<GetInfo>>(
          future: fetchDataaaList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == null) {
                return Text('Loading...');
              } else {
                return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    final getcam = List<Cam>.from(snapshot.data![index].cam);
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              width: 250,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE4AAAD),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'BOOK NOW!!!',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(
                                        color: Colors.black,
                                      ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: lightpink,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  widget.hallname!,
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AddScreen_UI(
                                lable: 'User Name',
                                hint: 'add your name',
                                message: 'please enter your name',
                                Controller: usernameController,
                                icon: Icons.person,
                                textInputType: TextInputType.text,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AddScreen_UI(
                                lable: 'Phone number',
                                hint: 'please add your phone number',
                                message: 'please enter phone number ',
                                Controller: phoneController,
                                icon: Icons.phone,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AddScreen_UI(
                                  lable: 'Event Type',
                                  hint:
                                      'what type of party do you want to celebrate notice please the available types',
                                  message: 'please enter the name of the hall',
                                  Controller: occasionController,
                                  icon: Icons.holiday_village),
                            ),
                            /* Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: lightpink,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                              'here i am gonna show available events in this hall'),
                        ),
                      ),
                    ),*/

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AddScreen_UI(
                                lable: 'Number of chairs',
                                hint: 'add the number',
                                message: 'please enter the number',
                                Controller: numchairController,
                                icon: Icons.chair_alt_outlined,
                                textInputType: TextInputType.number,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AddScreen_UI(
                                lable: 'Number of Photo_film',
                                hint: 'add the number',
                                message: 'please enter the number',
                                Controller: photonumController,
                                icon: Icons.photo_album_rounded,
                                textInputType: TextInputType.number,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                'Note That one photo_film consists of 150 photo',
                                style: TextStyle(color: Colors.blueGrey),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AddScreen_UI(
                                lable: 'Number of video_film',
                                hint: 'add the number',
                                message: 'please enter the number',
                                Controller: vidnumController,
                                icon: Icons.video_call_rounded,
                                textInputType: TextInputType.number,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                'Note That one video_film consists of 8 videos',
                                style: TextStyle(color: Colors.blueGrey),
                              ),
                            ),
                            SizedBox(
                              height: 80.0,
                              child: TextButton(
                                onPressed: () {
                                  _datepicker();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 180,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE4AAAD),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Click here to pick a date',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: Text(
                                    currentdate.toString(),
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.date_range,
                                  color: pink2,
                                )
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Choose reservation time',
                                style: TextStyle(color: darkpink),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8, bottom: 8, right: 4, left: 8),
                              child: Container(
                                height: 35,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: DropdownButton<String>(
                                        dropdownColor: Colors.blueGrey.shade200,
                                        value: selectedTime,
                                        icon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.white,
                                        ),
                                        elevation: 16,
                                        //  style: const TextStyle(color: Colors.deepPurple),

                                        onChanged: (item) {
                                          setState(() {
                                            selectedTime = item!;
                                          });
                                        },
                                        items: Times.map((item) =>
                                            DropdownMenuItem<String>(
                                              value: item,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  item,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            )).toList()),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  ' Note That: Reservation Canceled Automatically After 3 Days',
                                  style: Theme.of(context).textTheme.headline6),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  final popData = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              checklist(list: _selectedFood)));
                                  setState(() {
                                    _selectedFood = popData;
                                  });
                                  print(_selectedFood[0].name);
                                  print(popData[0]);
                                  /*  showModalBottomSheet(
                            elevation: 200,
                            backgroundColor: Colors.white,
                            context: context,
                            builder: (BuildContext ctx) {
                              return SafeArea(
                                child: FutureBuilder<List<GetInfo>>(
                                  future: reserv,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data == null) {
                                        return const Center(
                                            child: Text('Loading ...'));
                                      } else {
                                        ListView.builder(
                                            itemCount: snapshot.data!.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              final food = List<Foood>.from(
                                                  snapshot.data![index].food);
                                              return StatefulBuilder(
                                                builder: (BuildContext context,
                                                    StateSetter setState) {
                                                  return Column(
                                                    children: [
                                                      ...food.map((element) {
                                                        return Column(
                                                          children: [
                                                            CheckboxListTile(
                                                              activeColor:
                                                                  lightpink,
                                                              title: Text(
                                                                  element.name),
                                                              subtitle: Text(
                                                                  element.price
                                                                      .toString()),
                                                              controlAffinity:
                                                                  ListTileControlAffinity
                                                                      .platform,
                                                              value: isChacked,
                                                              onChanged: (bool?
                                                                  value) {
                                                                setState(() {
                                                                  isChacked =
                                                                      value!;
                                                                });
                                                              },
                                                              checkColor:
                                                                  Colors.black,
                                                            ),
                                                          ],
                                                        );
                                                      }).toList(),
                
                                                      /*  CheckboxListTile(
                                                  activeColor: lightpink,
                                                  title: const Text('Food Name'),
                                                  subtitle: const Text('price'),
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .platform,
                                                  value: isChacked,
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      isChacked = value!;
                                                    });
                                                  },
                                                  checkColor: Colors.black,
                                                ),*/
                                                      /*  Column(
                                                  children: foodList.map((item) {
                                                    return CheckboxListTile(
                                                        value: item["isChecked"],
                                                        title: item['name'],
                                                        onChanged: (val) {
                                                          setState(() {
                                                            item["isChecked"] =
                                                                val!;
                                                          });
                                                        });
                                                  }).toList(),
                                                ),*/
                                                      const Divider(),
                                                    ],
                                                  );
                                                },
                                              );
                
                                              /*CheckboxListTile(
                                                activeColor: lightpink,
                                                dense: true,
                                                title: Text(
                                                    checkFoodList[index].name),
                                                subtitle: Text(
                                                    checkFoodList[index]
                                                        .description),
                                                value:
                                                    checkFoodList[index].isCheck,
                                                onChanged: (value) {
                                                  setState(() {
                                                    isChacked = value!;
                                                  });
                                                }),
                                            const Divider(),
                                          
                                        );*/
                                            });
                                      }
                                    } else if (snapshot.hasError) {
                                      return Center(
                                          child: Text('${snapshot.error}'));
                                    }
                                    return Container(
                                        alignment: Alignment.center,
                                        child:
                                            const CircularProgressIndicator());
                                  },
                                ),
                              );
                              // navigateTo(context, Food());
                            },
                          );*/
                                },
                                child: Row(
                                  children: const [
                                    Text(
                                      'Choose Food',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(Icons.arrow_drop_down)
                                  ],
                                ),
                              ),
                            ),
                            Wrap(
                              children: _selectedFood.map((item) {
                                return Card(
                                  elevation: 5,
                                  color: lightpink,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(item.name),
                                  ),
                                );
                              }).toList(),
                            ),
                            //  Row(children: [Container(child :Text(widget.foodList![index].name),)],),
                            // Column(
                            //   children: [
                            //     Expanded(
                            //       child: ListView.builder(
                            //           itemCount: 2,
                            //           physics: NeverScrollableScrollPhysics(),
                            //           itemBuilder: (context, index) => Container(
                            //                 child: Text(widget.foodList![index].name),
                            //               )),
                            //     ),
                            //   ],
                            // ),
                            // Row(
                            //   children: widget.foodList!.map((hobby) {
                            //     if (hobby.isChecked == true) {
                            //       return Card(
                            //         elevation: 3,
                            //         color: Color(0xFFFDD5D9),
                            //         child: Padding(
                            //           padding: const EdgeInsets.all(8.0),
                            //           child: Text(hobby.name),
                            //         ),
                            //       );
                            //     }

                            //     return Container();
                            //   }).toList(),
                            // ),
                            /*  Column(
                      children: [
                        futubuilder(
                          itemBuilder: (BuildContext context, int index) {
                            if (checkFoodList[index].isCheck == true) {
                              return Container(
                                color: lightpink,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(checkFoodList[index].name),
                                ),
                              );
                            }
                
                            return Container();
                          },
                        ),
                      ],
                    ),*/
                            /* Wrap(
                      children: foodList.map((item) {
                        if (item["isChecked"] == true) {
                          return Card(
                            elevation: 5,
                            color: lightpink,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(item["name"]),
                            ),
                          );
                        }
                        return Container();
                      }).toList(),
                    ),*/
                            //Text(_selectedFood[index].name),
                            // Row(
                            //   children: [
                            //     //   Container(child: Text(_selectedFood[index].name)),
                            //   ],
                            // ),

                            const Padding(
                              padding: EdgeInsets.all(8),
                              child: Text('Choose photographer :',
                                  style: TextStyle(color: Colors.blueGrey)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8, bottom: 8, right: 4, left: 8),
                              child: Container(
                                height: 35,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: DropdownButton<String>(
                                        dropdownColor: Colors.blueGrey.shade200,
                                        value: selectedvalue,
                                        icon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.white,
                                        ),
                                        elevation: 16,
                                        //  style: const TextStyle(color: Colors.deepPurple),

                                        onChanged: (item) {
                                          setState(() {
                                            selectedvalue = item!;
                                          });
                                        },
                                        items: getcam
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item.name,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      item.name,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ))
                                            .toList()),
                                  ),
                                ),
                              ),
                            ),
                            /*     Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                     
                        },
                        child: Row(
                          children: const [
                            Text(
                              'Choose photographers',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.arrow_drop_down)
                          ],
                        ),
                      ),
                    ),*/

                            Padding(
                              padding: const EdgeInsets.only(left: 70.0),
                              child: Container(
                                width: 180,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE4AAAD),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextButton(
                                    onPressed: () {
                                      // postData(Reservation(
                                      //     id: widget.id,
                                      //     type: occasionController.text,
                                      //     chairsNum: int.parse(
                                      //         numchairController.text),
                                      //     startDate: currentdate,
                                      //     userName: usernameController.text,
                                      //     hallName: widget.hallname.toString(),
                                      //     issueDate: currentdate,
                                      //     camName: selectedvalue.toString(),
                                      //     filmNum:
                                      //         int.parse(vidnumController.text),
                                      //     photoNum: int.parse(
                                      //         photonumController.text),
                                      //     foods: _selectedFood as List<Food>));
                                      postDataa(
                                          widget.id,
                                          occasionController.text,
                                          int.parse(numchairController.text),
                                          currentdate.toString(),
                                          usernameController.text,
                                          selectedvalue.toString(),
                                          int.parse(vidnumController.text),
                                          int.parse(photonumController.text),
                                          _selectedFood);
                                    },
                                    child: const Text('Save Book',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ))),
                              ),
                            ),

                            /*  CheckboxListTile(
                          title: Text('Photographer Name'),
                          secondary: Icon(Icons.photo_camera_front_outlined),
                          controlAffinity: ListTileControlAffinity.platform,
                          value: _checked,
                          onChanged: (value) {
                            setState(() {
                              _checked = value;
                            });
                          },
                          checkColor: Colors.black,
                        ),*/

                            /*  Consumer<ListProvider>(
                      builder: (context, Provider, ListTile) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: listClass.list.length,
                            itemBuilder: buildList,
                          ),
                        );
                      },
                    ),*/
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            } else if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}'));
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget buildList(BuildContext context, int index) {
    counter++;
    return Dismissible(
      key: Key(
        counter.toString(),
      ),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        taskItem.deleteItem(index);
      },
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFFDD5D9),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const ListTile(
          // title: Text(listClass.list[index].toString()),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
      ),
    );
  }

  /* void saveTask(String task) {
    Provider.of<TaskProvider>(context, listen: false).addTasks(task);
  }*/

}
