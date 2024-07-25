import 'dart:convert';

import 'package:eventsapp/Network/storage.dart';
import 'package:eventsapp/models/halls_details.dart';
import 'package:eventsapp/screens/halls_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:eventsapp/Network/addscreen_ui.dart';

Future<HallsDetails> update(
    String id, int phonenumber, int max, int min, int price) async {
  Map<String, String> data = {
    'phonenumber': phonenumber.toString(),
    'max': max.toString(),
    'min': min.toString(),
    'price': price.toString()
  };

  print(data.toString());
  final url = 'http://192.168.43.9:8000/api/hall/$id';

  try {
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      //body: json.encode(data.toString()),
      body: <String, String>{
        //'_methode': 'PUT',
        'contact': phonenumber.toString(),
        'size_max': max.toString(),
        'size_min': min.toString(),
        'chair_price': price.toString()
      },
      //encoding: Encoding.getByName('utf-8')
    );
    // print('heyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy${json.encode(data)}');
    print(response.statusCode);
    print('sss${response.body}');
    if (response.statusCode == 200) {
      print('sss${response.body}');
      return HallsDetails.fromJson(jsonDecode(response.body));

      // If the server did return a 200 OK response,
      // then parse the JSON.
    } else {
      throw Exception('Failed ..');
    }
    // final responseData =

  } catch (e) {
    throw e.toString();
  }
}

Future<HallsDetails> updateDetails(
    String id, int phonenumber, int max, int min, int price) async {
  final response = await http.put(
    Uri.parse('http://192.168.43.9:8000/api/hall/$id'),
    headers: <String, String>{
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: <String, String>{
      'phonenumber': phonenumber.toString(),
      'max': max.toString(),
      'min': min.toString(),
      'price': price.toString()
    },
  );
  print(response.body);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return HallsDetails.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to update album.');
  }
}

class update_Details extends StatefulWidget {
  int? id;
  String? hallname;
  update_Details({
    Key? key,
    this.id,
    this.hallname,
  }) : super(key: key);
  @override
  State<update_Details> createState() => _update_DetailsState();
}

class _update_DetailsState extends State<update_Details> {
  var phoneController = TextEditingController();
  var MinController = TextEditingController();
  var MaxController = TextEditingController();
  var priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image/addscreen.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  AddScreen_UI(
                    lable: 'Phone Number',
                    hint: 'add phone number',
                    message: 'please enter the number',
                    Controller: phoneController,
                    icon: Icons.phone,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AddScreen_UI(
                    lable: 'Min Hall Capacity',
                    hint: 'add capacity',
                    message: 'please enter the capacity',
                    Controller: MinController,
                    icon: Icons.chair_alt_outlined,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AddScreen_UI(
                    lable: 'Max Hall Capacity',
                    hint: 'add capacity',
                    message: 'please enter the capacity',
                    Controller: MaxController,
                    icon: Icons.chair_alt_outlined,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AddScreen_UI(
                    lable: 'Price Per Chair',
                    hint: 'add price',
                    message: 'please enter the price',
                    Controller: priceController,
                    icon: Icons.price_change_outlined,
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0XFFD66E79),
                    ),
                    child: TextButton(
                        child: Text(
                          'UPDATE',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          update(
                              widget.id.toString(),
                              int.parse(phoneController.text),
                              int.parse(MinController.text),
                              int.parse(MaxController.text),
                              int.parse(priceController.text));
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => halles_screen()));
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
