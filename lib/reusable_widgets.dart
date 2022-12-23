
import 'package:cabs/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoding/geocoding.dart';


final firebase_auth=FirebaseAuth.instance;
final google_signin=GoogleSignIn();

Widget formfield_for_email(String text,
    TextEditingController editingController) {
  return (Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white),
      child: TextFormField(
          controller: editingController,
          autocorrect: true,
          decoration: InputDecoration(
            labelText: text,
            border: InputBorder.none,
          ),
          validator: MultiValidator([
            RequiredValidator(errorText: "Required"),
            EmailValidator(errorText: "Enter Valid Email")
          ]))));
}

Widget formfield_for_password(String text,
    TextEditingController editingController) {
  return (Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white),
      child: TextFormField(
          obscureText: true,
          controller: editingController,
          autocorrect: true,
          decoration: InputDecoration(
            labelText: text,
            border: InputBorder.none,
          ),
          validator: MultiValidator([
            RequiredValidator(errorText: "Required"),
            MinLengthValidator(6, errorText: "Minimum length 6")
          ]))));
}

Widget formfield_for_name(String text,TextEditingController editingController) {
  return (Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white),
      child: TextFormField(
          controller: editingController,
          autocorrect: true,
          decoration: InputDecoration(
            labelText: text,
            border: InputBorder.none,
          ),
          validator: RequiredValidator(errorText: "Required"))));
}

Widget google_sign_in_buttons(BuildContext context) {
  return (
      ElevatedButton(
        onPressed: () async{
          try{
            final GoogleSignInAccount? googleSigninAccount= await google_signin.signIn();
            if(googleSigninAccount!= null){
              final GoogleSignInAuthentication googleSigninAuth = await googleSigninAccount.authentication;
              final AuthCredential authcredential= GoogleAuthProvider.credential(
                accessToken: googleSigninAuth.accessToken,
                idToken: googleSigninAuth.idToken
              );
              await firebase_auth.signInWithCredential(authcredential);
              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
              sharedPreferences.setString("email", (FirebaseAuth.instance.currentUser?.email).toString());
              sharedPreferences.setString("name", (FirebaseAuth.instance.currentUser?.displayName).toString());
              sharedPreferences.setString("user_image", (FirebaseAuth.instance.currentUser?.photoURL).toString());
              Navigator.pop(context);
              Navigator.pushNamed(context, homepage.route);
            }
          }on FirebaseAuthException catch(e){
            print(e.toString());
            throw e;
          }
        },
        style: const ButtonStyle(
            shape: MaterialStatePropertyAll(CircleBorder()),
            backgroundColor:
            MaterialStatePropertyAll(Colors.white)),
        child: Image.asset(
          "assets/images/google_logo.png",
          width: 50,
          height: 50,
        ),
      )
  );
}

Widget facebook_sign_in_button() {
  return (ElevatedButton(
    onPressed: () {},
    style: const ButtonStyle(
        shape: MaterialStatePropertyAll(CircleBorder()),
        backgroundColor:
        MaterialStatePropertyAll(Colors.white)),
    child: Image.asset(
      "assets/images/fb_logo.png",
      width: 50,
      height: 50,
    ),
  ));
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

google_sign_out() async{
  firebase_auth.signOut();
  google_signin.signOut();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.remove("email");
}



Future<int> cart() async{
  int cart_value=0;
  int cart_price=0;
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var email = sharedPreferences.getString("email").toString();
  FirebaseFirestore.instance.collection("Cart").get().then((value) {
    value.docs.forEach((element) {
      FirebaseFirestore.instance.collection("Cart").doc(element.id).get().then((value2) => {
        if(value2.data()!['email']==email){
          cart_value = cart_value + (value2.data()!['quantity']) as int,
          cart_price = cart_price + ((value2.data()!['price']) as int) * ((value2.data()!['quantity']) as int),
          sharedPreferences.setInt("cart_price", cart_price),
          sharedPreferences.setInt("value", cart_value),
          //print(sharedPreferences.getInt("value")),
          //print(sharedPreferences.getInt("cart_price"))
        }
      });
    });
  });
    return(cart_value);
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

Future<Placemark> getaddress (Position position) async {
  List placemark = await placemarkFromCoordinates(position.latitude, position.longitude);
  //print(placemark[0]);
  print(placemark[0]);
  return placemark[0];
}

  /*FirebaseFirestore.instance.collection("Cart").get().then((value) {
    value.docs.forEach((element) { 
      FirebaseFirestore.instance.collection("Cart").doc(element.id).get().then((value2) => {
        if(value2.data()!['grocery_id']==docid)
        s=(value2.data()!['quantity'])
      });
    });
  });
  )*/

