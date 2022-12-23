import 'package:cabs/checkout.dart';
import 'package:cabs/grocery_items_listview.dart';
import 'package:cabs/homepage.dart';
import 'package:cabs/login_page.dart';
import 'package:cabs/profile_navigation.dart';
import 'package:cabs/register.dart';
import 'package:cabs/cart_navigation.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  email = sharedPreferences.getString("email").toString();
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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      routes: {
        register.route: (_) => register(),
        login.route:(_)=> login(),
        homepage.route:(_)=>homepage(),
        grocery_items_listview.route:(_)=>grocery_items_listview(),
        profile.route:(_)=>profile(),
        cart_item.route:(_)=>cart_item(),
        checkout.route:(_)=>checkout(),
      },
        home: AnimatedSplashScreen(
          nextScreen: email == "null" ? login() : homepage(),
          splashIconSize: 150,
          splash: Image.asset("assets/images/app_logo.png"),
          backgroundColor: Colors.amberAccent,
          splashTransition: SplashTransition.fadeTransition,
        ));
  }


}
