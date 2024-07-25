// ignore_for_file: non_constant_identifier_names

import 'dart:collection';
import 'dart:convert';
import 'dart:io';
//import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:eventsapp/models/food_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class foodController extends ChangeNotifier {
  List<Food> _foodlist = [];

  UnmodifiableListView<Food> get photographerlist =>
      UnmodifiableListView(_foodlist);

  PickedFile? _pickedFile;
  PickedFile? get pickedFile => _pickedFile;
  final _picker = ImagePicker();
  Future<void> pickimage() async {
    _pickedFile =
        (await _picker.pickImage(source: ImageSource.gallery)) as PickedFile?;
    notifyListeners();
  }

  Future<void> addFood(Food fd) async {
    _foodlist.add(fd);
    notifyListeners();
  }

  Future<void> addd(String name, String desc, int price) async {
    Map data = {'name': name, 'description': desc, 'price': price};

    print(data.toString());
    const url =
        "https://f8ed2526-6be3-4f31-bc62-70bd043c9c90.mock.pstmn.io/api/food";

    try {
      final response = await http.post(Uri.parse(url),
          headers: {'Accept': 'application/json'},
          body: data,
          encoding: Encoding.getByName('utf-8'));
      notifyListeners();
      if (response.statusCode == 200) {
        Map<String, dynamic> resp = jsonDecode(response.body);
        print(response.body);
        if (!resp['error']) {
          Map<String, dynamic> users = resp['data'];
        }
        // If the server did return a 200 OK response,
        // then parse the JSON.
      } else {
        // print('${resp['message']}');
        throw Exception('Failed ..');
      }

      // final responseData =

    } catch (e) {
      throw SnackBar(content: Text(e.toString()));
    }
  }

  final List<Food> _food_list = [];

  UnmodifiableListView<Food> get foodlist => UnmodifiableListView(_food_list);
  Future<void> deleteData(int iD) async {
    const url =
        'https://f8ed2526-6be3-4f31-bc62-70bd043c9c90.mock.pstmn.io/api/food/6';

    _food_list.removeWhere((_id) => _id.id == photographerlist[iD].id);
    notifyListeners();
    final response = await http.delete(Uri.parse('$url/$iD'));
    if (response.statusCode == 200) {
      print('item deleted');

      // If the server did return a 200 OK response,
      // then parse the JSON.
      // ignore: avoid_print
    } else {
      print('could not be deleted');
      throw Exception();
    }
  }
}
