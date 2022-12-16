import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String email = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Login")),
      body: Column(
        children: [
          Container(
            child: Text("Login Page"),
          ),
          SizedBox(
            width: 500,
            child: Padding(
              padding: const EdgeInsets.all(58.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: "Email"),
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Password"),
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  OutlinedButton(
                      onPressed: () {
                        FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: email, password: password)
                            .then((signedInUser){
                          firestore.collection('users')
                              .add({'email' : email, 'password' : password,})
                              .then((value){
                            if (signedInUser!= null){
                              print("Value Pushed Done");
                            }
                          })
                              .catchError((e){
                            print(e);
                          })
                          ;}
                        )
                            .catchError((e){
                          print(e);
                        });

                      },
                      child: Text("Submit"))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
