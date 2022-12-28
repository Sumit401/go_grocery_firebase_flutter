import 'package:cabs/homepage/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

final firebase_auth=FirebaseAuth.instance;
final google_signin=GoogleSignIn();

Widget google_sign_in_buttons(BuildContext context) {
  return
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

        style: ButtonStyle(
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
          padding: const MaterialStatePropertyAll((EdgeInsets.only(right: 15,top: 3,bottom: 3,left: 8))),
          alignment: Alignment.center,
            backgroundColor: const MaterialStatePropertyAll(Colors.white)),
        child: Row(
          children: [
            Image.asset(
              alignment: Alignment.center,
              "assets/images/google_logo.png",
              width: 50,
              height: 50,
            ),
            VerticalDivider(width: 10,),
            Text("Sign in with Google",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)
          ],
        ),
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
