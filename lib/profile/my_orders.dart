import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'get_orders_list.dart';
import '../reusable_widgets.dart';

class my_orders extends StatefulWidget {
  const my_orders({Key? key}) : super(key: key);

  @override
  State<my_orders> createState() => _my_ordersState();
}

class _my_ordersState extends State<my_orders> {

  @override
  void initState() {
    getshared_preference();
    super.initState();
  }
  String user_email="";
  var firebase_auth=FirebaseFirestore.instance.collection("orders").snapshots();

  int count=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_bar_with_back_button(context,"My Orders"),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        child: StreamBuilder(
          stream: firebase_auth,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
                return Container(alignment: Alignment.center, child: const CircularProgressIndicator());
              }

            return Container(
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.size,
                  itemBuilder: (context, index) {
                    if (snapshot.data!.docs[index]["email"] ==
                        user_email.toString()) {
                      return (get_myorders_list(snapshot, index));
                    } else
                      return (Container());
                  },),
              );
            }
            ,

        ),
      ),
    );
  }

  void getshared_preference() async{
    SharedPreferences preferences= await SharedPreferences.getInstance();
    String email=preferences.getString("user_email").toString();
    setState(() {
      user_email=email;
    });
  }
}
