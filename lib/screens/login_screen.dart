import 'package:eventsapp/providers/auth.dart';
import 'package:eventsapp/providers/language.dart';
import 'package:eventsapp/screens/main_screen.dart';
import 'package:eventsapp/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable, camel_case_types
class login_screen extends StatefulWidget {
  const login_screen({Key? key}) : super(key: key);

  @override
  State<login_screen> createState() => _LoginState();
}

class _LoginState extends State<login_screen> {
  final darkpink = const Color(0xFFD66E79);

  /*final pink1 = const Color(0xFFFCABB4);
  final pink2 = const Color(0xFFFC9BA5);
  final darkpink = const Color(0xFFD66E79);
  final lightpink = const Color(0xFFFDD5D9);
  final pink3 = const Color(0xFFFDBAC1);
  final pink4 = const Color(0xFFE4AAAD);
*/
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var role_id;
  bool isAdmin = false;

  bool isobscure = true;

  @override
  void initState() {
    super.initState();
    // getPref();

    /* _formkey1 = GlobalKey();
    _formkey2 = GlobalKey();

    _formkey3 = GlobalKey();*/

    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  bool isLoading = false;
  final GlobalKey<ScaffoldState> _Scaffoldkey = GlobalKey();
  late String email, password;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Auth>((context), listen: false);

    return Scaffold(
        resizeToAvoidBottomInset: false,

        /*appBar: AppBar(
            //  backgroundColor: primarycolor4,
            ),*/
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/image/signup.png"),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
          child: Center(
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 200.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        /* onFieldSubmitted: (String value) {
                          // ignore: avoid_print
                          print(value);
                        },*/
                        /* onChanged: (String value) {
                          // ignore: avoid_print
                          print(value);
                        },*/
                        decoration: InputDecoration(
                          //  border: InputBorder.none,
                          labelText: getlang('email'),
                          suffixIcon: Icon(
                            Icons.email,
                            size: 20,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter email";
                          }
                          if (!RegExp(r'^[a-zA-z0-9.]+@gmail.com+')
                              .hasMatch(value)) {
                            return "enter valid email";
                          }
                          print(value);
                          return 'Done';
                        },
                        onSaved: (value) {
                          email = value!;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: isobscure,
                          /* onFieldSubmitted: (String value) {
                            // ignore: avoid_print
                            print(value);
                          },
                          onChanged: (String value) {
                            // ignore: avoid_print
                            print(value);
                          },*/
                          decoration: InputDecoration(
                            //  border: InputBorder.none,
                            labelText: getlang('password'),

                            suffixIcon: IconButton(
                              icon: Icon(
                                isobscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  isobscure = !isobscure;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter password";
                            }
                            if (!RegExp(
                                    r'^(?=.*?[A-z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>')
                                .hasMatch(value)) {
                              return "enter valid password";
                            }
                            print(value);
                            return 'Done';
                          },
                          onSaved: (value) {
                            password = value!;
                          },
                        )),
                    const SizedBox(
                      height: 15.0,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 120,
                      //  width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        color: darkpink,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (isLoading) {
                            return;
                          }
                          if (emailController.text.isEmpty ||
                              passwordController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Please fill all feilds')));
                            return;
                          }
                          provider.logIn(
                              emailController.text, passwordController.text);
                          setState(() {
                            isLoading = true;
                          });
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const main_screen()));
                        },
                        child: Text(
                          getlang('done'),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 170.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          getlang('dont have an account ?'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const signup_screen()));
                            /*    Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => Login2()));*/
                          },
                          child: const Text(
                            'Signup',
                            style: TextStyle(color: Color(0xFFD66E79)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
