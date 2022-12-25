import 'package:cabs/cart/checkout.dart';
import 'package:cabs/grocery_list/grocery_items_listview.dart';
import 'package:cabs/homepage/homepage.dart';
import 'package:cabs/main_screens/login_page.dart';
import 'package:cabs/profile/profile_main.dart';
import 'package:cabs/main_screens/register.dart';
import 'package:cabs/cart/cart_navigation.dart';
import 'package:cabs/main_screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  email = sharedPreferences.getString("user_email").toString();
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

var email="";
class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Go Grocery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        register.route: (_) => register(),
        login_page.route:(_)=> login_page(),
        homepage.route:(_)=>homepage(),
        //grocery_items_listview.route:(_)=>grocery_items_listview(),
        profile_main.route:(_)=>profile_main(),
        cart_item.route:(_)=>cart_item(),
        checkout.route:(_)=>checkout(),
      },
        home: AnimatedSplashScreen(
          nextScreen: email == "null" ? splash_screen() : homepage(),
          splashIconSize: 200,
          centered: true,
          splash: Container(child: Column(
            children: [
              Image.asset("assets/images/app_logo.png",height: 100,width: 100),
              Container(margin: EdgeInsets.symmetric(vertical: 10),child: Text("Go Grocery",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white),))
            ],
          )),
          backgroundColor: Colors.blueAccent,
          splashTransition: SplashTransition.fadeTransition,
        ));
  }


}
