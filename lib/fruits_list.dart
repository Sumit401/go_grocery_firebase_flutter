import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget fruits_list(
    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot, int index, BuildContext context) {
  return SingleChildScrollView(
    child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Card(
            shape: const RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(25))),
            elevation: 20,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: ListTile(
                dense: true,
                title: Center(
                    child: Text(
                  (snapshot.data!.docs[index]['name']),
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                )),

                leading: SizedBox(child: Image.network(snapshot.data!.docs[index]['image'].toString(),fit: BoxFit.fitWidth)),

                subtitle: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Price: ", style: TextStyle(fontWeight: FontWeight.w700)),
                          Text("\u{20B9}"),
                          Text((snapshot.data!.docs[index]['price'])),
                          Text(" / "),
                          Text((snapshot.data!.docs[index]['si'])),
                        ],
                      ),
                    ],
                  ),
                ),
                trailing: SizedBox(
                  height: 100, width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(FontAwesomeIcons.minus),
                      Text(" 0 ",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700),),
                      Icon(FontAwesomeIcons.plus),
                    ],
                  ),
                ),
              ),
            ))),
  );
}
