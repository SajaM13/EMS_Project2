import 'dart:convert';

import 'package:eventsapp/Network/addscreen_ui.dart';
import 'package:eventsapp/models/offers_model.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class add_offer extends StatefulWidget {
  @override
  State<add_offer> createState() => _add_offerState();
}

class _add_offerState extends State<add_offer> {
  var nameController = TextEditingController();
  var descController = TextEditingController();
  var valueController = TextEditingController();
  var startDController = TextEditingController();
  var endDController = TextEditingController();

  Future<List<off>> postData(String description, String name, int value,
      String startdate, String enddate
      //DateTime startdate, DateTime enddate
      ) async {
    final response = await http.post(
      Uri.parse('http://192.168.43.9:8000/api/offer/'),
      headers: <String, String>{'Accept': 'application/json'},
      body: jsonEncode(<String, dynamic>{
        'description': description,
        'name': name,
        'value': value,
        'start_date': startdate,
        'end_date': enddate,
      }),
    );
    print('sss${response.body}');
    print('state : --- ${response.statusCode}');
    if (response.statusCode == 201) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return json.decode(response.body);
      // return offer.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load offers').toString();
    }
  }

  final TextEditingController _controller = TextEditingController();

  Future<off>? futureAddOffer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OoOffers'),
        centerTitle: true,
        backgroundColor: Color(0XFFE4AAAD),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                //هون حاطت كونترولر
                children: [
                  AddScreen_UI(
                    lable: 'Offer Description',
                    hint: 'add description',
                    message: 'please enter the description of the offer',
                    Controller: descController,
                    icon: Icons.description,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AddScreen_UI(
                    lable: 'Offer Name',
                    hint: 'add the offer name',
                    message: 'please enter the name of the offer',
                    Controller: nameController,
                    icon: Icons.local_offer_outlined,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AddScreen_UI(
                    lable: 'Offer Value',
                    hint: 'add the value',
                    message: 'please enter the value of the offer',
                    Controller: valueController,
                    icon: Icons.money_off_csred_outlined,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AddScreen_UI(
                    lable: 'Start Date',
                    hint: 'add the Date',
                    message: 'please enter the Start Date of the offer',
                    Controller: startDController,
                    icon: Icons.date_range_outlined,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AddScreen_UI(
                    lable: 'End Date',
                    hint: 'add the Date',
                    message: 'please enter the End Date of the offer',
                    Controller: endDController,
                    icon: Icons.date_range_outlined,
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Container(
                    color: Color(0XFFFDBAC1),
                    width: 300,
                    child: MaterialButton(
                        child: Text(
                          'ADD',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            postData(
                                descController.text,
                                nameController.text,
                                int.parse(valueController.text),
                                startDController.text,
                                endDController.text);
                          });
                        }),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
