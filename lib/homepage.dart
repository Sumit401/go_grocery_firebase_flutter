import 'package:cabs/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);
  static const route = "/homepage";

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  var fire_storedb= FirebaseFirestore.instance.collection("cars").snapshots();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: bottom_navbar(),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        alignment: Alignment.center,
        child: StreamBuilder(stream: fire_storedb,builder: ((context, snapshot) {
          if(!snapshot.hasData) return CircularProgressIndicator();
          return(
          ListView.builder(itemCount: snapshot.data!.docs.length,itemBuilder: (context, index) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Name of the vehicle"),
                    Text(snapshot.data!.docs[index]['Name']),
                  ],
                ),
                Text(snapshot.data!.docs[index]['Fuel Type']),
                Text(snapshot.data!.docs[index]['Mileage']),
                Text(snapshot.data!.docs[index]['Safety']),
                Text(snapshot.data!.docs[index]['Seating Capacity']),
                Image.network(snapshot.data!.docs[index]['image'].toString(),width: 300,height: 300,)
              ],
            );
          },)
          );
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
