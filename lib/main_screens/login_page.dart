import 'package:cabs/main_screens/resusable_widget_login_register.dart';
import 'package:cabs/main_screens/social_media_login.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class login_page extends StatefulWidget {
  const login_page({Key? key}) : super(key: key);
  static const route = "/login_page";

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController texteditingcontroller_email =  TextEditingController();
  TextEditingController texteditingcontroller_password = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: Container(
        transformAlignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                stops: [0.05, 0.2, 0.6, 1],
                colors: [
              Colors.deepOrange,
              Colors.orange,
              Colors.blueAccent,
              Colors.blue,
            ])),
        alignment: Alignment.center,
        //color: Colors.red,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
        child: SingleChildScrollView(
          child: SizedBox(
            width: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: const Text("Login",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: const Text("Welcome Back !  Login with your Credentials",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.white)),
                ),
                formfield_for_email("Email", texteditingcontroller_email),
                formfield_for_password("Password", texteditingcontroller_password),
                button_for_login(context,texteditingcontroller_email.text,texteditingcontroller_password.text),
                not_a_user_signup(context),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     google_sign_in_buttons(context),
                      facebook_sign_in_button()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
