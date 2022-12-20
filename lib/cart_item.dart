import 'package:cabs/bottom_navbar.dart';
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
var user_email="";

class _cart_itemState extends State<cart_item> {

  @override
  void initState() {
    getsharedpreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.asset(
              "assets/images/app_logo.png",
              width: 70,
              height: 70,
            ),
          ),
          title: Text("Cart", style: TextStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor: Colors.white),
      body: Container(
        child: StreamBuilder(stream:fire_storedb,builder:(context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
            return (ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
               if(snapshot.data!.docs[index]['email'].toString()==user_email){

                 return(
                     Row(children: [
                       Text(snapshot.data!.docs[index]['name']),
                       Text(snapshot.data!.docs[index]['price']),
                       Text(snapshot.data!.docs[index]['si']),

                     ],)
                 );
               }else{
                 return Container();
               }
              },
            ));
          },
        ),
      ),
      bottomNavigationBar: bottom_navbar(),
    );
  }

  void getsharedpreferences() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var email = sharedPreferences.getString("email").toString();
    setState(() {
      user_email=email;
    });
  }
}
/*
if (Text(snapshot.data!.docs[index]['email'])==){
Row(children: [
Text(snapshot.data!.docs[index]['name']),
Text(snapshot.data!.docs[index]['price']),
Text(snapshot.data!.docs[index]['si']),
Text(snapshot.data!.docs[index]['email']),
],)
}else{

}*/
