import 'dart:io';
import 'package:eventsapp/Network/global.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:eventsapp/Network/addscreen_ui.dart';
import 'package:eventsapp/Network/storage.dart';
import 'package:eventsapp/models/food_model.dart';
import 'package:eventsapp/providers/auth.dart';
//import 'package:eventsapp/providers/foodcontroller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class addfood extends StatefulWidget {
  const addfood({Key? key}) : super(key: key);

  @override
  State<addfood> createState() => _addfoodState();
}

// ignore: camel_case_types
class _addfoodState extends State<addfood> {
  /* updatetoken(String token) async {
     SharedPreferences pref = await SharedPreferences.getInstance();
     pref.setString('token', token);
   }*/

  File? file;
  String? image;
  Future<void> pickergallery() async {
    final myfile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      file = File(myfile!.path);
      image = base64Encode(file!.readAsBytesSync());
    });
  }

  Future upload(Food data) async {
    // String token = await updatetoken('token');
    if (file == null) return;
    String base64 = base64Encode(
        file!.readAsBytesSync()); // readAsBytesSync : read file content as list
    // ignore: avoid_print
    print('File :');
    // ignore: avoid_print
    print(file);
    // ignore: avoid_print
    print('base64:' + base64);

    String imagename = file!.path
        .split('/')
        .last; //split : convert the string to array ,it splits when it comes to /
    //and last to bring the last element im list which is image name and its لاحقة
    // ignore: avoid_print
    print('image name is :' + imagename);

    var response = await http.post(
      Uri.parse('http://192.168.43.9:8000/api/food/'),
      headers: <String, String>{'Accept': 'application/json'},
      body: <String, dynamic>{
        'name': '${data.name}',
        'description': '${data.description}',
        'path': base64,
        'price': data.price
      },

      // headers: {'Authorization': 'Bearer $token'}
    );
    print('sss${response.body}');

    // ignore: avoid_print
    print(response);
  }

  Future<List<Food>> addfooooood(Food dataa) async {
    // if (file == null) {
    //   return Text('data');
    // }

    String base64 = base64Encode(
        file!.readAsBytesSync()); // readAsBytesSync : read file content as list

    // ignore: avoid_print
    print('File :');
    // ignore: avoid_print
    print(file);

    // ignore: avoid_print
    print('base64:' + base64);

    String imagename = file!.path
        .split('/')
        .last; //split : convert the string to array ,it splits when it comes to /
    //and last to bring the last element im list which is image name and its لاحقة
    // ignore: avoid_print
    print('image name is :' + imagename);
    // Map data = {
    //   'name': name,
    //   'description': desc,
    //   'price': price,
    //   'path': base64,
    // };

    // // ignore: avoid_print
    // print(data.toString());
    const url = 'http://192.168.43.9:8000/api/food/';

    try {
      final response = await http.post(Uri.parse(url), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }, body: <String, dynamic>{
        'name': '${dataa.name}',
        'price': '${dataa.price}',
        'description': '${dataa.description}',
        'path': '${dataa.path}'
      });
      print('sss${response.body}');

      //encoding: Encoding.getByName('utf-8')

      print('sss${response.body}');
      print(response.statusCode);
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
      // final responseData =

    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Food>> postData(Food data) async {
    if (file == null) {}
    String base64 = base64Encode(
        file!.readAsBytesSync()); // readAsBytesSync : read file content as list
    // ignore: avoid_print
    print('File :');
    // ignore: avoid_print
    print(file);
    // ignore: avoid_print
    print('base64:' + base64);

    String imagename = file!.path
        .split('/')
        .last; //split : convert the string to array ,it splits when it comes to /
    //and last to bring the last element im list which is image name and its لاحقة
    // ignore: avoid_print
    print('image name is :' + imagename);
    var response = await http.post(
        Uri.parse('http://192.168.43.9:8000/api/food'),
        headers: <String, String>{
          'Accept': 'application/json'
        },
        body: <String, String>{
          // 'name': '${data.name}',
          // 'description': '${data.description}',
          // 'path': '${data.path}',
          // 'price': '${data.price}'
          'he': 'he',
        });

    print('the resdponse bodyyyyyyyyyyyyyyy${response.body}');
    print(response.statusCode);

    if (response.statusCode == 201) {
      // ignore: avoid_print
      print(response.body);
      // ignore: avoid_print
      print(data);
      return json.decode(response.body);
      //return Photographers.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to post data');
    }
  }

  var nameController = TextEditingController();
  var descController = TextEditingController();
  var priceController = TextEditingController();
  var imageController = TextEditingController();
  // ignore: prefer_typing_uninitialized_variables
  var foodlist;
  @override
  void initState() {
    super.initState();
    /* _formkey1 = GlobalKey();
    _formkey2 = GlobalKey();

    _formkey3 = GlobalKey();*/

    nameController = TextEditingController();
    descController = TextEditingController();
    priceController = TextEditingController();
    imageController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    priceController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // foodController addfood =
    //     Provider.of<foodController>(context, listen: false);

    return Scaffold(
      body: Container(
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
                const SizedBox(
                  height: 80,
                ),
                Container(
                  height: 45,
                  width: 100,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 3.0, // radius of shadow
                        blurRadius: 5.0)
                  ], color: lightpink, borderRadius: BorderRadius.circular(30)),
                  child: IconButton(
                      icon: const Icon(Icons.add_photo_alternate_rounded),
                      onPressed: () {
                        pickergallery();
                      }),
                ),

                /* Container(
                  height: 45,
                  width: 100,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 3.0, // radius of shadow
                        blurRadius: 5.0)
                  ], color: lightpink, borderRadius: BorderRadius.circular(30)),
                  child: ElevatedButton(
                      child: Text("upload"),
                      onPressed: () {
                        upload();
                      }),
                ),*/
                const SizedBox(
                  height: 20,
                ),
                Container(
                  // ignore: unnecessary_null_comparison
                  child: file == null
                      ? const Text(
                          'image not selected yet ',
                          style: TextStyle(),
                        )
                      : Image.file(
                          file!,
                          height: 200,
                          width: 200,
                        ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AddScreen_UI(
                    lable: 'food name',
                    hint: 'add food name',
                    message: 'enter name',
                    Controller: nameController,
                    icon: Icons.cake,
                    textInputType: TextInputType.name,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AddScreen_UI(
                    lable: 'Description',
                    hint: 'add food Description',
                    message: 'enter description',
                    Controller: descController,
                    icon: Icons.description,
                    textInputType: TextInputType.name,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AddScreen_UI(
                    lable: 'price ',
                    hint: 'add food price',
                    message: 'enter price ',
                    Controller: priceController,
                    icon: Icons.price_change,
                    textInputType: TextInputType.number,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                /*Container(
                    padding: EdgeInsets.all(8),
                    child: TextField(
                   //   key: _formkey3,
                      controller: availabilityController,
                      decoration: InputDecoration(
                          labelText: 'availibility',
                          hintText: 'add availibility',
                          labelStyle: TextStyle(color: pink4),
                          hintStyle: TextStyle(color: Colors.grey.shade50),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),*/
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 120,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE4AAAD),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  //  color: pink1,
                  child: TextButton(
                    child: const Text(
                      'Add..',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      addfooooood(Food(
                          id: 1,
                          name: nameController.text,
                          price: int.parse(priceController.text),
                          description: descController.text,
                          path: image.toString()));

                      Navigator.popAndPushNamed(context, '/create');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
