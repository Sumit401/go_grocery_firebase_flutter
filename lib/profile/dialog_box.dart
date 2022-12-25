
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Future dialogbox_aboutus(BuildContext context){
  return (showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(20))),
          title: const Text("About Us",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          content: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Spare more with 'Go Grocery!' We give you the most minimal costs on the entirety of your grocery needs.‘Go Grocery’ is a low-cost online general store that gets items crosswise over classifications like grocery, natural products and vegetables, excellence and health, family unit care, infant care, pet consideration, and meats and fish conveyed to your doorstep.Browse more than 5,000 items at costs lower than markets each day!Calendar conveyance according to your benefit.",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 15),
            ),
          ),
          elevation: 20,
          icon: Image.asset(
            "assets/images/app_logo.png",
            height: 100,
            width: 100,
          ),
          iconPadding:
          EdgeInsets.symmetric(vertical: 20),
        );
      }));
}



Future dialogbox_contactus(BuildContext context) {
  return (showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(20))),
          title: Container(
            alignment: Alignment.center,
            child: Column(
              children: const [
                Text("Contact Us",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Any Question or Remarks ? Just Write to us.",
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200)),
                ),
              ],
            ),
          ),
          content: Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                width: 300,
                height: 500,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          decoration: const InputDecoration(prefixIcon: Icon(FontAwesomeIcons.circleUser,
                              color: Colors.black),labelText: "Name",
                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          decoration: const InputDecoration(prefixIcon: Icon(FontAwesomeIcons.at,
                              color: Colors.black), labelText: "Email",
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: const InputDecoration(prefixIcon: Icon(FontAwesomeIcons.comment,
                            color: Colors.black), labelText: "Message",
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)))),
                        minLines: 3, maxLines: 3,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: ElevatedButton(onPressed: () {
                      }, child: Text("Submit")),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: const Text("Contact Us Directly",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Icon(FontAwesomeIcons.phone, color: Colors.lightBlueAccent),
                        Icon(FontAwesomeIcons.whatsapp, color: Colors.green),
                        Icon(FontAwesomeIcons.envelope, color: Colors.deepOrange),
                      ],
                    )
                  ],
                ),
              )
          ),
          elevation: 20,
          iconPadding:
          EdgeInsets.symmetric(vertical: 20),
        );
      }));
}

