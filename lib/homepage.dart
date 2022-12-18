import 'package:cabs/bottom_navbar.dart';
import 'package:cabs/vehicles_list.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);
  static const route = "/homepage";

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  var fire_storedb = FirebaseFirestore.instance.collection("cars").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottom_navbar(),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        alignment: Alignment.center,
        child: StreamBuilder(
            stream: fire_storedb,
            builder: ((context, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              return (ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return (list_of_vehicles(snapshot,index));
                },
              ));
            })),
        /* ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                  Navigator.pushNamed(context, login.route);
                },
                child: Text("Logout")),*/
      ),
    );
  }
}
