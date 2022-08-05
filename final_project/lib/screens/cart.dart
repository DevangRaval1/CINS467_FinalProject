import 'package:final_project/screens/product_description.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import "profile.dart";
import "buy.dart";
import 'cart.dart';
import 'sell.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/login.dart';

class cartScreen extends StatefulWidget {
  const cartScreen({Key? key}) : super(key: key);

  @override
  State<cartScreen> createState() => _cartScreenState();
}

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
var _firestoreInstance = FirebaseFirestore.instance;

class _cartScreenState extends State<cartScreen> {
  void initState() {
    print("calling ininininini");
    super.initState();
    _getCart();
    getTotalCost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 255, 251, 0),
            iconTheme: IconThemeData(color: Colors.black),
            title: const Text(
              'Cart',
              style: TextStyle(
                color: Colors.black,
              ),
            )),
        body: SafeArea(
          // child: Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Padding(padding: EdgeInsets.all(5),
          //     child: Image.network(
          //                             cart["image"],
          //                           ),),

          //   ],
          // ),
          child: Container(
            // height: ,
            child: Column(children: [
              SizedBox(
                height: 10,
              ),
              Text('Total Cost: $totalCost',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
              Container(
                // height: 300,
                child: Expanded(
                    child: Container(
                  height: 200,
                  child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: cart.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1, childAspectRatio: 1),
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      productDescription(cart[index]))),
                          child: Container(
                            // height: 100,
                            child: Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: BorderSide(
                                    color: Colors.black,
                                  )),
                              elevation: 10,
                              child: Column(
                                children: [
                                  AspectRatio(
                                      aspectRatio: 2,
                                      child: Container(
                                        color: Colors.white,
                                        child: Image.network(
                                          cart[index]["image"],
                                        ),
                                      )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${cart[index]["name"]}",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text("\$${cart[index]["price"]}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("Quantity: ${cart[index]["quantity"]}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          height: 30,
                                          width: 100,
                                          child: FittedBox(
                                              child: FloatingActionButton(
                                                  child: Icon(Icons.remove),
                                                  backgroundColor: Colors.white,
                                                  elevation: 10,
                                                  foregroundColor: Colors.black,
                                                  tooltip: "Remove from cart",
                                                  onPressed: () {
                                                    if (cart[index]
                                                            ["quantity"] >
                                                        1) {
                                                      cart[index]["quantity"] =
                                                          cart[index]
                                                                  ["quantity"] -
                                                              1;
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Removed from cart",
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          timeInSecForIosWeb: 2,
                                                          backgroundColor:
                                                              Colors.lightGreen,
                                                          gravity:
                                                              ToastGravity.TOP,
                                                          textColor:
                                                              Colors.black,
                                                          fontSize: 20.0);

                                                      _removeCart(cart, index);
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  cartScreen()));
                                                    } else {
                                                      Fluttertoast.showToast(
                                                        msg:
                                                            "Quantity cannot be less than 1",
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        timeInSecForIosWeb: 2,
                                                        backgroundColor:
                                                            Colors.red,
                                                        gravity:
                                                            ToastGravity.TOP,
                                                        textColor: Colors.black,
                                                      );
                                                    }
                                                  }))),
                                      Container(
                                          height: 30,
                                          width: 100,
                                          child: FittedBox(
                                              child: FloatingActionButton(
                                                  child: Icon(Icons.add),
                                                  backgroundColor: Colors.white,
                                                  elevation: 10,
                                                  foregroundColor: Colors.black,
                                                  tooltip: "Add Quantity",
                                                  onPressed: () {
                                                    cart[index]["quantity"] =
                                                        cart[index]
                                                                ["quantity"] +
                                                            1;
                                                    Fluttertoast.showToast(
                                                        msg: "Added quantity",
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        timeInSecForIosWeb: 2,
                                                        backgroundColor:
                                                            Colors.lightGreen,
                                                        gravity:
                                                            ToastGravity.TOP,
                                                        textColor: Colors.black,
                                                        fontSize: 20.0);

                                                    addQuantity(cart, index);
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                cartScreen()));
                                                  }))),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  FloatingActionButton.extended(
                                      onPressed: () {
                                        Fluttertoast.showToast(
                                            msg: "Item Removed",
                                            toastLength: Toast.LENGTH_SHORT,
                                            timeInSecForIosWeb: 2,
                                            backgroundColor: Colors.lightGreen,
                                            gravity: ToastGravity.TOP,
                                            textColor: Colors.black,
                                            fontSize: 20.0);
                                        _removeCart(cart, index);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    cartScreen()));
                                      },
                                      label: Text("Remove from Cart"),
                                      icon: Icon(Icons.remove_done))
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                )),
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  Fluttertoast.showToast(
                      msg: "Buy Not Implimented",
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.redAccent,
                      gravity: ToastGravity.TOP,
                      textColor: Colors.black,
                      fontSize: 20.0);
                },
                label: Text("Buy Products"),
                backgroundColor: Colors.green,
              ),
            ]),
          ),
        ),
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

  List cart = [];
  _getCart() async {
    print("callingggggggg inside the functionnnnnnn");
    User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      QuerySnapshot qs = await _firestoreInstance
          .collection("users")
          .doc(firebaseUser.email)
          .collection("cart")
          .get();
      setState(() {
        print("ggggggggggggggggg");
        print(qs.docs.length);

        for (int i = 0; i < qs.docs.length; i++) {
          print(i);
          print(qs.docs[i]["image"]);
          print("FFFFFFFFFFFFFFFFFFFFFF");
          cart.add({
            "name": qs.docs[i]["name"],
            "description": qs.docs[i]["description"],
            "category": qs.docs[i]["category"],
            "quantity": qs.docs[i]["quantity"],
            "image": qs.docs[i]["image"],
            'price': qs.docs[i]['price'],
          });
        }
        // print(cart[0]["image"]);
        print("mmmmmmmmmmmmmmmmmm");
        print(cart.length);
      });
      return qs.docs;
    }
  }

  void _removeCart(List cart, int index) async {
    var _firestoreInstance = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currUser = _auth.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(currUser!.email)
        .collection('cart')
        .doc(cart[index]["name"])
        .delete();
  }

  List pricesCart = [];
  int totalCost = 0;
  getTotalCost() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currUser = _auth.currentUser;
    QuerySnapshot qs = await FirebaseFirestore.instance
        .collection('users')
        .doc(currUser!.email)
        .collection('cart')
        .get();
    setState(() {
      print("ggggggggggggggggg");
      print(qs.docs.length);

      for (int i = 0; i < qs.docs.length; i++) {
        print(i);
        print(qs.docs[i]["image"]);
        print("FFFFFFFFFFFFFFFFFFFFFF");
        pricesCart.add({
          "quantity": qs.docs[i]["quantity"],
          'price': qs.docs[i]['price'],
        });
      }
      for (int i = 0; i < qs.docs.length; i++) {
        int quantity = int.parse(pricesCart[i]["quantity"]);
        int price = int.parse(pricesCart[i]["price"]);
        totalCost = totalCost + (quantity * price);
      }
      print(totalCost);
      print("AAAAAAAAAAAAAAAAAAAAAA");
    });
    print(totalCost);
  }

  addQuantity(List ca, int i) async {
    var _firestoreInstance = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currUser = _auth.currentUser;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currUser!.email)
        .collection('cart')
        .doc(ca[i]["name"])
        .update({"quantity": (ca[i]["quantity"].toString())});

    print(ca[i]["quantity"]);
  }

  removeQuantity(List ca, int i) async {
    var _firestoreInstance = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currUser = _auth.currentUser;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currUser!.email)
        .collection('cart')
        .doc(ca[i]["name"])
        .update({"quantity": (ca[i]["quantity"].toString())});
  }
}
