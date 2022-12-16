import 'package:cabs/homepage.dart';
import 'package:cabs/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);
  static const route = "/login";

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      //resizeToAvoidBottomInset: false,
      //appBar: AppBar(title: Text("Login Page")),
      body: SingleChildScrollView(
        child: Container(
          transformAlignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0.05,0.2,0.6,1],
                  colors: [
                    Colors.deepOrange,
                    Colors.orange,
                    Colors.blue,
                    Colors.blueGrey,
                  ])),
          alignment: Alignment.bottomCenter,
          //color: Colors.red,
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 00),
          child: SizedBox(
            width: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Text("Welcome Back! ",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Email", border: InputBorder.none),
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Password", border: InputBorder.none),
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                          email: email, password: password)
                          .then(
                            (value) {
                          print("Login Successful");
                          Navigator.pop(context);
                          Navigator.pushNamed(context, homepage.route).onError(
                                  (error, stackTrace) => print(error.toString()));
                        },
                      );
                    },
                    child: Text("Login"),
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.green),
                        textStyle: MaterialStatePropertyAll(
                            TextStyle(fontSize: 20, fontWeight:FontWeight.bold)))),
                InkWell(
                  onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, register.route);
                    },
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Center(
                          child: Text("Not a User? Click here Register to Us!",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15))),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
