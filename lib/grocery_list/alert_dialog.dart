import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future alert_dialog(BuildContext context,
    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot, int index) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        scrollable: true,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        icon: Image.network(snapshot.data!.docs[index]['image'].toString(),
            height: 100, width: 100),
        title: Text(snapshot.data!.docs[index]['name'].toString()),
        alignment: Alignment.center,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Price: ",
                style: TextStyle(fontWeight: FontWeight.w700)),
            const Text("\u{20B9}"),
            Text((snapshot.data!.docs[index]['price'].toString())),
            const Text(" / "),
            Text((snapshot.data!.docs[index]['si'])),
          ],
        ),
      );
    },
  );
}