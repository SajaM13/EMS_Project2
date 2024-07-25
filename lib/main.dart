//import 'package:eventsapp/screens/login_screen.dart';

import 'package:eventsapp/accepted.dart';
import 'package:eventsapp/models/offers_model.dart';
import 'package:eventsapp/providers/auth.dart';
import 'package:eventsapp/providers/foodcontroller.dart';
// import 'package:eventsapp/providers/formvalidate.dart';
import 'package:eventsapp/providers/photographer.dart';
import 'package:eventsapp/screens/addfood.dart';
import 'package:eventsapp/screens/addphotographers.dart';
import 'package:eventsapp/screens/calander_screen.dart';
import 'package:eventsapp/screens/checklist.dart';
//import 'package:eventsapp/screens/book.dart';
import 'package:eventsapp/screens/editfoodinfo.dart';
import 'package:eventsapp/screens/editphotoginfo.dart';
import 'package:eventsapp/screens/food_screen.dart';
import 'package:eventsapp/screens/login_screen.dart';
import 'package:eventsapp/screens/main_screen.dart';
import 'package:eventsapp/screens/media_screen.dart';
import 'package:eventsapp/screens/offers_screen.dart';
import 'package:eventsapp/screens/onboarding.dart';
import 'package:eventsapp/screens/reservations_list.dart';
import 'package:eventsapp/screens/signup_screen.dart';
import 'package:eventsapp/screens/update_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MultiProvider(//initiates providers
          providers: [
    ChangeNotifierProvider<Auth>(create: (_) => Auth()),
    ChangeNotifierProvider<addPhotographers>(
        create: (context) => addPhotographers()),
    ChangeNotifierProvider<foodController>(
        create: (context) => foodController()),
  ], child: const MyApp())
      //const MyApp()

      );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'EMS',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        routes: {
          '/': (context) => OnBoarding_Screen(),
          '/first': (context) => addPhotographersList(),
          '/create': (context) => const main_screen(),
          'addfood': (context) => const addfood(),
          'login': (context) => const login_screen(),
          'backtofoodScreen': (context) => const food_screen(),
          'backtomediaScreen': (context) => const media_screen(),
          'edit': (context) => editphotog(),
          'editfood': (context) => editFoodInfo(),
          //'reservationsList': (context) =>  reservation(),
          'check': (context) => checklist(),
          'hall': (context) => update_Details(),
          'offers': (context) => offers_screen(),
          'gotores': (context) => reservation(),
          'go': (context) => reservation2(),
          's': (context) => const signup_screen(),

          //'cal': (context) =>  calendar(),

          //  'book': (context) => addBook(),

          // '/f': (context) => add(),
          // '/Second': (context) => const signup_screen(),
        }
        // home: const MyHomePage(title: 'EMS main '),
        );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
