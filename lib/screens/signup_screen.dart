import 'package:eventsapp/anonymos_login/main_screen2.dart';
import 'package:eventsapp/providers/auth.dart';
import 'package:eventsapp/providers/formvalidate.dart';
import 'package:eventsapp/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';

// ignore: must_be_immutable, camel_case_types
class signup_screen extends StatefulWidget {
  const signup_screen({Key? key}) : super(key: key);

  @override
  State<signup_screen> createState() => _Signup_State();
}

// ignore: camel_case_types
class _Signup_State extends State<signup_screen> {
  late ScaffoldMessenger scaffoldMessenger;

  @override
  void initState() {
    super.initState();
    /* _formkey1 = GlobalKey();
    _formkey2 = GlobalKey();

    _formkey3 = GlobalKey();*/

    nameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  final pink1 = const Color(0xFFFCABB4);
  final pink2 = const Color(0xFFFC9BA5);
  final darkpink = const Color(0xFFD66E79);
  final lightpink = const Color(0xFFFDD5D9);
  final pink3 = const Color(0xFFFDBAC1);
  final pink4 = const Color(0xFFE4AAAD);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool isobscure = true;
  bool isLoading = false;
  // ignore: non_constant_identifier_names
  final GlobalKey<ScaffoldState> _Scaffoldkey = GlobalKey();
  late String email, password, contact, name, accessToken, userid;

  @override
  Widget build(BuildContext context) {
    // scaffoldMessenger = ScaffoldMessenger.of(context) ;
    final provider = Provider.of<Auth>((context), listen: false);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: _Scaffoldkey,
        /*appBar: AppBar(
            //  backgroundColor: primarycolor4,
            ),*/
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/image/login.png"),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
          child: Center(
            child: SingleChildScrollView(
              child: SafeArea(
                child: Form(
                  // Form will work as group and help in managing validating multiple textformfields
                  key:
                      _formkey, //here we provide Form widget with GlobalKey<FormState> to help
                  //in allowing validation to form easily & in proper order
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 90.0,
                      ),
                      SizedBox(
                        // height: 40,
                        width: double.infinity,
                        child: TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            //  hintText: 'User name',
                            labelText: 'username',
                            suffixIcon: const Icon(
                              Icons.person,
                              size: 20,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty
                                //!RegExp(r'^[a-zA-Z]+$').hasMatch(value)
                                ) {
                              return "Enter user name";
                            }
                            if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                              return "Enter Valid name";
                            }
                            // print(value);
                            return 'Done';
                          },
                          onSaved: (value) {
                            name = value!;
                          },
                          /* onChanged: (value) {
                            validate.changeName(value);
                          },*/
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
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
                          decoration: const InputDecoration(
                            //  border: InputBorder.none,
                            labelText: 'Email Address',
                            suffixIcon: Icon(
                              Icons.email,
                              size: 20,
                            ),
                          ),
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
                              labelText: 'Password',
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
                          )),
                      const SizedBox(
                        height: 15.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          //obscureText: true,
                          /*   onFieldSubmitted: (String value) {
                            // ignore: avoid_print
                            print(value);
                          },
                          onChanged: (String value) {
                            // ignore: avoid_print
                            print(value);
                          },*/

                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter phone number";
                            }
                            if (!RegExp(
                                    r'(^(?:[+0]9)?[0-9]{10}$)') /*
                            where ^ : start of the string
                            (?:[+0]9) : optionaly match a + or 0 followed by 9
                            [0-9]{10} : match 10 digits
                            $ : end of the strings
                             */
                                .hasMatch(value)) {
                              return "enter valid number";
                            }
                            print(value);
                            return '';
                          },
                          onSaved: (value) {
                            contact = value!;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Phone',
                            suffixIcon: Icon(
                              Icons.phone,
                              size: 20,
                            ),
                          ),
                        ),
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
                            if (_formkey.currentState!.validate()) {
                              print('all fields are filled correctly');
                              return;
                            } else {
                              print('Failed to validate');
                            }
                            if (emailController.text.isEmpty ||
                                passwordController.text.isEmpty ||
                                phoneController.text.isEmpty ||
                                nameController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please fill all feilds')));
                              return;
                            }
                            provider.signUp(
                                nameController.text,
                                emailController.text,
                                passwordController.text,
                                phoneController.text);
                            setState(() {
                              isLoading = true;
                            });
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const main_screen()));
                          }
                          /* validate.isValid
                              ? null
                              : Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const main_screen()))*/
                          ,
                          child: const Text(
                            'DONE',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 100.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account ?',
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const login_screen()));
                            },
                            child: const Text(
                              'LogIn',
                              style: TextStyle(color: Color(0xFFD66E79)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          decoration: BoxDecoration(
                            color: lightpink,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => main_screen2()));
                            },
                            child: Text(
                              'LogIn as a guest',
                              style: TextStyle(color: Colors.blueGrey.shade200),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Future<void> _submit() async {
    Provider.of<Auth>(context, listen: false)
        .signUp('name', 'email', 'password', 'contact');
  }
}
