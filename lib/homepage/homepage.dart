import 'package:cabs/bottom_navbar/bottom_navbar.dart';
import 'package:cabs/reusable_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);
  static const route = "/homepage";

  @override
  State<homepage> createState() => _homepageState();
}
var fire_storedb = FirebaseFirestore.instance.collection("carousel").snapshots();

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar_display("Go Grocery"),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
                height: 250,
                child: StreamBuilder(
                  stream: fire_storedb,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return Container();
                    return CarouselSlider.builder(
                        itemCount: snapshot.data?.size,
                        itemBuilder: (context, index, realIndex) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(snapshot.data!.docs[index]['images']
                                .toString()),
                          );
                        },
                        options: CarouselOptions(
                          height: 300,
                          autoPlay: true,
                          pauseAutoPlayOnTouch: true,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: true,
                          initialPage: 0,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayCurve: Curves.fastOutSlowIn,
                        ));
                  },
                )),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    height: 40,
                      color: Colors.lightBlueAccent,
                      child: Text(
                        "Shop by Category",
                        style: TextStyle(fontSize: 22, color: Colors.black,fontWeight: FontWeight.bold,letterSpacing: 3),
                      )),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          homepage_category(context,"Fresh Fruits"),
                          homepage_category(context,"Fresh Vegetables"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          homepage_category(context,"Food-Grains"),
                          homepage_category(context,"Cleaning and Household"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          homepage_category(context,"Dairy Products"),
                          homepage_category(context,"Beverages"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottom_navbar(),
    );
  }
}
