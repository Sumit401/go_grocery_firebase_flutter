import 'package:cabs/grocery_list/alert_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

var cart_value = 0;

Widget grocery_list(
    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
    int index,
    BuildContext context) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          child: Card(
            elevation: 20,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width - 45,
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
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text("Price: ",
                                  style: TextStyle(fontWeight: FontWeight.w700)),
                              const Text("\u{20B9}"),
                              Text((snapshot.data!.docs[index]['price'].toString())),
                              const Text(" / "),
                              Text((snapshot.data!.docs[index]['si'])),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          child: Icon(FontAwesomeIcons.plus),
                          onTap: () async {
                            int k = 0;
                            String? docid = snapshot.data?.docs[index].reference.id;
                            SharedPreferences sharedPreferences =
                            await SharedPreferences.getInstance();
                            var user_email = sharedPreferences.getString("user_email").toString();
                            Map<String,dynamic> data_to_save = {
                              "grocery_id": docid,
                              "quantity": 1,
                              "email": user_email,
                              "name": snapshot.data!.docs[index]['name'],
                              "price": snapshot.data!.docs[index]['price'],
                              "si": snapshot.data!.docs[index]['si'],
                              "image": snapshot.data!.docs[index]['image'],
                            };

                            FirebaseFirestore.instance.collection("Cart").get().then((value) {
                              value.docs.forEach((element) {
                                FirebaseFirestore.instance.collection("Cart").doc(element.id).get().then((value2) =>
                                {
                                  if(value2.data()!['grocery_id'] == docid && value2.data()!['email']==user_email)
                                    {
                                      cart_value = (value2.data()!['quantity']),
                                      FirebaseFirestore.instance.collection(
                                          "Cart").doc(element.id).update(
                                          {"quantity": cart_value+1})
                                    }else {
                                    k+=1,
                                    if(value.docs.length==k){
                                      FirebaseFirestore.instance
                                          .collection("Cart")
                                          .add(data_to_save),
                                    }
                              }
                                });
                                });
                            });
                          },
                        ),
                        const VerticalDivider(
                          width: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          onTap: () {
            alert_dialog(context,snapshot,index);
          },
        ),
      ),
    ],
  );
}
