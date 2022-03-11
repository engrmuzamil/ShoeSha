import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sellshoes/FavPage.dart';
import 'package:sellshoes/cartpage.dart';
import 'package:sellshoes/homepage.dart';
import 'package:sellshoes/login.dart';
import 'package:sellshoes/searchpage.dart';

class MyNavBar extends StatefulWidget {
  const MyNavBar({Key? key}) : super(key: key);

  @override
  State<MyNavBar> createState() => _MyNavBarState();
}

class _MyNavBarState extends State<MyNavBar> {
  static int _selectedIndex = 0;
  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        print("Home Page");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HoemPage()),
            (route) => false);
      } else if (index == 1) {
        print("Search PAge");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SearchPage()),
            (route) => false);
      } else if (index == 2) {
        print("Fav Page");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => FavPage()),
            (route) => false);
      } else if (index == 3) {
        print("Fav Page");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => CartPage()),
            (route) => false);
      } else if (index == 4) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => Login()), (route) => false);
        FirebaseAuth.instance.signOut();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: Colors.yellow,
          ),
          label: 'Home',
          backgroundColor: Colors.black,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            color: Colors.yellow,
          ),
          label: 'Search',
          backgroundColor: Colors.black,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite,
            color: Colors.yellow,
          ),
          label: 'Fav',
          backgroundColor: Colors.black,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.shopping_cart,
            color: Colors.yellow,
          ),
          label: 'Cart',
          backgroundColor: Colors.black,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.logout,
            color: Colors.yellow,
          ),
          label: 'Logout',
          backgroundColor: Colors.black,
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.yellow,
      onTap: onItemTapped,
    );
  }
}
