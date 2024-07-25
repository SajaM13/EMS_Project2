import 'package:eventsapp/Network/global.dart';
import 'package:eventsapp/screens/login_screen.dart';
import 'package:eventsapp/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class drawer2_ extends StatefulWidget {
  const drawer2_({Key? key}) : super(key: key);

  @override
  State<drawer2_> createState() => _drawer_State();
}

class _drawer_State extends State<drawer2_> {
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
                  // child: Align(
                  //   alignment: Alignment.bottomLeft,
                  //   child: ListTile(
                  //     title: Text('Saja M',
                  //         style: TextStyle(color: darkpink, fontSize: 17)),
                  //     subtitle: Text('Saja@gmail.com'),
                  //   ),
                  // ),
                ),
                // ListTile(
                //   title: Text('reservations',
                //       style: TextStyle(color: Colors.blueGrey, fontSize: 17)),
                //   onTap: () {
                //     Navigator.pushNamed(context, 'reservationsList');
                //   },
                // ),
                Divider(),
                ListTile(
                  title: Text('Offers',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 17)),
                  onTap: () async {
                    return showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Access Denied !'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: const <Widget>[
                                const Text('please login to access this tab'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('ok'),
                              onPressed: () {
                                Navigator.pop(context);
                                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => super.widget));
                              },
                            ),
                            TextButton(
                              child: const Text('signIn'),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const login_screen()));
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                Divider(),
                ExpansionTile(
                  backgroundColor: lightpink.withOpacity(0.3),
                  title: const Text(
                    "Complaint numbers",
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
                /* ExpansionTile(
                  backgroundColor: lightpink.withOpacity(0.3),
                  title: const Text(
                    "Sort By",
                    style: TextStyle(color: darkpink, fontSize: 20),
                  ),
                  children: [
                    const Divider(),
                    ListTile(
                      title: const Text(
                        " Name",
                        style: TextStyle(color: pink3, fontSize: 15),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      title: const Text(
                        " Price ",
                        style: TextStyle(color: pink3, fontSize: 15),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),*/
                Divider(),
                const SizedBox(height: 5),
                ExpansionTile(
                  backgroundColor: lightpink.withOpacity(0.3),
                  title: const Text(
                    "Language",
                    style: TextStyle(color: Colors.blueGrey, fontSize: 17),
                  ),
                  children: [
                    const Divider(),
                    ListTile(
                      title: Column(
                        children: [
                          ListTile(
                            leading: const Text(
                              'Arabic',
                              style: TextStyle(color: pink3),
                            ),
                            title: Center(
                              child: Switch(
                                  activeColor: darkpink,
                                  value: isSwitched,
                                  onChanged: (value) async {
                                    return showDialog<void>(
                                      context: context,
                                      barrierDismissible:
                                          false, // user must tap button!
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Access Denied !'),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: const <Widget>[
                                                const Text(
                                                    'please login to access this tab'),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('ok'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => super.widget));
                                              },
                                            ),
                                            TextButton(
                                              child: const Text('signIn'),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const login_screen()));
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }),
                            ),
                            trailing: const Text(
                              'English',
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
                  height: 150,
                ),
                Divider(),
                ListTile(
                  title: const Text(
                    'SignIn',
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  trailing: const Icon(
                    Icons.logout,
                    color: darkpink,
                  ),
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const signup_screen()));
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
