import 'package:cabs/cart_navigation.dart';
import 'package:cabs/grocery_items_listview.dart';
import 'package:cabs/profile_navigation.dart';
import 'package:cabs/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class bottom_navbar extends StatefulWidget {
  const bottom_navbar({Key? key}) : super(key: key);

  @override
  State<bottom_navbar> createState() => _bottom_navbarState();
}
var current_index_bottom_navbar=0;

class _bottom_navbarState extends State<bottom_navbar> {
  @override

  @override
  Widget build(BuildContext context) {
    return (BottomNavigationBar(
      elevation: 20,
      backgroundColor: Colors.blueAccent,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.cartShopping), label: "Cart"),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.userTie), label: "Profile"),
      ],
      currentIndex: current_index_bottom_navbar,
      onTap: on_item_tapped,

    ));
  }
  void on_item_tapped(int index){
    setState(() {
      if(index==0&& current_index_bottom_navbar!=0){
        Navigator.pop(context);
        Navigator.pushNamed(context, grocery_items_listview.route);
      }else if(index==1 && current_index_bottom_navbar!=1){
        getcart_item_pricecount();
        Navigator.pop(context);
        Navigator.pushNamed(context, cart_item.route);

      }else if(index==2 && current_index_bottom_navbar!=2){
        Navigator.pop(context);
        Navigator.pushNamed(context, profile.route);
      }
      current_index_bottom_navbar=index;
    });
  }
}
