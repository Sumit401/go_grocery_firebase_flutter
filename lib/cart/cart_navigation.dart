import 'package:cabs/bottom_navbar/bottom_navbar.dart';
import 'package:cabs/cart/checkout.dart';
import 'package:cabs/cart/get_cart_item_list.dart';
import 'package:cabs/reusable_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class cart_item extends StatefulWidget {
  const cart_item({Key? key}) : super(key: key);
  static const route = "/cart_item";

  @override
  State<cart_item> createState() => _cart_itemState();
}

var fire_storedb = FirebaseFirestore.instance.collection("Cart").snapshots();
var user_email = "";
int cart_value=0;
var data_value ="0";

class _cart_itemState extends State<cart_item> {
  @override
  void initState() {
    getsharedpreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar_display("Your Cart"),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: listview(),
              height: MediaQuery.of(context).size.height / 1.3,
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: checkout_button(context)
                ))
          ],
        ),
      ),
      bottomNavigationBar: bottom_navbar(),
    );
  }


  Widget listview() {
    return Container(
      alignment: Alignment.center,
      child: Card(
        child: StreamBuilder(
          stream: fire_storedb,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            return (ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                if (snapshot.data!.docs[index]['email'].toString() == user_email) {
                  return (get_cart_items_list(snapshot, index));
                }
                else {
                  return (Container());
                }
              },
            ));
          },
        ),
      ),
    );
  }
  void getsharedpreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var email = sharedPreferences.getString("user_email").toString();
    setState(() {
      user_email = email;
    });
  }
}