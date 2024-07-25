import 'package:eventsapp/Network/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddScreen_UI extends StatelessWidget {
  String? lable, hint, message;
  final TextInputType? textInputType;

  AddScreen_UI({
    Key? key,
    required this.lable,
    required this.hint,
    required this.message,
    // ignore: non_constant_identifier_names
    required this.Controller,
    required this.icon,
    this.textInputType,
  }) : super(key: key);
  // ignore: non_constant_identifier_names
  TextEditingController Controller = TextEditingController();
  IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
            child: SafeArea(
                child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TextFormField(
            keyboardType: textInputType,
            controller: Controller,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(),
              labelText: lable,
              hintText: hint,
              hintMaxLines: 2,
              labelStyle: TextStyle(color: pink4),
              hintStyle: TextStyle(color: Colors.black12, fontSize: 12),
              suffixIcon: Icon(
                icon,
                size: 18,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return message;
              }
            })
      ]),
    ))));
  }
}
