import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/screens/buy.dart';
import 'package:final_project/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import '../firebase_options.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../reusable_widgets/reusable_widgets.dart';
import '../screens/login.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const SignUpScreen());
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _addressTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                  Color.fromARGB(255, 119, 241, 255),
                  Color.fromARGB(255, 111, 255, 229),
                  Color.fromARGB(255, 115, 255, 148),
                  Color.fromARGB(255, 235, 255, 106)
                ])),
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(50, 100, 50, 1000),
                    child: Column(
                      children: <Widget>[
                        logoWidget("assets/images/logo.JPG"),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text.rich(TextSpan(
                            text: "Enter Credentials to ",
                            children: <TextSpan>[
                              TextSpan(
                                  text: "SignUp",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))
                            ])),
                        const SizedBox(
                          height: 20,
                        ),
                        ruTextField("Enter Username", Icons.person_outline,
                            false, _userNameTextController),
                        const SizedBox(
                          height: 20,
                        ),
                        ruTextField("Enter Email", Icons.person_outline, false,
                            _emailTextController),
                        const SizedBox(
                          height: 20,
                        ),
                        ruTextField("Enter Password", Icons.lock_outline, true,
                            _passwordTextController),
                        const SizedBox(
                          height: 20,
                        ),
                        ruTextField(
                            "Enter your Address",
                            Icons.location_city_outlined,
                            false,
                            _addressTextController),
                        ruButton(context, "SignUp", () {
                          // FirebaseFirestore.instance.collection('users').add({
                          //   'username': _userNameTextController.text,
                          //   'email': _emailTextController.text,
                          //   'password': _passwordTextController.text,
                          //   'address': _addressTextController.text,
                          // });
                          if (_addressTextController.text.isEmpty ||
                              _emailTextController.text.isEmpty ||
                              _userNameTextController.text.isEmpty ||
                              _passwordTextController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Please fill all fields",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 20.0);
                          } else {
                            FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: _emailTextController.text,
                                    password: _passwordTextController.text)
                                .then((value) async {
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(value.user?.email)
                                  .set({
                                'username': _userNameTextController.text,
                                'email': _emailTextController.text,
                                'password': _passwordTextController.text,
                                'address': _addressTextController.text,
                              });

                              // print(
                              //     "Created ${_userNameTextController.text}'s account");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => buyScreen()));
                            }).onError((error, stackTrace) {
                              SnackBar(
                                  content: Text("Error: ${error.toString()}"));
                            });
                          }
                        }),
                        loginInRe(),
                      ],
                    )))));
  }

  Row loginInRe() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: TextStyle(color: Colors.black, fontSize: 10),
        ),
        GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LoginInScreen()));
            },
            child: const Text(
              "Login",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}
