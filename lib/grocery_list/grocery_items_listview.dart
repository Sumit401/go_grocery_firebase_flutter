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
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottomNavigationBar: bottom_navbar(),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset(
            "assets/images/app_logo.png",
            width: 70,
            height: 70,
          ),),
        elevation: 20,
        titleSpacing: 30,
        title: Theme(
          data: ThemeData.light(),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              dropdownColor: Colors.blueAccent,
              elevation: 10,
              isDense: true,
              style: TextStyle(color: Colors.blueAccent),
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
                      child: Text(e,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: Colors.white)),
                    ),
              ).toList(),
              isExpanded: true,
              icon:
              const Icon(FontAwesomeIcons.anglesDown, color: Colors.white),
              iconSize: 25,
              value: dropdownvalue,
            ),
          ),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 2),
        alignment: Alignment.center,
        child: StreamBuilder(
            stream: fire_storedb,
            builder: ((context, snapshot) {
              if (!snapshot.hasData) return const CircularProgressIndicator();
              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return (grocery_list(snapshot, index, context));
                },
              );
            })),
      ),
    );
  }

  Widget listviewbuilder(
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        return (grocery_list(snapshot, index, context));
      },
    );
  }
}
