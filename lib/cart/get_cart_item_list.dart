import 'package:cabs/grocery_list/alert_dialog.dart';
import 'package:cabs/reusable_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget get_cart_items_list(
    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot, int index, BuildContext context) {
  return InkWell(
    child: Card(
      elevation: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(margin: EdgeInsets.only(left: 10),child: Image.network(snapshot.data!.docs[index]['image'],width: 100,height: 100,fit: BoxFit.fitWidth,)),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(snapshot.data!.docs[index]['name'],style: TextStyle(fontSize: 20, fontWeight:FontWeight.w500),overflow: TextOverflow.clip,),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Price: ",style: TextStyle(fontWeight: FontWeight.w700),overflow: TextOverflow.clip,),
                    Text(" \u{20B9} ",overflow: TextOverflow.clip,),
                    Text(snapshot.data!.docs[index]['price'].toString(),overflow: TextOverflow.clip,),
                    Text(" / ",overflow: TextOverflow.clip,),
                    Text(snapshot.data!.docs[index]['si'],overflow: TextOverflow.clip,),
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
                  padding: EdgeInsets.all(8.0),
                  child: InkWell(child: Icon(FontAwesomeIcons.minus),onTap: () async {
                    if(snapshot.data!.docs[index]['quantity']>1) {
                      FirebaseFirestore.instance.collection("Cart")
                          .doc(snapshot.data?.docs[index].reference.id)
                          .update({"quantity": snapshot.data!.docs[index]['quantity'] - 1}
                      );
                    }else{
                      FirebaseFirestore.instance.collection("Cart")
                          .doc(snapshot.data?.docs[index].reference.id).delete();
                    }
                    getcart_item_pricecount();
                  }),
                ),
                Text(snapshot.data!.docs[index]['quantity'].toString(),style: TextStyle(fontSize: 15),overflow: TextOverflow.clip,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(child: Icon(FontAwesomeIcons.plus),onTap: () async {
                    FirebaseFirestore.instance.collection(
                        "Cart").doc(snapshot.data?.docs[index].reference.id).update(
                        {"quantity": snapshot.data!.docs[index]['quantity']+1});
                    getcart_item_pricecount();
                  },),
                ),
              ],
            ),
          )
        ],
      ),
    ),
    onTap: () {
      alert_dialog(context,snapshot,index);
    },
  );
}
