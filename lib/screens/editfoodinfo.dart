import 'dart:async';
import 'dart:convert';

import 'package:eventsapp/Network/storage.dart';
import 'package:eventsapp/models/food_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:eventsapp/Network/addscreen_ui.dart';
import 'package:eventsapp/Network/global.dart';
import 'package:eventsapp/models/photographers_model.dart';

class editFoodInfo extends StatefulWidget {
  int? id;
  editFoodInfo({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  State<editFoodInfo> createState() => _editFoodInfoState();
}

/*Future<Photographers> updateData(String desc, String contact) async {
  final response = await http.put(
    Uri.parse(
        'https://7bd57481-2a38-4847-a1dc-7d43f3e55d0f.mock.pstmn.io/api/camerawoman/5'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'description': desc, 'contact': contact}),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.body);
    return Photographers.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to update album.');
  }
}*/
Future<Food> updateFood(String id, String desc, double price) async {
  Map<String, String> data = {
    'description': desc,
    'price': price.toString(),
  };

  print(data.toString());
  final url = 'http://192.168.43.9:8000/api/food/$id';

  try {
    final response = await http.put(
      Uri.parse(url),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      //body: json.encode(data.toString()),
      body: <String, String>{'description': desc, 'price': price.toString()},
      //encoding: Encoding.getByName('utf-8')
    );
    print('heyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy${json.encode(data)}');
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('sss${response.body}');
      return Food.fromJson(jsonDecode(response.body));

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

class _editFoodInfoState extends State<editFoodInfo> {
  var descController = TextEditingController();
  var priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/image/addscreen.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AddScreen_UI(
                  lable: 'decription',
                  hint: 'add new decription',
                  message: 'enter descripption',
                  Controller: descController,
                  icon: Icons.description),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AddScreen_UI(
                  lable: 'Price',
                  hint: 'add new price',
                  message: 'enter price',
                  Controller: priceController,
                  icon: Icons.price_change),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              width: 120,
              //  width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: darkpink,
                borderRadius: BorderRadius.circular(100),
              ),
              child: TextButton(
                onPressed: () {
                  updateFood(widget.id.toString(), descController.text,
                      double.parse(priceController.text));
                  setState(() {
                    Navigator.pop(context); // pop current page
                    Navigator.pushReplacementNamed(context, "backtofoodScreen");
                  });
                },
                child: const Text('Edit',
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
