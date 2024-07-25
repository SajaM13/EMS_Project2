import 'dart:convert';

import 'package:eventsapp/Network/global.dart';
import 'package:eventsapp/Network/storage.dart';
import 'package:eventsapp/providers/shared.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/*var role_id;
bool isAdmin = false;

savepref2(int roleId) async {
  SharedPreferences shared = await SharedPreferences.getInstance();
  shared.setInt("role_id", roleId);
  print(shared.getInt("role_id"));
}*/
tokenSecureStorage tok = tokenSecureStorage();

class Auth with ChangeNotifier {
  bool isLoading = true;
  // var username;
  // var email;
  /* getPref() async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    if (role_id == 1) {
      isAdmin = true;
      notifyListeners();
    }
  }*/

  /*savePref(int role_id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("role_id", role_id.toString());
    print(preferences.getString("role_id"));
    notifyListeners();
  }*/

  /*getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    roleId = preferences.getString("role_id");
    username = preferences.getString('user_name');
    email = preferences.getString('email');
    isAdmin = true;
    notifyListeners();
  }*/

  Future<void> signUp(
      String name, String email, String password, String contact) async {
    // print(data.toString());
    const url = "http://192.168.43.9:8000/api/auth/createAccount";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{'Accept': 'application/json'},
        body: <String, dynamic>{
          'name': name,
          'email': email,
          'password': password,
          'contact': contact,
        },
      );
      print('response.statusCode');
      print(response.statusCode);
      if (response.statusCode == 201 || response.statusCode == 200) {
        print('sss${response.body}');
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

  Future<void> logIn(
    String email,
    String password,
  ) async {
    Map data = {'email': email, 'password': password};

    print(data.toString());
    const url = "http://192.168.43.9:8000/api/auth/login";

    try {
      final response = await http.post(Uri.parse(url),
          headers: {'Accept': 'application/json'},
          body: data,
          encoding: Encoding.getByName('utf-8'));
      if (response.statusCode == 200) {
        Map<String, dynamic> resp = jsonDecode(response.body);
        print('response body is ${response.body}');

        print('role id :${resp['user']["role_id"]}');

        role_id = resp['user']["role_id"];
        token = resp["access_token"];
        print('access token : ${resp["access_token"]}');
        print('------------------------------------------------');
        print(token);

        notifyListeners();

        // If the server did return a 200 OK response,
        // then parse the JSON.
      } else {
        print(response.statusCode);

        // print('${resp['message']}');
        throw Exception('Failed ..');
      }

      // final responseData =

    } catch (e) {
      throw e.toString();
    }
  }
}
