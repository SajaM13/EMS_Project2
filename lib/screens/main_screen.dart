// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:eventsapp/Network/api.dart';
import 'package:eventsapp/screens/food_screen.dart';
import 'package:eventsapp/screens/halls_list_screen.dart';
import 'package:eventsapp/screens/login_screen.dart';
import 'package:eventsapp/screens/media_screen.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class main_screen extends StatefulWidget {
  const main_screen({Key? key}) : super(key: key);

  @override
  State<main_screen> createState() => _main_screenState();
}

// ignore: camel_case_types
class _main_screenState extends State<main_screen> {
  final pink1 = const Color(0xFFFCABB4);
  final pink2 = const Color(0xFFFC9BA5);
  final darkpink = const Color(0xFFD66E79);
  final lightpink = const Color(0xFFFDD5D9);
  final pink3 = const Color(0xFFFDBAC1);
  final pink4 = const Color(0xFFE4AAAD);
  int _pageindex = 0;
  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final List<Widget> _screens_list = [
      halles_screen(),
      const food_screen(),
      const media_screen(),
      // const addd(),
    ];
    // ignore: unused_local_variable
    return Scaffold(
      body: Stack(
        children: [
          _screens_list.elementAt(_pageindex),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Align(
              alignment: const Alignment(0.0, 1.0),
              child: ClipRRect(
                child: BottomNavigationBar(
                  selectedItemColor: pink4,
                  unselectedItemColor: const Color(0xFF5E6A80),
                  showSelectedLabels: true,
                  showUnselectedLabels: false,
                  backgroundColor: Colors.grey.shade100,
                  currentIndex: _pageindex,
                  onTap: (int index) {
                    setState(() {
                      _pageindex = index;
                    });
                  },
                  items: [
                    const BottomNavigationBarItem(
                        icon: Icon(
                          Icons.home_rounded,
                          size: 26,
                        ),
                        label: "Home"),
                    const BottomNavigationBarItem(
                        icon: Icon(
                          Icons.food_bank,
                          size: 26,
                        ),
                        label: "Food"),
                    const BottomNavigationBarItem(
                        icon: Icon(
                          Icons.photo_camera,
                          size: 26,
                        ),
                        label: "Media"),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      /* body: PageView(
        controller: _pageController,
        children: <Widget>[
          Container(
            child: const Center(
              child: Text(
                "Home",
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              ),
            ),
            color: lightpink,
          ),
          Container(
            child: const Center(
              child: Text(
                "Food",
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              ),
            ),
            color: lightpink,
          ),
          Container(
            child: const Center(
              child: Text(
                "Media",
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              ),
            ),
            color: lightpink,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavyBar(
        containerHeight: 55.0,
        backgroundColor: Colors.white70,
        selectedIndex: _currentIndex,
        showElevation: false,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) => setState(() {
          _currentIndex = index;
          _pageController.animateToPage(index,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeIn);
        }),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            inactiveColor: darkpink,
            icon: const Icon(Icons.home_rounded),
            title: const Text('Home'),
            activeColor: pink4,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            inactiveColor: darkpink,
            icon: const Icon(Icons.fastfood_rounded),
            title: const Text('Food'),
            activeColor: pink4,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            inactiveColor: darkpink,
            icon: const Icon(Icons.photo_camera_rounded),
            title: const Text(
              'Media ',
            ),
            activeColor: pink4,
            textAlign: TextAlign.center,
          ),
        ],
      ),*/
    );
  }

  /*@override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }*/
}
