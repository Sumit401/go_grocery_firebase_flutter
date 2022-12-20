import 'package:cabs/reusable_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

var cart_value=0;


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
                          const Text("Price: ",
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
                  children:  [
                    InkWell(child: Icon(FontAwesomeIcons.minus),
                    onTap: () async {

                      String? grocery_id = snapshot.data?.docs[index].reference.id;
                            FirebaseFirestore.instance
                                .collection("Cart")
                                .where("grocery_id", isEqualTo: grocery_id)
                                .get()
                                .then((value) {
                              value.docs.forEach((element) {
                                FirebaseFirestore.instance
                                    .collection("Cart")
                                    .doc(element.id)
                                    .delete()
                                    .then((value) {
                                  print("Success!");
                                });
                              });
                            });
                          }),
                    VerticalDivider(width: 10,),
                    Text((get_value(snapshot.data?.docs[index].reference.id)),style: TextStyle(fontSize: 20)),
                    VerticalDivider(width: 10,),
                    InkWell(child: Icon(FontAwesomeIcons.plus),onTap: () async {
                      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                      var email = sharedPreferences.getString("email").toString();
                      String? docid = snapshot.data?.docs[index].reference.id;
                      Map<String,String?> data_to_save={
                        "grocery_id":docid,
                        "quantity":"1",
                        "email":email,
                        "name": snapshot.data!.docs[index]['name'],
                        "price": snapshot.data!.docs[index]['price'],
                        "si": snapshot.data!.docs[index]['si'],
                        "image": snapshot.data!.docs[index]['image'],

                      };
                      var collectionRef = await FirebaseFirestore.instance
                          .collection("Cart");
                      collectionRef.add(data_to_save);
                    },),
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
