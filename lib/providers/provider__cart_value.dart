import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Provider_cartvalue with ChangeNotifier {

  int? cart_value;
  int? cart_price;

  Future<void> check_cart_value() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var email = sharedPreferences.getString("user_email").toString();
    await FirebaseFirestore.instance.collection("Cart").get().then((value)  async {
      value.docs.forEach((element) async {
        cart_value = 0;
        cart_price = 0;
        await FirebaseFirestore.instance.collection("Cart").doc(element.id).get().then((value2) => {
          if(value2.data()!['email']==email){
            cart_value = cart_value! + (value2.data()!['quantity']) as int,
            cart_price = (cart_price! + ((value2.data()!['price']) as int) * ((value2.data()!['quantity']) as int)),
          }
        });
        //print("CP1 $cart_price");
        notifyListeners();
      });
      //print("CP2 $cart_price");
    });
    //print("CP3 $cart_price");
  }
}
