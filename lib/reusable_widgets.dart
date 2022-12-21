import 'package:cabs/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';


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




Future<int> cart(String? id) async{
  int cart_value= 0;
  var cart = await FirebaseFirestore.instance.collection("Cart").get();
  for (var element in cart.docs) {
    FirebaseFirestore.instance.collection("Cart").doc(element.id).get().then((value2) => {
      if(value2.data()!['grocery_id']==id){
        cart_value = (value2.data()!['quantity']),
       // print(cart_value)
      }
    });
  }
    //print("Return $cart_value");
    return cart_value;
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

