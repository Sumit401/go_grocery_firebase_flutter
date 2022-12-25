import 'package:cabs/grocery_list/grocery_list.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class grocery_items_listview extends StatefulWidget {

  String categoryType;

  grocery_items_listview({Key? mykey, required this.categoryType})
      : super(key: mykey);

  @override
  State<grocery_items_listview> createState() => _grocery_items_listviewState();
}

class _grocery_items_listviewState extends State<grocery_items_listview> {

// Defining of Variables
  String value = "";
  String dropdownvalue = "";
  var items = ["Fresh Vegetables", "Fresh Fruits", "Dairy Products", "Food-Grains",
    "Cleaning and Household", "Beverages"];
  var fire_storedb = FirebaseFirestore.instance.collection("Fresh Vegetables").snapshots();


  @override
  void initState() {
    dropdownvalue = widget.categoryType;
    value = widget.categoryType;
    fire_storedb = FirebaseFirestore.instance.collection(widget.categoryType).snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar_with_dropdown(),
      body: Container(
        margin: const EdgeInsets.only(top: 2),
        child: stream_builder(), // Stream Builder Function Below defined
      ),
    );
  }


  // Stream Builder

  Widget stream_builder(){
    return StreamBuilder(
        stream: fire_storedb,
        builder: ((context, snapshot) {
          if (!snapshot.hasData) return  Container(alignment: Alignment.center,child: CircularProgressIndicator());
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return (grocery_list(snapshot, index, context));
            },
          );
        }));
  }


  // Appbar With dropdown Menu

  AppBar appbar_with_dropdown() {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Image.asset(
          "assets/images/app_logo.png",
          width: 70,
          height: 70,
        ),
      ),
      elevation: 20,
      titleSpacing: 30,
      title: Theme(
        data: ThemeData.light(),
        child: drop_down_for_appbar(),
      ),
      backgroundColor: Colors.blueAccent,
      centerTitle: true,
    );
  }

  Widget drop_down_for_appbar(){
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        dropdownColor: Colors.blueAccent,
        elevation: 10,
        isDense: true,
        style: const TextStyle(color: Colors.blueAccent),
        onChanged: (value1) {
          setState(() {
            value = value1!;
            dropdownvalue = value1;
            fire_storedb = FirebaseFirestore.instance.collection(dropdownvalue).snapshots();
          });
        },
        items: items.map((e) => DropdownMenuItem(
            alignment: Alignment.center,
            value: e,
            child: Text(e, style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Colors.white)),
          ),
        ).toList(),
        isExpanded: true,
        icon: const Icon(FontAwesomeIcons.anglesDown, color: Colors.white),
        iconSize: 25,
        value: dropdownvalue,
      ),
    );
  }
}
