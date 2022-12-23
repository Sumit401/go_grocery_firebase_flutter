import 'package:cabs/bottom_navbar.dart';
import 'package:cabs/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);
  static const route = "/profile";

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  String user_email = "";
  String user_name = "";
  String user_image = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getsharedpref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 20,
        actions: [
          IconButton(
            onPressed: () {
              google_sign_out();
              Navigator.pop(context);
              Navigator.pushNamed(context, login.route);
            },
            icon: Icon(FontAwesomeIcons.rightFromBracket),
            color: Colors.black,
          )
        ],
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset(
            "assets/images/app_logo.png",
            width: 70,
            height: 70,
          ),
        ),
        title: Text("Hi, $user_name", style: TextStyle(color: Colors.blue)),
      ),
      bottomNavigationBar: bottom_navbar(),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        alignment: Alignment.topCenter,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25)),
            child: FadeInImage.assetNetwork(
              placeholderErrorBuilder: (context, error, stackTrace) {
                return(Image.asset('assets/images/user_img.png',height: 100,width: 100,));
              },
              placeholder: 'assets/images/user_img.png',
              image: user_image.toString(),
              imageErrorBuilder: (context, error, stackTrace) {
                return(Image.asset('assets/images/user_img.png',height: 100,width: 100,));
              },
              height: 100,
              width: 100,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
              child: Text(user_email)),
          Column(children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(10),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.lightBlueAccent),),
                  child: Text("My Account",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,),),
                  onPressed: () {},),),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(10),
                  backgroundColor:
                  MaterialStateProperty.all(Colors.lightBlueAccent),),
                child: Text("My Orders",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,),),
                onPressed: () {},),),

          ],)

        ]),
      ),
    );
  }

  void getsharedpref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var email = sharedPreferences.getString("email").toString();
    var name = sharedPreferences.getString("name").toString();
    var image = sharedPreferences.getString("user_image").toString();
    setState(() {
      user_email = email;
      user_name = name;
      user_image = image;
    });
  }
}
