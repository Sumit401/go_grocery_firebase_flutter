import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget grocery_list(AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
    int index, BuildContext context) {
  return Row(children: [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: MediaQuery.of(context).size.width-45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Image.network(
                        snapshot.data!.docs[index]['image'].toString(),
                        height: 100,
                        width: 100)),

                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        child: Text(
                          (snapshot.data!.docs[index]['name']),
                          style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Price: ",
                              style:
                              TextStyle(fontWeight: FontWeight.w700)),
                          Text("\u{20B9}"),
                          Text((snapshot.data!.docs[index]['price'])),
                          Text(" / "),
                          Text((snapshot.data!.docs[index]['si'])),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Icon(FontAwesomeIcons.minus),
                    VerticalDivider(width: 10,),
                    Text("0",style: TextStyle(fontSize: 20),),
                    VerticalDivider(width: 10,),
                    Icon(FontAwesomeIcons.plus),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  ],);
}
