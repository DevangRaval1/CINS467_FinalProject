import 'package:final_project/screens/buy.dart';
import 'package:final_project/screens/cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../screens/login.dart';
import '../screens/signup.dart';
import "profile.dart";
import "buy.dart";
import 'cart.dart';
import 'sell.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 0, 234, 255),
          iconTheme: IconThemeData(color: Colors.black),
          title: const Text('Shoppers Shop'),
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
        backgroundColor: Colors.white,
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
}
