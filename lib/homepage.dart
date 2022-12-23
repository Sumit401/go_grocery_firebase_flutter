import 'package:cabs/bottom_navbar.dart';
import 'package:cabs/grocery_items_listview.dart';
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
      appBar: AppBar(title: Text("Homepage"),centerTitle: true),
      body: Container(child: ElevatedButton(child: Text("All Items"),onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
         return grocery_items_listview();
        },));
      },),),
      bottomNavigationBar: bottom_navbar(),
    );
  }
}
