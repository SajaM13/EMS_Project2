import 'package:eventsapp/Network/global.dart';
import 'package:eventsapp/providers/lan.dart';
import 'package:eventsapp/providers/language.dart';
import 'package:eventsapp/providers/shared.dart';
import 'package:eventsapp/screens/login_screen.dart';
import 'package:flutter/material.dart';

class drawer_ extends StatefulWidget {
  const drawer_({Key? key}) : super(key: key);

  @override
  State<drawer_> createState() => _drawer_State();
}

class _drawer_State extends State<drawer_> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.pink.shade50,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Container(
                    height: 150,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/image/drawer.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: isAdmin
                        ? Align(
                            alignment: Alignment.bottomLeft,
                            child: ListTile(
                              title: Text('Saja M',
                                  style:
                                      TextStyle(color: darkpink, fontSize: 17)),
                              subtitle: Text('admin1@gmail.com'),
                            ),
                          )
                        : Align(
                            alignment: Alignment.bottomLeft,
                            child: ListTile(
                              title: Text('ss M',
                                  style:
                                      TextStyle(color: darkpink, fontSize: 17)),
                              subtitle: Text('rawda@gmail.com'),
                            ),
                          )),
                isAdmin
                    ? ListTile(
                        title: Text(getlang('reservations'),
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 17)),
                        onTap: () {
                          Navigator.pushNamed(context, 'gotores');
                        },
                      )
                    : Text(''),
                isAdmin
                    ? ListTile(
                        title: Text(getlang('accepted reservations'),
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 17)),
                        onTap: () {
                          Navigator.pushNamed(context, 'go');
                        },
                      )
                    : Text(''),
                Divider(),
                ListTile(
                  title: Text(getlang('Offers'),
                      style: TextStyle(color: Colors.blueGrey, fontSize: 17)),
                  onTap: () {
                    Navigator.pushNamed(context, 'offers');
                  },
                ),
                Divider(),
                ExpansionTile(
                  backgroundColor: lightpink.withOpacity(0.3),
                  title: Text(
                    getlang('Complaint numbers'),
                    style: TextStyle(color: Colors.blueGrey, fontSize: 17),
                  ),
                  children: [
                    const Divider(),
                    ListTile(
                      title: const Text(
                        " 0997864754",
                        style: TextStyle(color: pink3, fontSize: 15),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      title: const Text(
                        " 0987666721 ",
                        style: TextStyle(color: pink3, fontSize: 15),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
                Divider(),
                const SizedBox(height: 5),
                ExpansionTile(
                  backgroundColor: lightpink.withOpacity(0.3),
                  title: Text(
                    getlang('Language'),
                    style: TextStyle(color: Colors.blueGrey, fontSize: 17),
                  ),
                  children: [
                    const Divider(),
                    ListTile(
                      title: Column(
                        children: [
                          ListTile(
                            leading: Text(
                              getlang('ar'),
                              style: TextStyle(color: pink3),
                            ),
                            title: Center(
                              child: Switch(
                                  activeColor: darkpink,
                                  value: isEng,
                                  onChanged: (value) {
                                    setState(() {
                                      isEng = value;
                                    });
                                  }),
                            ),
                            trailing: Text(
                              getlang('en'),
                              style: TextStyle(color: pink3),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(),
                const SizedBox(
                  height: 90,
                ),
                Divider(),
                ListTile(
                  title: Text(
                    getlang('LogOut'),
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  trailing: const Icon(
                    Icons.logout,
                    color: darkpink,
                  ),
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const login_screen()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
