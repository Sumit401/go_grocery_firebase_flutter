import 'package:cabs/main_screens/login_page.dart';
import 'package:cabs/profile/dialog_box.dart';
import 'package:cabs/reusable_widgets.dart';
import 'package:flutter/material.dart';


Widget profile_navigations(BuildContext context, String tab){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    width: MediaQuery.of(context).size.width,
    child: ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(10),
        backgroundColor:
        MaterialStateProperty.all(Colors.lightBlueAccent),
      ),
      child: Text(tab,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      onPressed: () {
        if(tab=="About Us") {
          dialogbox_aboutus(context);
        } else if(tab=="Contact Us") {
          dialogbox_contactus(context);
        } else if(tab=="Logout") {
          google_sign_out();
          Navigator.pop(context);
          Navigator.pushNamed(context, login_page.route);
        }
      },
    ),
  );
}


