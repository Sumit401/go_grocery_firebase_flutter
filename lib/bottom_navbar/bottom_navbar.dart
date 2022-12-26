import 'package:cabs/cart/your_cart.dart';
import 'package:cabs/homepage/homepage.dart';
import 'package:cabs/profile/profile_main.dart';
import 'package:cabs/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class bottom_navbar extends StatefulWidget {
  const bottom_navbar({Key? key}) : super(key: key);

  @override
  State<bottom_navbar> createState() => _bottom_navbarState();
}
var current_index_bottom_navbar=0;
int cart_value = 0;

class _bottom_navbarState extends State<bottom_navbar> {


  @override
  void initState() {
    getsharedpref();
    getcart_item_pricecount();
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
      items: [
        const BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house), label: "Home"),
        BottomNavigationBarItem(
          label: "Cart",
          icon: Stack(
            children: <Widget>[
              new Icon(FontAwesomeIcons.cartShopping),
              Positioned(
                right: 0,
                left: 4,
                child: Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  constraints: const BoxConstraints(minWidth: 12, minHeight: 12,),
                  child: Text(
                    '$cart_value',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),),
        const BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.userTie), label: "Profile"),
      ],
      currentIndex: current_index_bottom_navbar,
      onTap: on_item_tapped,

    ));
  }
  Future<void> on_item_tapped(int index)  async {
    SharedPreferences preferences= await SharedPreferences.getInstance();
    int? value=preferences.getInt("cart_value");
    getcart_item_pricecount();
    setState(() {
      cart_value=value!;
      if(index==0 && current_index_bottom_navbar!=0){
        Navigator.pop(context);
        Navigator.pushNamed(context, homepage.route);

      }else if(index==1 && current_index_bottom_navbar!=1){
        getcart_item_pricecount();
        Navigator.pop(context);
        Navigator.pushNamed(context, your_cart.route);

      }else if(index==2 && current_index_bottom_navbar!=2){
        Navigator.pop(context);
        Navigator.pushNamed(context, profile_main.route);
      }
      current_index_bottom_navbar=index;
    });
  }

  Future<void> getsharedpref() async {
    SharedPreferences preferences= await SharedPreferences.getInstance();
    int? value=preferences.getInt("cart_value");
    cart_value=value!;
  }
}
