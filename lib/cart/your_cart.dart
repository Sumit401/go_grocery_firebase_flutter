import 'package:cabs/bottom_navbar/bottom_navbar.dart';
import 'package:cabs/cart/get_cart_item_list.dart';
import 'package:cabs/reusable_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class your_cart extends StatefulWidget {
  const your_cart({Key? key}) : super(key: key);
  static const route = "/cart_item";

  @override
  State<your_cart> createState() => _your_cartState();
}

var fire_storedb = FirebaseFirestore.instance.collection("Cart").snapshots();
var user_email = "";
int cart_value=0;
var data_value ="0";


class _your_cartState extends State<your_cart> {
  @override
  void initState() {
    getsharedpreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar_display("Your Cart"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 1.4,
            child: listview(),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.bottomCenter,
                child: checkout_button(context)
              ))
        ],
      ),
      bottomNavigationBar: bottom_navbar(),
    );
  }

  Widget listview() {
    return StreamBuilder(
      stream: fire_storedb,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(alignment: Alignment.center, child: CircularProgressIndicator());
        }
        return (ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            if (snapshot.data!.docs[index]['email'].toString() == user_email) {
              return (get_cart_items_list(snapshot, index,context));
            }
            else {
              return (Container());
            }
          },
        ));

      }
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