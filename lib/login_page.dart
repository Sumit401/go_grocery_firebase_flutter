import 'package:cabs/homepage.dart';
import 'package:cabs/register.dart';
import 'package:cabs/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      //resizeToAvoidBottomInset: false,
      //appBar: AppBar(title: Text("Login Page")),
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
                ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: texteditingcontroller_email.text,
                              password: texteditingcontroller_password.text)
                          .then(
                        (value) async {
                          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                          sharedPreferences.setString("user_email", texteditingcontroller_email.text.toString());

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
                            fontSize: 20, fontWeight: FontWeight.bold)))),
                InkWell(
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
                ),
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
