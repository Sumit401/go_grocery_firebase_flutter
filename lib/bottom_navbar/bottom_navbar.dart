import 'package:cabs/cart/your_cart.dart';
import 'package:cabs/homepage/homepage.dart';
import 'package:cabs/profile/profile_main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../reusable_widgets.dart';

class bottom_navbar extends StatefulWidget {
  const bottom_navbar({Key? key}) : super(key: key);

  @override
  State<bottom_navbar> createState() => _bottom_navbarState();
}
var current_index_bottom_navbar=0;

class _bottom_navbarState extends State<bottom_navbar> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (BottomNavigationBar(
      elevation: 20,
      backgroundColor: Colors.blueAccent,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.white,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house), label: "Home"),
        BottomNavigationBarItem(
          label: "Cart",
          icon: Icon(FontAwesomeIcons.cartShopping),),
         BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.userTie), label: "Profile"),
      ],
      currentIndex: current_index_bottom_navbar,
      onTap: on_item_tapped,

        )

    );
  }
  void on_item_tapped(int index) {
    setState(() {

      if(index==0 && current_index_bottom_navbar!=0){
        getcart_item_pricecount();
        Navigator.pop(context);
        Navigator.pushNamed(context, homepage.route);

      }else if(index==1 && current_index_bottom_navbar!=1){
        getcart_item_pricecount();
        Navigator.pop(context);
        Navigator.pushNamed(context, your_cart.route);

      }else if(index==2 && current_index_bottom_navbar!=2){
        getcart_item_pricecount();
        Navigator.pop(context);
        Navigator.pushNamed(context, profile_main.route);
      }
      current_index_bottom_navbar=index;
    });
  }

}
