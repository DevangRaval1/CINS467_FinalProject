import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import "profile.dart";
import "buy.dart";
import 'cart.dart';
import 'sell.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/login.dart';

class profileScreen extends StatefulWidget {
  const profileScreen({Key? key}) : super(key: key);

  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
  void initState() {
    print("calling ininininini");
    super.initState();
    _getUser();
    _getNoOfItems();
    _getNoOfSell();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 251, 0),
          iconTheme: IconThemeData(color: Colors.black),
          title: const Text('Profile', style: TextStyle(color: Colors.black)),
          actions: [
            IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const cartScreen()));
                })
          ],
        ),
        body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                  Color.fromARGB(255, 255, 255, 255),
                  Color.fromARGB(255, 255, 213, 106)
                ])),
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 30, 125, 1000),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            "UserName",
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            userData[0]["name"],
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Email',
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            userData[0]["email"],
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Address',
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            userData[0]["address"],
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => cartScreen()));
                            },
                            child: Container(
                              child: ListTile(
                                title: Text(
                                  'Items In Cart',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  "$itemsInCart",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            )),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => sellScreen()));
                            },
                            child: Container(
                              child: ListTile(
                                title: Text(
                                  'Items Selling',
                                  style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  "$itemsSold",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            )),
                      ],
                    )))),
        backgroundColor: Color.fromARGB(255, 48, 186, 6),
        drawer: Drawer(
          child: ListView(
            children: [
              // UserAccountsDrawerHeader(
              //   decoration: BoxDecoration(
              //     color: Colors.black
              //   ),
              //     accountName: Text(_userNameTextController.userModel.value.name ?? ""),
              //     accountEmail: Text(userController.userModel.value.email ?? "")
              //     ),
              ListTile(
                leading: Icon(Icons.shop),
                title: Text("Buy"),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const buyScreen()));
                },
              ),
              ListTile(
                leading: Icon(Icons.sell),
                title: Text("Sell"),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const sellScreen()));
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_cart),
                title: Text("Cart"),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const cartScreen()));
                },
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text("Profile"),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const profileScreen()));
                },
              ),
              ListTile(
                leading: Icon(Icons.lock),
                title: const Text("Logout"),
                onTap: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginInScreen()));
                  });
                },
              )
            ],
          ),
        ));
  }

  List userData = [];
  Future<void> _getUser() async {
    print("callingggggggg inside the functionnnnnnn");
    var _firestoreInstance = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currUser = _auth.currentUser;
    if (currUser != null) {
      QuerySnapshot qs = await FirebaseFirestore.instance
          .collection("users")
          .where('email', isEqualTo: currUser.email)
          .get();
      setState(() {
        print("ggggggggggggggggg");
        print(qs.docs.length);
        for (int i = 0; i < qs.docs.length; i++) {
          print(i);
          // print(qs.docs[i]["image"]);
          print("FFFFFFFFFFFFFFFFFFFFFF");
          userData.add({
            "name": qs.docs[i]["username"],
            "email": qs.docs[i]["email"],
            "address": qs.docs[i]["address"],
          });
        }
        print(userData.length);
        print(userData[0]["name"]);
      });
    }
  }

  late int itemsInCart;
  void _getNoOfItems() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currUser = _auth.currentUser;
    if (currUser != null) {
      QuerySnapshot qs = await _firestoreInstance
          .collection("users")
          .doc(currUser.email)
          .collection("cart")
          .get();
      setState(() {
        itemsInCart = qs.docs.length;
      });
    }
    print("CArttttttttttt");
    print(itemsInCart);
  }

  late int itemsSold;
  void _getNoOfSell() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currUser = _auth.currentUser;
    if (currUser != null) {
      QuerySnapshot qs = await _firestoreInstance
          .collection("users")
          .doc(currUser.email)
          .collection("sell")
          .get();
      setState(() {
        itemsSold = qs.docs.length;
      });
    }
    print("Selllllllllll");
    print(itemsSold);
  }
}
