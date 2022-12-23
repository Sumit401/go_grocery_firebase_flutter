import 'package:cabs/bottom_navbar.dart';
import 'package:cabs/grocery_items_listview.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

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
      appBar: AppBar(title: Text("Homepage"), centerTitle: true),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              child: Carousel(
                animationCurve: Curves.bounceIn,
                animationDuration: Duration(seconds: 7),
                autoplay: true,
                boxFit: BoxFit.fitWidth,
                dotSize: 4.0,
                dotSpacing: 15.0,
                dotColor: Colors.lightGreenAccent,
                indicatorBgPadding: 5.0,
                borderRadius: true,
                images: [
                    NetworkImage("https://media.istockphoto.com/id/1216828053/photo/shopping-basket-with-fresh-food-grocery-supermarket-food-and-eats-online-buying-and-delivery.jpg?s=612x612&w=0&k=20&c=Chd527v9-ho7a-S5k24kcWWfB92Pj3Vh2eM0erk74AU="),
                    NetworkImage("https://www.shutterstock.com/image-photo/healthy-food-background-vegan-vegetarian-260nw-1610617150.jpg"),
                    NetworkImage("https://media.istockphoto.com/id/1328991116/photo/fresh-vegetables-and-fruits-on-counter-in-grocery-supermarket.jpg?b=1&s=170667a&w=0&k=20&c=yPu0rw6pU8oD4c3YR91bzKQx2GxyZxBQFpzMwVwR_g4="),
                    NetworkImage("https://img.freepik.com/free-vector/shopping-supermarket-cart-with-grocery-pictogram_1284-11697.jpg?size=338&ext=jpg"),
                    NetworkImage("https://img.freepik.com/free-vector/interior-supermarket-store-with-people-character-cashier-buyer_80328-122.jpg?size=626&ext=jpg")
                  ],
              ),
            ),
            ElevatedButton(
              child: Text("All Items"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return grocery_items_listview();
                  },
                ));
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottom_navbar(),
    );
  }
}
