import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget get_orders_list(
    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot, int index) {
  return Column(
    children: [
      Text(snapshot.data!.docs[index]['name']),
      Text(snapshot.data!.docs[index]['item_no'].toString()),
      Text(snapshot.data!.docs[index]['cart_price'].toString()),
      Text(snapshot.data!.docs[index]['payment_id']),
      Text(snapshot.data!.docs[index]['address']),
    ],
  );
}