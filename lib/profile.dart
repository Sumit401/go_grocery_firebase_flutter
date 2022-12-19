import 'package:cabs/bottom_navbar.dart';
import 'package:cabs/reusable_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';



class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);
  static const route="/profile";

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {

String email="";
String name="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getsharedpref();

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: bottom_navbar(),
      body: Container(
        alignment: Alignment.center,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,children: [
          Text(email),
          Text(name),
           ElevatedButton(
                onPressed: () {
                  google_sign_out();
                  Navigator.pop(context);
                  Navigator.pushNamed(context, login.route);
                },
                child: Text("Logout")),
        ]),
      ),
    );
  }

  void getsharedpref() async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var email1=sharedPreferences.getString("email").toString();
    var name2=sharedPreferences.getString("name").toString();
    setState(() {
      email=email1;
      name=name2;
    });
  }

}
