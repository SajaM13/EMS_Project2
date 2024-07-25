import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

var role_id;
bool isAdmin = false;

savepref2(int roleId) async {
  SharedPreferences shared = await SharedPreferences.getInstance();
  shared.setInt("role_id", roleId);
  print(shared.getInt("role_id"));
}

class shared extends StatefulWidget {
  const shared({Key? key}) : super(key: key);

  @override
  State<shared> createState() => _sharedState();
}

class _sharedState extends State<shared> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
