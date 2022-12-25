import 'package:cabs/cart/cart_navigation.dart';
import 'package:cabs/cart/payment.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cabs/reusable_widgets.dart';
import 'package:geolocator/geolocator.dart';


class checkout extends StatefulWidget {
  const checkout({Key? key}) : super(key: key);

  static const route = "/checkout";

  @override
  State<checkout> createState() => _checkoutState();
}



class _checkoutState extends State<checkout> {

  @override
  void initState() {
    super.initState();
    getsharedpreference();
  }
  TextEditingController user_email=  TextEditingController();
  TextEditingController user_name =  TextEditingController();
  TextEditingController user_address = TextEditingController();
  TextEditingController user_state = TextEditingController();
  TextEditingController user_contactnum = TextEditingController();
  TextEditingController user_zipcode = TextEditingController();
  
  String cart_value = "";
  String cart_price = "";
  int shipping_charges = 0;
  int total_payable_amount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottomNavigationBar: bottom_navbar(),
      appBar: AppBar(
          leading:
              InkWell(onTap: () {
                Navigator.pop(context);
              },child: Icon(FontAwesomeIcons.angleLeft, color: Colors.white, size: 30)),
          title: Text("Price Details",
              style: TextStyle(color: Colors.white, fontSize: 20)),
          elevation: 10,
          backgroundColor: Colors.blueAccent,
          centerTitle: true),
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.only(top: 20),
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 20,
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                        Colors.brown,
                        Colors.deepPurpleAccent
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          //Text("Price Details", style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Price ($cart_value items)",
                                  style: TextStyle(fontSize: 20,color: Colors.white),
                                ),
                                Text(
                                  "\u{20B9} $cart_price",
                                  style: TextStyle(fontSize: 20,color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Shipping Charges",
                                  style: TextStyle(fontSize: 20,color: Colors.white),
                                ),
                                Text(
                                  "+ \u{20B9} $shipping_charges",
                                  style: const TextStyle(fontSize: 20,color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const <Widget>[
                                Text(
                                  "Discount",
                                  style: TextStyle(fontSize: 20,color: Colors.white),
                                ),
                                Text(
                                  "- \u{20B9} 0",
                                  style: TextStyle(fontSize: 20,color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Payable Amount",
                                  style: TextStyle(fontSize: 20,color: Colors.white),
                                ),
                                Text(
                                  "\u{20B9} $total_payable_amount",
                                  style: TextStyle(fontSize: 20,color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(height: 2, color: Colors.black),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  margin: const EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Shipping Details",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 25)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: user_name,
                          decoration: InputDecoration(labelText: "Name"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: user_email,
                          enabled: false,
                          readOnly: true,
                          decoration: InputDecoration(labelText: "Email"),
                        ),
                      ),
                       Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          minLines: 3,
                          maxLines: 3,
                          keyboardType: TextInputType.multiline,
                          controller: user_address,
                          decoration: InputDecoration(
                              labelText: "Address",
                              suffixIcon: InkWell(
                                onTap: () async {
                                  Position position = await determinePosition();
                                  getaddress(position).then((value) {
                                    if (this.mounted) {
                                      setState(() {
                                        String? address="${value.street},${value.thoroughfare},${value.subLocality},${value.locality}";
                                        user_address.text=address;
                                        String? state =value.administrativeArea;
                                        user_state.text=state!;
                                        String? pin =value.postalCode;
                                        user_zipcode.text=pin!;
                                      });
                                    }
                                  },);
                                },
                                child: Icon(
                                  FontAwesomeIcons.locationCrosshairs,
                                  color: Colors.black,
                                ),
                              )),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: user_state,
                              decoration:
                                  InputDecoration(labelText: "State"),
                            ),
                          )),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: user_zipcode,
                              decoration: InputDecoration(labelText: "Pin"),
                            ),
                          )),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: user_contactnum,
                          decoration: InputDecoration(labelText: "Contact No"),
                          autocorrect: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(10)),
                            onPressed: () {
                              payment_razorpay(total_payable_amount,user_email.text,user_contactnum.text);
                            },
                            child: const Text("Place Order")),
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  void getsharedpreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var name = sharedPreferences.getString("user_name").toString();
    var email = sharedPreferences.getString("user_email").toString();
    int? value = sharedPreferences.getInt("cart_value");
    int? price = sharedPreferences.getInt("cart_price");

      if (this.mounted) {
        setState(() {
          cart_price = price.toString();
          user_name.text = name;
          cart_value = value.toString();
          user_email.text = email;
          if (price! < 500) {
            shipping_charges = 0;
          } else if (price > 500 && price < 800) {
            shipping_charges = 0;
          } else {
            shipping_charges = 0;
          }
          total_payable_amount = (price + shipping_charges);
        });
      }
  }
}
