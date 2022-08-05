import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/firebase_options.dart';
import 'package:final_project/screens/add_product.dart';
import 'package:final_project/screens/product_description.dart';
import 'package:firebase_core/firebase_core.dart';
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
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const buyScreen());
}

class buyScreen extends StatefulWidget {
  const buyScreen({Key? key}) : super(key: key);

  @override
  State<buyScreen> createState() => _buyScreenState();
}

var _firestoreInstance = FirebaseFirestore.instance;

class _buyScreenState extends State<buyScreen> {
  void initState() {
    print("calling ininininini");
    super.initState();
    showProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 251, 0),
          iconTheme: IconThemeData(color: Colors.black),
          title: const Text(
            'Buy',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
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
        body: SafeArea(
          child: Container(
            child: Column(children: [
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: allProd.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 1),
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    productDescription(allProd[index]))),
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
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
                                      allProd[index]["image"],
                                    ),
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${allProd[index]["name"]}",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text("\$${allProd[index]["price"]}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                  height: 30,
                                  width: 100,
                                  child: FittedBox(
                                      child: FloatingActionButton.extended(
                                          icon: Icon(Icons.add),
                                          label: Text(
                                            "Add to Cart",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          backgroundColor: Colors.white,
                                          elevation: 10,
                                          foregroundColor: Colors.black,
                                          tooltip: "Add to cart",
                                          onPressed: () {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "${allProd[index]["name"]} Added to cart",
                                                toastLength: Toast.LENGTH_SHORT,
                                                timeInSecForIosWeb: 2,
                                                backgroundColor:
                                                    Colors.lightGreen,
                                                gravity: ToastGravity.TOP,
                                                textColor: Colors.black,
                                                fontSize: 20.0);
                                            addToCart(allProd, index);
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

    //     body: Container(
    //         child: SingleChildScrollView(
    //   child: Padding(
    //     padding: EdgeInsets.fromLTRB(50, 100, 50, 1000),
    //     child: Column(children: <Widget>[Text("Buy")]),
    //   ),
    // )));
  }

  List allProd = [];
  Future<void> showProducts() async {
    print("callingggggggg inside the functionnnnnnn");
    QuerySnapshot qs = await _firestoreInstance.collection("products").get();
    setState(() {
      print("ggggggggggggggggg");
      print(qs.docs.length);

      for (int i = 0; i < qs.docs.length; i++) {
        print(i);
        print(qs.docs[i]["image"]);
        print("FFFFFFFFFFFFFFFFFFFFFF");
        allProd.add({
          "name": qs.docs[i]["name"],
          "description": qs.docs[i]["description"],
          "category": qs.docs[i]["category"],
          "quantity": qs.docs[i]["quantity"],
          "image": qs.docs[i]["image"],
          "price": qs.docs[i]["price"],
        });
      }
      print(allProd[0]["image"]);
      print("mmmmmmmmmmmmmmmmmm");
      print(allProd.length);
    });
  }

  Future<void> addToCart(List prodToCart, int index) async {
    var _firestoreInstance = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currUser = _auth.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(currUser!.email)
        .collection('cart')
        .doc(prodToCart[index]["name"])
        .set({
      "name": prodToCart[index]["name"],
      "image": prodToCart[index]["image"],
      'category': prodToCart[index]["category"],
      'description': prodToCart[index]["description"],
      'quantity': "1",
      'price': prodToCart[index]["price"],
    });
  }
}
