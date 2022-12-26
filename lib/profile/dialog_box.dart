import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';


Future dialogbox_aboutus(BuildContext context){
  return (showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.center,
          scrollable: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(20))),
          title: const Text("About Us",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          content:  Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            child: const Text(
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



TextEditingController name_controller =TextEditingController();
TextEditingController body_controller =TextEditingController();

Future dialogbox_contactus(BuildContext context) {
  return (showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: EdgeInsets.all(20),
          contentPadding: EdgeInsets.all(20),
          scrollable: true,
          alignment: Alignment.center,
          elevation: 20,
          iconPadding:
          EdgeInsets.symmetric(vertical: 20),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(20))),
          title: Container(
            alignment: Alignment.center,
            child: Column(
              children: const [
                Text("Contact Us",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
                Text("Any Question or Remarks ? Just Write to us.",textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200,overflow: TextOverflow.clip,)),
              ],
            ),
          ),
          content: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: name_controller,
                      decoration: const InputDecoration(prefixIcon: Icon(FontAwesomeIcons.circleUser,
                          color: Colors.black),labelText: "Name",
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: body_controller,
                    decoration: const InputDecoration(prefixIcon: Icon(FontAwesomeIcons.comment,
                        color: Colors.black), labelText: "Message",
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)))),
                    minLines: 3, maxLines: 3,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: ElevatedButton(onPressed: () async {


                    final Email email = Email(
                      body: body_controller.text,
                      subject: "Query from ${name_controller.text}",
                      recipients: ["sumitsinha401@gmail.com"],
                      isHTML: false
                    );

                    await FlutterEmailSender.send(email);

                  }, child: Text("Submit")),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: const Text("Contact Us Directly",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                          child: const Icon(
                            FontAwesomeIcons.phone,
                            color: Colors.lightBlueAccent,
                            size: 30,
                          ),
                          onTap: () async {
                            String call_to = "tel:8210794699";
                            await launchUrlString(call_to,
                                mode: LaunchMode.externalApplication);
                          }),
                      InkWell(
                          child: const Icon(FontAwesomeIcons.whatsapp,
                              color: Colors.green, size: 30),
                          onTap: () async {
                            String whatsapp = "https://wa.me/918210794699";
                            await launchUrlString(whatsapp,
                                mode: LaunchMode.externalApplication);
                            //LaunchMode.externalApplication;
                          }),
                      InkWell(child: const Icon(
                            FontAwesomeIcons.telegram,
                            color: Colors.blue,
                            size: 35,
                          ),
                          onTap: () async {
                            String telegram_url =
                                "https://telegram.me/Sumit401";
                            await launchUrlString(telegram_url,
                                mode: LaunchMode.externalApplication);
                          }),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }));
}

