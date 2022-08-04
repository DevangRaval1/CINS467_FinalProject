import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/screens/add_product.dart';
import 'package:final_project/screens/product_description.dart';
import 'package:final_project/screens/product_descriptionS.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import "profile.dart";
import "buy.dart";
import 'cart.dart';
import 'sell.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/login.dart';
import 'add_product.dart';
import 'package:firebase_core/firebase_core.dart';

class sellScreen extends StatefulWidget {
  const sellScreen({Key? key}) : super(key: key);

  @override
  State<sellScreen> createState() => _sellScreenState();
}

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
var _firestoreInstance = FirebaseFirestore.instance;
late String myEmail = "";

class _sellScreenState extends State<sellScreen> {
  void initState() {
    print("calling ininininini");
    super.initState();
    _getdata();
  }

  @override
  Widget build(BuildContext context) {
    print("insidde sell dtaruuuuuuuuuuu");

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 0, 234, 255),
          iconTheme: IconThemeData(color: Colors.black),
          title: const Text('Sell'),
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const addProduct()));
                })
          ],
        ),
        body: SafeArea(
          child: Container(
            child: Column(children: [
              SizedBox(
                height: 10,
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => addProduct())));
                },
                label: Text('Add Product'),
                backgroundColor: Color.fromARGB(255, 152, 224, 154),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: sellProducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 1),
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    productDescriptionS(sellProducts[index]))),
                        child: Card(
                          color: Color.fromARGB(255, 252, 253, 192),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          elevation: 10,
                          child: Column(
                            children: [
                              AspectRatio(
                                  aspectRatio: 2,
                                  child: Container(
                                    color: Color.fromARGB(255, 252, 253, 192),
                                    child: Image.network(
                                      sellProducts[index]["image"],
                                    ),
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              Text("${sellProducts[index]["name"]}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 3,
                              ),
                              Text("\$${sellProducts[index]["price"]}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                  height: 35,
                                  width: 35,
                                  child: FittedBox(
                                      child: FloatingActionButton(
                                          child: Icon(Icons.remove),
                                          backgroundColor: Colors.red,
                                          elevation: 10,
                                          foregroundColor: Colors.white,
                                          tooltip: "Remove your Product",
                                          onPressed: () {
                                            Fluttertoast.showToast(
                                                msg: "Product Removed",
                                                toastLength: Toast.LENGTH_SHORT,
                                                timeInSecForIosWeb: 2,
                                                backgroundColor:
                                                    Colors.lightGreen,
                                                gravity: ToastGravity.TOP,
                                                textColor: Colors.black,
                                                fontSize: 20.0);
                                            _deleteSell(sellProducts, index);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        sellScreen()));
                                          })))
                            ],
                          ),
                        ),
                      );
                    }),
              )
            ]),
          ),
        ),
        // gradient: LinearGradient(
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //     colors: <Color>[
        //   Color.fromARGB(255, 255, 255, 255),
        //   Color.fromARGB(255, 255, 213, 106)
        // ])),
        // child: SingleChildScrollView(
        //     child: Padding(
        //   padding: EdgeInsets.fromLTRB(50, 50, 50, 500),
        //   child: Row(
        //     children: <Widget>[
        //       Text("data"),
        //       Text(myEmail),
        //       // Container(
        //       //   child: FloatingActionButton(
        //       //       backgroundColor: Colors.green,
        //       //       child: const Icon(Icons.add),
        //       //       onPressed: () {
        //       //         Navigator.push(
        //       //             context,
        //       //             MaterialPageRoute(
        //       //                 builder: (context) => const addProduct()));
        //       //       }),
        //       // )
        //     ],
        //   ),
        // ),
        //  )) ),
        backgroundColor: Colors.lightBlueAccent,
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

  List sellProducts = [];

  late Map<dynamic, dynamic> dataSS;

  _getdata() async {
    print("callingggggggg inside the functionnnnnnn");
    User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      QuerySnapshot qs = await _firestoreInstance
          .collection("users")
          .doc(firebaseUser.email)
          .collection("sell")
          .get();
      setState(() {
        print("ggggggggggggggggg");
        print(qs.docs.length);

        for (int i = 0; i < qs.docs.length; i++) {
          print(i);
          print(qs.docs[i]["image"]);
          print("FFFFFFFFFFFFFFFFFFFFFF");
          sellProducts.add({
            "name": qs.docs[i]["name"],
            "description": qs.docs[i]["description"],
            "category": qs.docs[i]["category"],
            "quantity": qs.docs[i]["quantity"],
            "image": qs.docs[i]["image"],
            'price': qs.docs[i]["price"],
          });
        }
        print(sellProducts[0]["image"]);
        print("mmmmmmmmmmmmmmmmmm");
        print(sellProducts.length);
      });
      return qs.docs;
    }
  }

  void _deleteSell(List sellProd, index) async {
    var _firestoreInstance = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currUser = _auth.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(currUser!.email)
        .collection('cart')
        .doc(sellProd[index]["name"])
        .delete();
    FirebaseFirestore.instance
        .collection('products')
        .doc(sellProd[index]["name"])
        .delete();
    FirebaseFirestore.instance
        .collection('users')
        .doc(currUser.email)
        .collection('sell')
        .doc(sellProd[index]["name"])
        .delete();
  }
}
