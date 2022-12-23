import 'package:cabs/login_page.dart';
import 'package:cabs/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);
  static const route = "/Contactus";

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  GlobalKey<FormState> formvalidationkey = GlobalKey<FormState>();
  TextEditingController texteditingcontroller_email = TextEditingController();
  TextEditingController texteditingcontroller_password = TextEditingController();
  TextEditingController texteditingcontroller_name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screen_size = MediaQuery.of(context).size;
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      //appBar: AppBar(title: Text("Register")),
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        width: screen_size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.1, 1],
                colors: [Colors.redAccent, Colors.indigoAccent])),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
        child: SingleChildScrollView(
          child: SizedBox(
            width: 500,
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: formvalidationkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: const Text("Register to Us",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),

                  /// Form Filed for name//////////////////////////////////////////
                  formfield_for_name("Name", texteditingcontroller_name),

                  /// Form Field for Email////////////////////////////////////////
                  formfield_for_email("Email", texteditingcontroller_email),

                  /// form Field for Password/////////////////////////////////////
                  formfield_for_password(
                      "Password", texteditingcontroller_password),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: button_for_registration(context,texteditingcontroller_email.text,texteditingcontroller_name.text,texteditingcontroller_name.text),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, login.route);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Center(
                          child: Text("Already Registered? Click here to Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15))),
                    ),
                  ),
                  // Container For Facebook and Google SignIn buttons.......................///
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
      ),
    );
  }
}
