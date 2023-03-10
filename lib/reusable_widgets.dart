import 'package:cabs/payment_checkout/price_detail_checkout.dart';
import 'package:cabs/grocery_list/grocery_items_listview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoding/geocoding.dart';





AppBar appbar_display(String displayTitle){

  if(displayTitle=="Your Cart") {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Image.asset(
          "assets/images/app_logo.png",
          width: 70,
          height: 70,
        ),
      ),
      title: Text(displayTitle, style: TextStyle(color: Colors.white)),
      centerTitle: true,
      backgroundColor: Colors.blueAccent);
  }
  else{
    return AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.asset(
              "assets/images/app_logo.png",
              width: 70,
              height: 70,
            ),
          ),
          title: Text(displayTitle, style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Colors.blueAccent);
  }
}

Future<bool?> long_flutter_toast(String message){
  return(
      Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      fontSize: 16.0));
}
Future<bool?> short_flutter_toast(String message){
  return(
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0));
}


Future<int> getcart_item_pricecount() async {
  int cartValue = 0;
  int cartPrice = 0;
  if (true) {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var email = sharedPreferences.getString("user_email").toString();
    await FirebaseFirestore.instance.collection("Cart").get().then((
        value) async {
      value.docs.forEach((element) async {
        await FirebaseFirestore.instance.collection("Cart")
            .doc(element.id)
            .get()
            .then((value2) =>
        {
          if(value2.data()!['email'] == email){
            cartValue = cartValue + (value2.data()!['quantity']) as int,
            cartPrice = cartPrice + ((value2.data()!['price']) as int) *
                ((value2.data()!['quantity']) as int),
            sharedPreferences.setInt("cart_price", cartPrice),
            sharedPreferences.setInt("cart_value", cartValue),
            print(cartValue)
          }
        });
      });
    });
    print("A $cartValue");
    return (cartValue);
  }
}

Widget checkout_button(BuildContext context){
  return Container(
    alignment: Alignment.center,
    child: ElevatedButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
        onPressed: () async {
          getcart_item_pricecount();
          Navigator.pushNamed(context, price_detail_checkout.route);
        },
        child: Text("Proceed to Checkout",style: TextStyle(color: Colors.white),)),
  );
}



// For Geo Location API
Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  return await Geolocator.getCurrentPosition();
}

// Get Place address API...................................
Future<Placemark> getaddress (Position position) async {
  List placemark = await placemarkFromCoordinates(position.latitude, position.longitude);
  return placemark[0];
}

Widget homepage_category(BuildContext context, String categoryType){
  return InkWell(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
            Container(
                child: categoryType == "Fresh Fruits" ? Image.asset("assets/images/fruits.jpg",
                  height: 100, width: 100,)
                    : categoryType == "Fresh Vegetables" ? Image.asset("assets/images/veg.jpg",
                  height: 100, width: 100,)
                    : categoryType == "Dairy Products" ? Image.asset("assets/images/dairy.jpg",
                  height: 100, width: 100,)
                    : categoryType == "Food-Grains" ? Image.asset("assets/images/food_grains.jpg",
                  height: 100, width: 100,)
                    : categoryType == "Cleaning and Household" ? Image.asset("assets/images/household.jpg",
                  height: 100, width: 100,)
                    : categoryType == "Beverages" ?Image.asset("assets/images/beverages.jpg",
                  height: 100, width: 100,) : Image.asset("assets/images/user_img.png", width: 100,height: 100,)
            ),
        Container(
            width: 120,
            padding: EdgeInsets.only(bottom: 20),
            child: Text(categoryType,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            )),
      ],
    ),
    onTap: () async {
      Navigator.push(context, MaterialPageRoute(builder:(context) => grocery_items_listview(categoryType: categoryType) ));
    });
}

Widget userimage_display(String userImage){
  return Container(
    width: 100,
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(50),
      image: const DecorationImage(
        image: AssetImage('assets/images/user_img.png'),
        fit: BoxFit.fill,
      ),
    ),
    child: FadeInImage.assetNetwork(
      fit: BoxFit.fitWidth,
      placeholder: 'assets/images/user_img.png',
      image: userImage,
      imageErrorBuilder: (context, error, stackTrace) {
        return (Image.asset(
          'assets/images/user_img.png',
          height: 100,
          width: 100,
        ));
      },
      height: 100,
      width: 100,
    ),
  );
}

AppBar app_bar_with_back_button(BuildContext context, String title){
  return AppBar(
      leading:
      InkWell(onTap: () {
        Navigator.pop(context);
      },child: Icon(FontAwesomeIcons.angleLeft, color: Colors.white, size: 30)),
      title: Text(title,
          style: TextStyle(color: Colors.white, fontSize: 20)),
      elevation: 10,
      backgroundColor: Colors.blueAccent,
      centerTitle: true);
}


count_no_of_orders() async {
  int count=0;
  SharedPreferences preferences=await SharedPreferences.getInstance();
  FirebaseFirestore.instance.collection('orders').get().then((value) {
    value.docs.forEach((element) {
      element.data().forEach((key, value2) {
        if(key=="email"&& value2== preferences.getString("user_email")){
          count++;
          preferences.setInt("count_no_of_orders", count);
        }
      });
    });
  },);

}
