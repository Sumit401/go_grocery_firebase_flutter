import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


Widget get_cart_items_list(
    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot, int index) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: Card(
      elevation: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(margin: EdgeInsets.only(left: 10),child: Image.network(snapshot.data!.docs[index]['image'],width: 100,height: 100,)),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(snapshot.data!.docs[index]['name'],style: TextStyle(fontSize: 20, fontWeight:FontWeight.w500 )),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Rs "),
                    Text(snapshot.data!.docs[index]['price']),
                    Text(" / "),
                    Text(snapshot.data!.docs[index]['si']),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(child: Icon(FontAwesomeIcons.minus),onTap: () async {
                    if(snapshot.data!.docs[index]['quantity']>1) {
                      FirebaseFirestore.instance.collection(
                          "Cart")
                          .doc(snapshot.data?.docs[index].reference.id)
                          .update(
                          {"quantity": snapshot.data!.docs[index]['quantity'] -
                              1}
                      );
                    }else{
                      FirebaseFirestore.instance.collection(
                          "Cart")
                          .doc(snapshot.data?.docs[index].reference.id).delete();
                    }
                  }),
                ),
                Text(snapshot.data!.docs[index]['quantity'].toString(),style: TextStyle(fontSize: 15)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(child: Icon(FontAwesomeIcons.plus),onTap: () async {
                    FirebaseFirestore.instance.collection(
                        "Cart").doc(snapshot.data?.docs[index].reference.id).update(
                        {"quantity": snapshot.data!.docs[index]['quantity']+1});

                  },),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
