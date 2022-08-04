// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:final_project/constants/firebase.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:get/get.dart';

// class uploadPhoto extends GetxController {
//   _uploadPhotoDB(String id, String videoPath) {
//     Reference ref = FirebaseStorage.ref().child('photos').child(id);
//   }

//   Photo(String name, String path) async {
//     try {
//       var _firestoreInstance = FirebaseFirestore.instance;
//       var currUser = FirebaseAuth.instance.currentUser;

//       DocumentSnapshot userDoc = await firebaseFirestore
//           .collection('users')
//           .doc(currUser!.email)
//           .collection('sell')
//           .doc(name)
//           .get();
//       var allDocs = await firebaseFirestore.collection('photos').get();
//       int len = allDocs.docs.length;

//       _uploadPhotoDb("Photo $len", path);
//     } catch (e) {}
//   }
// }
