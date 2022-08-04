import 'dart:io';
import 'package:final_project/controller/storage.dart';
import 'package:final_project/screens/buy.dart';
import 'package:final_project/screens/cart.dart';
import 'package:final_project/screens/sell.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:final_project/reusable_widgets/reusable_widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class addProduct extends StatefulWidget {
  const addProduct({Key? key}) : super(key: key);

  @override
  State<addProduct> createState() => _addProductState();
}

class _addProductState extends State<addProduct> {
  TextEditingController _productName = TextEditingController();
  TextEditingController _productDescription = TextEditingController();
  TextEditingController _productCategory = TextEditingController();
  TextEditingController _productQuantity = TextEditingController();
  TextEditingController _productPrice = TextEditingController();
  late File _pickedImage = File('');
  var _firestoreInstance = FirebaseFirestore.instance;
  var currentUser = FirebaseAuth.instance.currentUser;
  late String imgUrl = " ";
  late String path = " ";
  late String name = " ";
  DocumentReference sightingRef =
      FirebaseFirestore.instance.collection('product').doc();
  final Storage storage = Storage();

  Future<void> sendToDB() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currUser = _auth.currentUser;
    String user = (currUser!.email) as String;

    FirebaseFirestore.instance
        .collection('users')
        .doc(currUser.email)
        .collection('sell')
        .doc(_productName.text)
        .set({
      "name": _productName.text,
      "image": imgUrl,
      'category': _productCategory.text,
      'description': _productDescription.text,
      'quantity': _productQuantity.text,
      'price': _productPrice.text,
    });
    FirebaseFirestore.instance
        .collection('products')
        .doc(_productName.text)
        .set({
      "name": _productName.text,
      "image": imgUrl,
      'category': _productCategory.text,
      'description': _productDescription.text,
      'quantity': _productQuantity.text,
      'price': _productPrice.text,
    });
  }

  Future getImage(bool gallery) async {
    ImagePicker picker = ImagePicker();
    XFile? pickedFile;
    // Let user select photo from gallery
    if (gallery) {
      pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
      );
    }
    // Otherwise open camera to get new photo
    else {
      pickedFile = await picker.pickImage(
        source: ImageSource.camera,
      );
    }

    setState(() {
      if (pickedFile != null) {
        print('hello');
        print(pickedFile.path);
        _pickedImage = File(pickedFile.path);
        //_image = File(pickedFile.path); // Use if you only need a single picture
      } else {
        print('No image selected.');
      }
    });
  }

  Future<String?> uploadFile(File _image) async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('product/${Path.basename(_image.path)}');
    UploadTask uploadTask = storageReference.putFile(_image);
    TaskSnapshot taskSnapshot = await await uploadTask;
    print('File Uploaded');
    String? returnURL;
    await (await storageReference).getDownloadURL().then((fileURL) {
      print(fileURL);
      print("AAAAAAAAAAAAAAAAAAAAAAAAAeeeeeeeeeeeeee");
      imgUrl = fileURL;
    });
  }

  Future<void> saveImages(File _pickedImage, DocumentReference ref) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currUser = _auth.currentUser;
    String user = (currUser!.email) as String;
    if (_pickedImage == null) {
      print("AAAAAAAAAAAAAAAAAAa");
    }
    print('inside SaveImages Functionnnnnnnnnnnnnnnnnnnnnnnn');

    String? URL = await await uploadFile(_pickedImage);
    print(URL);
    print("knnnnnnnnnnnnnnnn");
    // imgUrl = URL!;
    print(imgUrl);
    print("FFFFFFFFFFFFFFFFFFF0");
    print(URL);
    // print(imageURL);
    //  FirebaseFirestore.instance.collection(user).add({
    //       "key": FieldValue.arrayUnion([imageURL]) //your data which will be added to the collection and collection will be created after this
    //     }).then((_){
    //       print("collection created");
    //     }).catchError((_){
    //       print("an error occured");
    //     });
    // ref.update({"images": FieldValue.arrayUnion([imageURL])});

    ;
  }
  // Future pickImage() async {
  //   try {
  //     final _pickedImage =
  //         await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if (_pickedImage == null) return;

  //     final imageTemp = File(_pickedImage.path);
  //     setState(() => this._pickedImage = imageTemp);
  //   } on PlatformException catch (e) {
  //     print('Fail to pick image $e');
  //   }
  // }

  void _pickCamera() async {
    final _pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (_pickedImage == null) return;
    final imageTemp = File(_pickedImage.path);
    path = _pickedImage.path;
    name = _pickedImage.name;
    storage
        .uploadFile(path, name)
        .then((value) => print("Successfulllllllllll"));
    setState(() => this._pickedImage = imageTemp);

    Navigator.pop(context);
  }

  void _pickGallery() async {
    final _pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (_pickedImage == null) return;
    final imageTemp = File(_pickedImage.path);
    path = _pickedImage.path;
    name = _pickedImage.name;
    storage
        .uploadFile(path, name)
        .then((value) => print("Successfulllllllllll"));
    setState(() => this._pickedImage = imageTemp);

    Navigator.pop(context);
  }

  void _delete() {
    setState(() {
      _pickedImage = File('');
    });
    Navigator.pop(context);
  }

  // void _imgBD(){
  //   try{
  //     if(_pickedImage == null){

  //     }
  //   }
  // }
  // List<File> _pickedImage = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 0, 234, 255),
          iconTheme: IconThemeData(color: Colors.black),
          title: const Text('Add Product'),
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
                    padding: const EdgeInsets.fromLTRB(50, 50, 50, 200),
                    child: Column(
                      children: <Widget>[
                        Text('Add Product to Sell',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic)),
                        const SizedBox(
                          height: 30,
                        ),
                        Stack(
                          children: [
                            Container(
                                child: CircleAvatar(
                              radius: 90,
                              backgroundColor: Colors.blue,
                              child: CircleAvatar(
                                radius: 85,
                                backgroundImage: _pickedImage == null
                                    ? null
                                    : FileImage(_pickedImage),
                              ),
                              // backgroundImage: _pickedImage
                            )),
                            Positioned(
                              top: 120,
                              left: 120,
                              child: RawMaterialButton(
                                elevation: 15,
                                fillColor: Colors.blue,
                                child: Icon(Icons.camera),
                                padding: EdgeInsets.all(15),
                                shape: CircleBorder(),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            title: const Text('Choose Option',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            content: SingleChildScrollView(
                                              child: ListBody(children: [
                                                InkWell(
                                                  onTap: () async {
                                                    getImage(false);
                                                    if (_pickedImage == null) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(SnackBar(
                                                              content: Text(
                                                                  'No photo taken')));
                                                    }
                                                  },
                                                  splashColor:
                                                      Colors.greenAccent,
                                                  child: Row(children: const [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Icon(
                                                        Icons.camera,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Camera',
                                                    )
                                                  ]),
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    getImage(true);
                                                    if (_pickedImage == null) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              const SnackBar(
                                                                  content: Text(
                                                                      'No photo taken')));
                                                    }
                                                  },
                                                  splashColor:
                                                      Colors.greenAccent,
                                                  child: Row(children: const [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Icon(
                                                        Icons.photo,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Gallery',
                                                    )
                                                  ]),
                                                ),
                                                InkWell(
                                                  onTap: _delete,
                                                  splashColor:
                                                      Colors.greenAccent,
                                                  child: Row(children: const [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Icon(
                                                        Icons.remove,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Remove',
                                                    )
                                                  ]),
                                                )
                                              ]),
                                            ));
                                      });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FloatingActionButton.extended(
                          // Theme.of(context).colorScheme.secondary,
                          icon: Icon(
                            Icons.add_circle,
                            color: Colors.black,
                          ),
                          label: Text("Confirm Image"),
                          elevation: 8,
                          extendedPadding: EdgeInsets.all(50),
                          onPressed: () async {
                            await saveImages(_pickedImage, sightingRef);
                          },
                          //  EdgeInsets.all(15),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text.rich(TextSpan(
                            text: "Enter Product Details ",
                            style: TextStyle(fontSize: 20))),
                        const SizedBox(
                          height: 10,
                        ),
                        ruTextField("Enter Product Name", Icons.store, false,
                            _productName),
                        const SizedBox(
                          height: 15,
                        ),
                        ruTextField("Enter Product Description",
                            Icons.description, false, _productDescription),
                        const SizedBox(
                          height: 15,
                        ),
                        ruTextField("Enter category", Icons.category, false,
                            _productCategory),
                        const SizedBox(
                          height: 15,
                        ),
                        ruTextField("Enter the quantity", Icons.numbers, false,
                            _productQuantity),
                        const SizedBox(
                          height: 15,
                        ),
                        ruTextField("Enter the price", Icons.money_sharp, false,
                            _productPrice),
                        const SizedBox(
                          height: 15,
                        ),
                        ruButton(context, "Add", () {
                          if (_productCategory.text.isEmpty ||
                              _productDescription.text.isEmpty ||
                              _productName.text.isEmpty ||
                              _productPrice.text.isEmpty ||
                              _productQuantity.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Please fill all fields",
                                toastLength: Toast.LENGTH_SHORT,
                                timeInSecForIosWeb: 2,
                                gravity: ToastGravity.TOP,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else if (imgUrl == "") {
                            Fluttertoast.showToast(
                                msg: "Please add an image",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            sendToDB();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const sellScreen()));
                          }
                        })
                        // FirebaseFirestore.instance
                        //       .collection('users')
                        //       .doc(currentUser!.email)
                        //       .collection('sell')
                        //       .doc(_productName.text)
                        //       .set({
                        //     'name': _productName.text,
                        //     'category': _productCategory.text,
                        //     'description': _productDescription.text,
                        //     'quantity': _productQuantity.text,
                        //   });
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => buyScreen()));

                        //   FirebaseAuth.instance
                        //       .createUserWithEmailAndPassword(
                        //           email: _emailTextController.text,
                        //           password: _passwordTextController.text)
                        //       .then((value) {
                        //     print(
                        //         "Created ${_userNameTextController.text}'s account");
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) => HomeScreen()));
                        //   }).onError((error, stackTrace) {
                        //     SnackBar(
                        //         content: Text("Error: ${error.toString()}"));
                        //   });
                        // }),
                        // loginInRe(),
                      ],
                    )))));
  }
}
