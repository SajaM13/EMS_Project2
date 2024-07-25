// ignore: camel_case_types
import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:eventsapp/models/photographers_model.dart';
import 'package:eventsapp/screens/addphotographers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class addPhotographers with ChangeNotifier {
  // addPhotographersList li = const addPhotographersList();
  Future<List<Photographers>>? _photpg;

  /*late String authtoken;
  late String photographersId;*/
  final List<Photographers> _photographerlist = [];

  UnmodifiableListView<Photographers> get photographerlist =>
      UnmodifiableListView(_photographerlist);

  /*Future<void> addPhotographer(Photographers ph) async {
    //_photographerlist.add(ph);
    http.Response respo = (await postData(ph)) as http.Response;
    if (respo.statusCode == 200) {
      notifyListeners();
    }
  }*/

  /*Future<void> addPhotographer(Photographers body) async {
    http.Response resp = (await postData(body))!;
    if (resp.statusCode == 200) {
      _photographerlist.add(body);
      notifyListeners();
    }
    //notifyListeners();
  }*/

  Future<void> deleteData(int iD) async {
    const url = 'http://192.168.43.9:8000/api/camerawon';

    _photographerlist.removeWhere((_id) => _id.id == photographerlist[iD].id);
    notifyListeners();
    final response = await http.post(Uri.parse('$url/$iD'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('item deleted');

      // If the server did return a 200 OK response,
      // then parse the JSON.
      // ignore: avoid_print
    } else {
      print('could not be deleted');
      print(throw Exception().toString());
    }
  }
}
  /* List<photographerslist> _add = [
    photographerslist(id: '1', name: 'blabla', desc: '11', contact: '11')
  ];
  List<photographerslist> get add => _add;
  set add(List<photographerslist> additem) {
    _add = additem;
    notifyListeners();
  }

  void addItem(photographerslist photogdata) {
    _add.add(photogdata);
    notifyListeners();
  }*/

  /* Future<void>> postdata(Photographers pho) async {
    notifyListeners();
    final response = await http.post(Uri.parse('uri'),
        headers: <String, String>{'Accept': 'application/json;charest=UTF-8'},
        body: json.encode(<String, String>{
          "name": name,
        }));
    if (response.statusCode == 200) {
      print(response.body);
      return Photographers.fromJson(json.decode(response.body));

    }
    else{
            throw Exception('Failed to load adding photographers info');

    }
    return response.
  }*/
  /*List<photographerslist> get items {
    //cuz the list is final need getter to use it in main screen
    return _add;
  }*/

  // ignore: non_constant_identifier_names
  /*void AddPhotographer({String? name, String? desc, String? contact}) {
    _add.add(
        photographerslist(id: 1, name: name!, desc: desc!, contact: contact!));
    notifyListeners();
  }*/
  /* Future<void> addphotographer(photographerslist list) async {
    final url = '';
    try {
      final res = await http.post(Uri.parse(url),
          body: json.encode({
            'name': list.id,
            'description': list.desc,
            'contact number': list.contact
          }));
      final newPgotographer = photographerslist(
          id: json.decode(res.body)['id'],
          name: list.name,
          desc: list.desc,
          contact: list.contact);
      _add.add(newPgotographer);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateph(String id, photographerslist newph) async {
    final ph_index = _add.indexWhere((element) => element.id == id);
    if (ph_index >= 0) {
      final url = '';
      await http.patch(Uri.parse(url),
          body: json.encode({
            'name': newph.name,
            'desc': newph.desc,
            'contact': newph.contact
          }));
      _add[ph_index] = newph;
      notifyListeners();
    } else {
      print("....");
    }
  }

  // ignore: non_constant_identifier_names
  Future<void> DeletPhotographer(String id) async {
    final url = '';
    final existingphotographerindex =
        _add.indexWhere((element) => element.id == id);
    var existingphotographer = _add[existingphotographerindex];
    _add.removeAt(existingphotographerindex);
    notifyListeners();
    final res = await http.delete(Uri.parse(url));
    if (res.statusCode >= 400) {
      _add.insert(existingphotographerindex, existingphotographer);
      notifyListeners();
      throw const HttpException('could not delete product');
    }
  }*/

  /*photographerslist findByName(String name) {
    return _add.firstWhere((element) => element.name == name);
  }*/

