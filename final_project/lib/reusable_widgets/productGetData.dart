import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget fetchData() {
  return StreamBuilder(
    stream: FirebaseFirestore.instance.collection("products").snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return Center(
          child: Text("Something is wrong"),
        );
      }

      return ListView.builder(
          itemCount: snapshot.data == null ? 0 : snapshot.data!.docs.length,
          itemBuilder: (_, index) {
            DocumentSnapshot _documentSnapshot = snapshot.data!.docs[index];

            return Card(
              elevation: 5,
              child: ListTile(
                leading: Text(_documentSnapshot['name']),
                title: Text(
                  "\$ ${_documentSnapshot['price']}",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ),
            );
          });
    },
  );
}
