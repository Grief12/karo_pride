import 'package:b_social02/pages/Post.dart';
import 'package:b_social02/pages/chat.dart';
import 'package:b_social02/pages/home.dart';
import 'package:b_social02/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final controller = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScren() {
    return [
      HomePage(),
      ChatPage(),
      Create(),
      Profile(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItem() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home, color: Colors.black),
        inactiveIcon: Icon(Icons.home_outlined, color: Colors.black),
        activeColorPrimary: const Color.fromARGB(255, 192, 191, 191),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.message, color: Colors.black),
        inactiveIcon: Icon(Icons.message_outlined, color: Colors.black),
        activeColorPrimary: const Color.fromARGB(255, 192, 191, 191),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.add_circle, color: Colors.black),
        inactiveIcon: Icon(Icons.add_circle_outline, color: Colors.black),
        activeColorPrimary: const Color.fromARGB(255, 192, 191, 191),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person, color: Colors.black),
        inactiveIcon: Icon(Icons.person_outline_rounded, color: Colors.black),
        activeColorPrimary: const Color.fromARGB(255, 192, 191, 191),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _buildScren(),
      items: _navBarItem(),
      controller: controller,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      decoration: NavBarDecoration(
        colorBehindNavBar: Colors.red,
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }
}
