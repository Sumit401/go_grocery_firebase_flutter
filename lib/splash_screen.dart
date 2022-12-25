import 'package:cabs/login_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({Key? key}) : super(key: key);

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/grocery_delivery.jpg"),
                  fit: BoxFit.fitWidth),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Icon(FontAwesomeIcons.carrot,
                      color: Colors.orange, size: 70),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Welcome to our Store",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => login_page(),));
                      },
                      style: ButtonStyle(
                          padding: const MaterialStatePropertyAll(
                              EdgeInsets.symmetric(horizontal: 20)),
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.blueAccent),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)))),
                      child: const Text("Get Started",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700))),
                )
              ],
            )));
  }
}
