import 'package:cabs/bottom_navbar.dart';
import 'package:cabs/grocery_list.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);
  static const route = "/homepage";

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {

  String value="vegetables";
  var items = ["vegetables", "fruits", "Dairy", "Cereals", "Household"];
  String? dropdownvalue = "vegetables";
  var fire_storedb = FirebaseFirestore.instance.collection("vegetables").snapshots();
  //var fire_storedb2= FirebaseFirestore.instance.collection("Cart").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const bottom_navbar(),
      appBar: AppBar(
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
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              onChanged: (value1) {
                setState(() {
                  value=value1!;
                  dropdownvalue=value1;
                  fire_storedb=FirebaseFirestore.instance.collection(value).snapshots();
                });
              },
              items: items
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e,
                          style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20)),
                    ),
                  )
                  .toList(),
              isExpanded: true,
              icon:
                  const Icon(FontAwesomeIcons.anglesDown, color: Colors.black),
              iconSize: 25,
              value: dropdownvalue,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 2),
        alignment: Alignment.center,
        child: StreamBuilder(
            stream: fire_storedb,
            builder: ((context, snapshot) {
              if (!snapshot.hasData) return const CircularProgressIndicator();
              return (ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return (grocery_list(snapshot, index, context));
                },
              ));
            })),
      ),
    );
  }
}
