import 'package:cabs/homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);


  @override
  State<login> createState() => _loginState();
}


class _loginState extends State<login> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String email = "";
  String password = "";


  @override
  Widget build(BuildContext context) {
    return (Scaffold());
  }
}
