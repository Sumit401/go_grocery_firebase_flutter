import 'package:cabs/cart/checkout.dart';
import 'package:cabs/profile/dialog_box.dart';
import 'package:cabs/grocery_list/grocery_items_listview.dart';
import 'package:cabs/homepage.dart';
import 'package:cabs/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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

Widget button_for_registration(BuildContext context, String userEmail, String userPassword, String userName){
  return ElevatedButton(
      onPressed: () {
        FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: userEmail,
            password:userPassword)
            .then((value) async{
          //print("Registration Successful");
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString("user_email", userEmail);
          sharedPreferences.setString("user_name", userName);
          short_flutter_toast("Registration Successful");
          Navigator.pop(context);
          Navigator.pushNamed(context, login_page.route);
        }).onError((error, stackTrace) {
          FocusManager.instance.primaryFocus?.unfocus();
          long_flutter_toast("User Already Registered! Please Login");
          print(error.toString());
        });
      },
      child: Text("Register Now"),
      style: const ButtonStyle(
          backgroundColor:
          MaterialStatePropertyAll(Colors.lightGreen)));
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
              sharedPreferences.setString("user_email", (FirebaseAuth.instance.currentUser?.email).toString());
              sharedPreferences.setString("user_name", (FirebaseAuth.instance.currentUser?.displayName).toString());
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
    onPressed: () {
    },
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


AppBar appbar_display(String displayTitle){
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
  sharedPreferences.remove("name");
  sharedPreferences.remove("user_image");
  sharedPreferences.remove("cart_price");
  sharedPreferences.remove("value");
}



Future<int> getcart_item_pricecount() async{
  int cartValue=0;
  int cartPrice=0;
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var email = sharedPreferences.getString("user_email").toString();
  FirebaseFirestore.instance.collection("Cart").get().then((value) {
    value.docs.forEach((element) {
      FirebaseFirestore.instance.collection("Cart").doc(element.id).get().then((value2) => {
        if(value2.data()!['email']==email){
          cartValue = cartValue + (value2.data()!['quantity']) as int,
          cartPrice = cartPrice + ((value2.data()!['price']) as int) * ((value2.data()!['quantity']) as int),
          sharedPreferences.setInt("cart_price", cartPrice),
          sharedPreferences.setInt("cart_value", cartValue),
        }
      });
    });
  });
    return(cartValue);
  }

Widget checkout_button(BuildContext context){
  return ElevatedButton(
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
      onPressed: () async {
        getcart_item_pricecount();
        Navigator.pushNamed(context, checkout.route);
      },
      child: Text("Proceed to Checkout",style: TextStyle(color: Colors.white),));
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
            child: Text(
              categoryType,
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


Widget profile_navigations(BuildContext context, String tab){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    width: MediaQuery.of(context).size.width,
    child: ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(10),
        backgroundColor:
        MaterialStateProperty.all(Colors.lightBlueAccent),
      ),
      child: Text(tab,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      onPressed: () {
        if(tab=="About Us") {
          dialogbox_aboutus(context);
        } else if(tab=="Contact Us") {
          dialogbox_contactus(context);
        } else if(tab=="Logout") {
          google_sign_out();
          Navigator.pop(context);
          Navigator.pushNamed(context, login_page.route);
        }
      },
    ),
  );
}
