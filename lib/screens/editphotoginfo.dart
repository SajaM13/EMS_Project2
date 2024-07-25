import 'dart:async';
import 'dart:convert';

import 'package:eventsapp/Network/storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:eventsapp/Network/addscreen_ui.dart';
import 'package:eventsapp/Network/global.dart';
import 'package:eventsapp/models/photographers_model.dart';

class editphotog extends StatefulWidget {
  int? id;
  editphotog({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  State<editphotog> createState() => _editphotogState();
}

Future<Photographers> updatePhotog(String id, String desc, String cont) async {
  final response = await http.put(
    Uri.parse('http://192.168.43.9:8000/api/camerawoman/$id'),
    headers: <String, String>{
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    },
    body: <String, String>{'description': desc, 'contact': cont},
  );
  print(response.body);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Photographers.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to update album.');
  }
}

/*Future updaateData(String id, String desc, String cont) async {
  final url = 'http://192.168.43.9:8000/api/camerawoman';
  try {
    final response = await http.put(Uri.parse('$url/$id'),
        body: {'description': desc, 'contact': cont},
        headers: {'Accept': 'application/json'});
    print(response.body);

    if (response.statusCode == 200) {
      print(response.body);
      return true;
      //return Photographers.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update album.');
    }
  } catch (e) {
    return e.toString();
  }
}*/

class _editphotogState extends State<editphotog> {
  var descController = TextEditingController();
  var contController = TextEditingController();
  var availabilityController = TextEditingController();
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
                  lable: 'contact',
                  hint: 'add new contact info',
                  message: 'enter contactInfo',
                  Controller: contController,
                  icon: Icons.contact_phone),
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
                  updatePhotog(widget.id.toString(), descController.text,
                      contController.text);
                  Navigator.pop(context); // pop current page
                  Navigator.pushReplacementNamed(context, "backtomediaScreen");
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
