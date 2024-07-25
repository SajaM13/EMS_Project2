import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:eventsapp/Network/global.dart';
import 'package:eventsapp/Network/storage.dart';
import 'package:eventsapp/models/getinfo_in_reservation.dart';
import 'package:eventsapp/screens/book.dart';
import 'package:eventsapp/screens/reservations_list.dart';

class checklist extends StatefulWidget {
  List<Foood>? list;
  checklist({
    Key? key,
    this.list,
  }) : super(key: key);

  @override
  State<checklist> createState() => _checklistState();
}

Future<List<GetInfo>> fetchDataList() async {
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

class _checklistState extends State<checklist> {
  late Future<List<GetInfo>> getinfo;
  List<Foood> CheckedFood = [];

  bool isChacked = false;
  @override
  void initState() {
    super.initState();
    getinfo = fetchDataList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: darkpink,
          title: const Text('Choose food'),
        ),
        body: FutureBuilder<List<GetInfo>>(
          future: getinfo,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == null) {
                return const Center(child: Text('Loading ...'));
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final getFood =
                          List<Foood>.from(snapshot.data![index].food);
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Container(
                              child: Column(children: [
                                ...getFood
                                    .map((e) => CheckboxListTile(
                                        value: e.isChecked,
                                        title: Text(e.name),
                                        subtitle: Text(e.price.toString()),
                                        onChanged: (newValue) {
                                          setState(() {
                                            e.isChecked = newValue!;
                                            if (e.isChecked == true) {
                                              CheckedFood.add(e);
                                              print(
                                                  'checked food  :$CheckedFood');
                                            } else {
                                              CheckedFood.remove(e);
                                            }
                                          });
                                        }))
                                    .toList(),
                                Container(
                                  width: 200,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        print('checked list : ${CheckedFood}');
                                        Navigator.of(context).pop(CheckedFood);
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) => addBook(
                                        //               foodList: getFood,
                                        //             )));
                                      },
                                      child: Text('add')),
                                ),
                              ]),
                            ),
                          ),

                          SizedBox(height: 10),

                          Wrap(
                            children: getFood.map((hobby) {
                              if (hobby.isChecked == true) {
                                return Card(
                                  elevation: 3,
                                  color: Color(0xFFFDD5D9),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(hobby.name),
                                  ),
                                );
                              }

                              return Container();
                            }).toList(),
                          ),

                          // Navigator.push(
                          //                       context,
                          //                       MaterialPageRoute(
                          //                           builder: (context) => reservation(

                          //                               )));}, child: Text('Add'))
                        ],
                      );
                    });
              }
            } else if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}'));
            }
            return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator());
          },
        )

        /*SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Choose your hobbies:',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),

            // The checkboxes will be here
            Column(
                children: availableHobbies.map((hobby) {
              return CheckboxListTile(
                  value: hobby["isChecked"],
                  title: Text(hobby["name"]),
                  onChanged: (newValue) {
                    setState(() {
                      hobby["isChecked"] = newValue;
                    });
                  });
            }).toList()),

            // Display the result here
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            Wrap(
              children: availableHobbies.map((hobby) {
                if (hobby["isChecked"] == true) {
                  return Card(
                    elevation: 3,
                    color: Colors.amber,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(hobby["name"]),
                    ),
                  );
                }

                return Container();
              }).toList(),
            )
          ]),
        ),
      ),*/
        );
  }
}
