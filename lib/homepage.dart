import 'package:cabs/login.dart';
import 'package:cabs/bottom_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);
  static const route = "/homepage";

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: bottom_navbar(),
      body: Container(
        child: ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pop(context);
              Navigator.pushNamed(context, login.route);
            },
            child: Text("Logout")),
      ),
    );
  }
}
