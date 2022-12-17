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
  Widget build(BuildContext context) {
    return (BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.clipboardCheck), label: "Activity"),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.userTie), label: "Profile"),
      ],
      currentIndex: current_index_bottom_navbar,
      onTap: on_item_tapped,

    ));
  }
  void on_item_tapped(int index){
    setState(() {
      current_index_bottom_navbar=index;
    });
  }
}
