import 'package:cabs/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class checkout extends StatefulWidget {
  const checkout({Key? key}) : super(key: key);

  static const route ="/checkout";

  @override
  State<checkout> createState() => _checkoutState();
}
String cart_value="";
String cart_price="";
String user_email="";
int shipping_charges=0;

class _checkoutState extends State<checkout> {
  @override
  void initState() {
    getsharedpreference();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottomNavigationBar: bottom_navbar(),
      appBar: AppBar(
          title: Text("Checkout", style: TextStyle(color: Colors.blue)),
          elevation: 10,
          backgroundColor: Colors.white,
          centerTitle: true),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        alignment: Alignment.topCenter,
          child: Column(
            children: [
              Text("Price Details", style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Price($cart_value items)", style: TextStyle(fontSize: 20),),
                    Text(cart_price, style: TextStyle(fontSize: 20),),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Shipping Charges", style: TextStyle(fontSize: 20),),
                    Text(shipping_charges.toString(),style: TextStyle(fontSize: 20),),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  void getsharedpreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var email = sharedPreferences.getString("email").toString();
    var value = sharedPreferences.getInt("value").toString();
    int? price = sharedPreferences.getInt("cart_price");
    setState(() {
      /*print(value);*/
      cart_price=price.toString();
      cart_value=value;
      user_email = email;
      if(price!<500){
        shipping_charges=80;
      }else if(price>500 && price<800){
        shipping_charges=40;
      }else{
        shipping_charges=0;
      }
    });
  }
}
