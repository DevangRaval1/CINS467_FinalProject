import 'package:final_project/screens/buy.dart';
import 'package:final_project/screens/home.dart';
import 'package:final_project/screens/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../reusable_widgets/reusable_widgets.dart';
// import 'package:final_project/constants/colors.dart';

class LoginInScreen extends StatefulWidget {
  const LoginInScreen({Key? key}) : super(key: key);

  @override
  State<LoginInScreen> createState() => _LoginInScreenState();
}

class _LoginInScreenState extends State<LoginInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
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
                  padding: const EdgeInsets.fromLTRB(50, 100, 50, 1000),
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
                                text: "Login",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold))
                          ])),
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
                      ruButton(context, "Login", () {
                        if (_emailTextController.text.isEmpty ||
                            _passwordTextController.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Please fill all fields",
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Colors.red,
                              gravity: ToastGravity.TOP,
                              textColor: Colors.white,
                              fontSize: 20.0);
                        } else {
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: _emailTextController.text,
                                  password: _passwordTextController.text)
                              .then((value) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => HomeScreen())));
                          }).onError((error, stackTrace) {
                            SnackBar(
                                content: Text("Error: ${error.toString()}"));
                          });
                        }
                      }),
                      ruButton(context, "Google", () async {
                        await signInWithGoogle();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => buyScreen()));
                      }),
                      signUpRe()
                    ],
                  )),
            )));
  }

  Row signUpRe() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: TextStyle(color: Colors.black, fontSize: 10),
        ),
        GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()));
            },
            child: const Text(
              "SignUp",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ))
      ],
    );
  }

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleLogin = await GoogleSignIn().signIn();
      if (googleLogin != null) {
        final GoogleSignInAuthentication googleLoginAuth =
            await googleLogin.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleLoginAuth.accessToken,
            idToken: googleLoginAuth.idToken);
        await FirebaseAuth.instance.signInWithCredential(authCredential);
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }
}
