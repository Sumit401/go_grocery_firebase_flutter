import 'package:cabs/homepage.dart';
import 'package:cabs/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);
  static const route = "/Contactus";

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String name ="";
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    var screen_size = MediaQuery.of(context).size;
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      //appBar: AppBar(title: Text("Register")),
      body: SingleChildScrollView(
        child: Container(
          transformAlignment: Alignment.center,
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          width: screen_size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.1, 1],
                  colors: [Colors.redAccent, Colors.indigoAccent])),
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 00),
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
              SizedBox(
                width: 500,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      padding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: "Name", border: InputBorder.none),
                        onChanged: (value) {
                          name = value;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                          onPressed: () {
                            FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: email, password: password)
                                .then((value) {
                              print("Registration Successful");
                            }).onError((error, stackTrace) {
                              print(error.toString());
                            });
                          },
                          child: Text("Register Now"),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.lightGreen))),
                    )
                  ],
                ),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
