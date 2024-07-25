// ignore_for_file: must_be_immutable

import 'package:eventsapp/Network/addscreen_ui.dart';
import 'package:eventsapp/Network/storage.dart';
import 'package:eventsapp/models/photographers_model.dart';
import 'package:eventsapp/providers/photographer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
/*Future postData(String name, String desc, String cont) async {
  try {
    final response = await http.post(
        Uri.parse(
            'https://7bd57481-2a38-4847-a1dc-7d43f3e55d0f.mock.pstmn.io/api/camerawoman'),
        body: {'name': name, 'description': desc, 'contact': cont});

    /*<String, String>{
          'name': data.name,
          'desciption': data.description,
          'contact': data.contact,
        }*/

    if (response.statusCode == 201) {
      print(response.body);
      return response.body;
      //return Photographers.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error!');
    }
  } catch (e) {
    return e.toString();
  }
}*/
Future<List<Photographers>> postData(Photographers data) async {
  var response = await http.post(
      Uri.parse('http://192.168.43.9:8000/api/camerawoman/'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: <String, String>{
        'name': '${data.name}',
        'contact': '${data.contact}',
        'description': '${data.description}'
      });

  print('sss${response.body}');

  if (response.statusCode == 201) {
    print(response.body);
    print(data);
    return json.decode(response.body);
    //return Photographers.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to post data').toString();
  }
}

class addPhotographersList extends StatefulWidget {
  const addPhotographersList({Key? key}) : super(key: key);

  @override
  State<addPhotographersList> createState() => _addPhotographersListState();
}

// ignore: camel_case_types
class _addPhotographersListState extends State<addPhotographersList> {
  /*late GlobalKey<FormState> _formkey1;
  late GlobalKey<FormState> _formkey2;

  late GlobalKey<FormState> _formkey3;*/

  //late TextEditingController _controller;
  var ListItem;
  var nameController = TextEditingController();
  var descController = TextEditingController();
  var contController = TextEditingController();
  var availabilityController = TextEditingController();
  Future<void> _sendData() async {
    String name = nameController.text.trim();
    String desc = descController.text.trim();
    String cont = contController.text.trim();
    Photographers photog =
        Photographers(id: 1, name: name, description: desc, contact: cont);
    var provider = Provider.of<addPhotographers>(context, listen: false);
    // String name = nameController.text.trim();
  }

  Future<List<Photographers>>? _photpg;
  @override
  void initState() {
    super.initState();
    /* _formkey1 = GlobalKey();
    _formkey2 = GlobalKey();

    _formkey3 = GlobalKey();*/

    nameController = TextEditingController();
    descController = TextEditingController();
    contController = TextEditingController();
    availabilityController = TextEditingController();
    ListItem = Provider.of<addPhotographers>(context, listen: false);
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    contController.dispose();
    availabilityController.dispose();

    super.dispose();
  }

  final pink1 = const Color(0xFFFCABB4);
  final pink2 = const Color(0xFFFC9BA5);
  final darkpink = const Color(0xFFD66E79);
  final lightpink = const Color(0xFFFDD5D9);
  final pink3 = const Color(0xFFFDBAC1);
  final pink4 = const Color(0xFFE4AAAD);

  @override
  Widget build(BuildContext context) {
    addPhotographers addphotog = Provider.of<addPhotographers>(context);
    final _photographerlist =
        Provider.of<addPhotographers>((context), listen: false);
    return Scaffold(
      body: Container(
        height: 800,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/image/addscreen.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AddScreen_UI(
                    lable: 'name',
                    hint: 'add photographer name',
                    message: 'Enter name',
                    Controller: nameController,
                    icon: Icons.person,
                    textInputType: TextInputType.name,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AddScreen_UI(
                    lable: 'description',
                    hint: 'add photographer description',
                    message: 'Enter description',
                    Controller: descController,
                    icon: Icons.description,
                    textInputType: TextInputType.name,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AddScreen_UI(
                    lable: 'contact info',
                    hint: 'add photographer contact info',
                    message: 'Enter contact',
                    Controller: contController,
                    icon: Icons.contact_phone,
                    textInputType: TextInputType.number,
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: 120,
                  decoration: BoxDecoration(
                    color: Color(0xFFE4AAAD),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                      child: const Text(
                        'Add..',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        postData(Photographers(
                            id: 1,
                            name: nameController.text,
                            description: descController.text,
                            contact: contController.text));
                        Navigator.pop(context); // pop current page
                        Navigator.pushNamed(context, "backtomediaScreen");
                      }),
                ),
                //ListTile()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
