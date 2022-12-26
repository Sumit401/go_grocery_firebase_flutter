import 'package:cabs/homepage/homepage.dart';
import 'package:cabs/main_screens/login_page.dart';
import 'package:cabs/main_screens/register.dart';
import 'package:cabs/reusable_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

//// Registered Button  ////////////

Widget button_for_registration(BuildContext context, String userEmail, String userPassword, String userName, GlobalKey<FormState> formvalidationkey){
  return ElevatedButton(
      onPressed: () {
        formvalidationkey.currentState?.save();
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
          if(error.toString()=="Given String is empty or null")
            long_flutter_toast("All Fields Required");
          print(error.toString());
        });
      },
      child: Text("Register Now"),
      style: const ButtonStyle(
          backgroundColor:
          MaterialStatePropertyAll(Colors.lightGreen)));
}

//// Login Button  ////////////
Widget button_for_login(BuildContext context, String user_email,String user_password){
  return  ElevatedButton(
      onPressed: () {
        FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: user_email,
            password: user_password)
            .then(
              (value) async {
            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
            sharedPreferences.setString("user_email", user_email);

            short_flutter_toast("Login Successful");
            Navigator.pop(context);
            Navigator.pushNamed(context, homepage.route);
          },
        ).onError(
              (error, stackTrace) {
            FocusManager.instance.primaryFocus?.unfocus();
            long_flutter_toast("Invalid Email or Password");
            print(error.toString());
          },
        );
      },
      child: Text("Login"),
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.green),
          textStyle: MaterialStatePropertyAll(TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold))));
}

// Already Registered User............................................

Widget already_registered(BuildContext context){
  return InkWell(
    onTap: () {
      Navigator.pop(context);
      Navigator.pushNamed(context, login_page.route);
    },
    child: Container(
      margin: EdgeInsets.only(top: 20),
      child: const Center(
          child: Text("Already Registered? Click here to Login",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15))),
    ),
  );
}

// Not Registered .........................................

Widget not_a_user_signup(BuildContext context){
  return InkWell(
    onTap: () {
      Navigator.pop(context);
      Navigator.pushNamed(context, register.route);
    },
    child: Container(
      margin: EdgeInsets.only(top: 20),
      child: const Center(
          child: Text("Not a User? Click here Register to Us!",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15))),
    ),
  );
}