import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Get order data from Firebase
Widget get_myorders_list(
    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot, int index) {
  return Card(
    elevation: 10,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("OrderID",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700)),
                Text(snapshot.data!.docs[index]['payment_id'],style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Order Date",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700)),
                Text(snapshot.data!.docs[index]['date'].toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Item Count",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700)),
                Text(snapshot.data!.docs[index]['item_no'].toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Amount Paid",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700)),
                Text(snapshot.data!.docs[index]['cart_price'].toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400)),
              ],
            ),
          ),
          Text("Shipping Address",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700)),
          //Text(snapshot.data!.docs[index]['name']),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
                child: Text(snapshot.data!.docs[index]['name'] +", " + snapshot.data!.docs[index]['address'],
              overflow: TextOverflow.clip,textAlign: TextAlign.center,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400))),
          ),
        ],
      ),
    ),
  );
}
