import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "profile.dart";
import "buy.dart";
import 'cart.dart';
import 'sell.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/login.dart';

class productDescription extends StatefulWidget {
  var _showProduct;
  productDescription(this._showProduct);
  @override
  State<productDescription> createState() => _productDescriptionState();
}

class _productDescriptionState extends State<productDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 251, 0),
          iconTheme: IconThemeData(color: Colors.black),
          title: Text("${widget._showProduct["name"]}",
              style: TextStyle(color: Colors.black)),
        ),
        body: SafeArea(
          child: Container(
            child: Column(children: [
              SizedBox(
                height: 500,
                child: Expanded(
                  child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: 1,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1, childAspectRatio: 0.8),
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Card(
                            elevation: 10,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                FloatingActionButton.extended(
                                    icon: const Icon(Icons.add),
                                    backgroundColor: Colors.white,
                                    elevation: 10,
                                    foregroundColor: Colors.green,
                                    label: const Text("Add to cart"),
                                    tooltip: "Add to cart",
                                    onPressed: () {
                                      addToCart(widget._showProduct);
                                    }),
                                SizedBox(
                                  height: 10,
                                ),
                                AspectRatio(
                                    aspectRatio: 1,
                                    child: Container(
                                      color: Colors.white,
                                      child: Image.network(
                                        widget._showProduct["image"],
                                        // height: 100,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(
                    "Name:          ${widget._showProduct["name"]}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(
                    "Description: ${widget._showProduct["description"]}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(
                    "Category:     ${widget._showProduct["category"]}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(
                    "Price:            ${widget._showProduct["price"]}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(
                    "Availability:  ${widget._showProduct["quantity"]}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
            ]),
          ),
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

  Future<void> addToCart(var prod) async {
    var _firestoreInstance = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currUser = _auth.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(currUser!.email)
        .collection('cart')
        .doc(prod["name"])
        .set({
      "name": prod["name"],
      "image": prod["image"],
      'category': prod["category"],
      'description': prod["description"],
      'quantity': prod["quantity"],
      'price': prod['price'],
    });
  }
}
