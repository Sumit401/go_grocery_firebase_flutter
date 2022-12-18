import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget list_of_vehicles(
    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot, int index) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    child: Card(
      shape: const RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(50))),
      elevation: 20,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Text(snapshot.data!.docs[index]['Name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                    )),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 180,
                        width: 200,
                        decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(20)),
                        child: Image.network(snapshot.data!.docs[index]['image'].toString(),
                          width: 200,
                          fit: BoxFit.fitWidth,
                          height: 200,
                          colorBlendMode: BlendMode.color,
                        )),
                    /*Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          FontAwesomeIcons.gasPump,
                          size: 15,
                          color: Colors.blue,
                        ),
                        Icon(FontAwesomeIcons.couch,
                            size: 15, shadows: [Shadow(color: Colors.blue)]),
                      ],
                    ),*/
                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text((snapshot.data!.docs[index]['Fuel Type']),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    )),
                                const Text(" Vehicle",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                    (snapshot.data!.docs[index]
                                        ['Seating Capacity']),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    )),
                                const Text(" Seater",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                    (snapshot.data!.docs[index]
                                    ['Airbags']),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    )),
                                const Text(" Airbags",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20,bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("INR ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                    Text(
                        (snapshot.data!.docs[index]
                        ['price']),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        )),
                    Text(" Per Day ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}