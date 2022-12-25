import 'package:cabs/bottom_navbar/bottom_navbar.dart';
import 'package:cabs/profile/profile_navigation.dart';
import 'package:cabs/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class profile_main extends StatefulWidget {
  const profile_main({Key? key}) : super(key: key);
  static const route = "/profile";

  @override
  State<profile_main> createState() => _profile_mainState();
}

class _profile_mainState extends State<profile_main> {
  String user_email = "";
  String user_name = "";
  String user_image = "";

  @override
  void initState() {
    super.initState();
    getsharedpref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar_display("My Profile"),
      bottomNavigationBar: bottom_navbar(),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        alignment: Alignment.topCenter,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          userimage_display(user_image.toString()),
          Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(user_name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700))),
          Container(margin: EdgeInsets.only(top: 10), child: Text(user_email)),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                profile_navigations(context,"My Account"),
                profile_navigations(context, "My Orders"),
                profile_navigations(context, "About Us"),
                profile_navigations(context, "Contact Us"),
                profile_navigations(context, "Logout"),
              ],
            ),
          )
        ]),
      ),
    );
  }

  void getsharedpref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var email = sharedPreferences.getString("user_email").toString();
    var name = sharedPreferences.getString("user_name").toString();
    var image = sharedPreferences.getString("user_image").toString();
    setState(() {
      user_email = email;
      user_name = name;
      user_image = image;
    });
  }
}
