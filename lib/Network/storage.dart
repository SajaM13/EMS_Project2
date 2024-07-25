// ignore: camel_case_types

import 'package:shared_preferences/shared_preferences.dart';

String? token;

class tokenSecureStorage {
  /*static const _storage = FlutterSecureStorage();

  static Future setToken(String key, value) async {
    await _storage.write(key: key, value: value);
  }

  static Future<String?> getToken(key) async {
    return await _storage.read(key: key);
  }*/

}

setToken(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString('access_token', value).toString();
}

getToken(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('access_token').toString();
}
