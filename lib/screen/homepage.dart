// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sunpower/screen/cart_screen.dart';
import 'package:sunpower/screen/profile.dart';
import 'package:sunpower/screen/search_by_barcode.dart';
import 'Favorites.dart';
import 'auth/normal_user_login/login_main_page.dart';
import 'category_list_screen.dart';
import 'home.dart';
import 'order_history.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTabIndex=0;

  onTapped(int index) {

    // if(index == 2){
    //   SearchByBarcode.openCamera(context);
    //   return;
    // }
    setState(() {
      currentTabIndex=index;
    });
  }

  final currentPage = [
    HomeScreen(),
    FirebaseAuth.instance.currentUser != null ?
    CategoryListScreen():MainLoginPage(),
    // CartScreen(),
    FirebaseAuth.instance.currentUser != null ?
    CartScreen():MainLoginPage(),
    //OrderHistoryScreen():MainLoginPage(),
    FirebaseAuth.instance.currentUser != null ?
    ProfileScreen():MainLoginPage(),
  ];
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: currentPage[currentTabIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTapped,
          selectedItemColor: Theme.of(context).primaryColor,
          currentIndex: currentTabIndex,
          unselectedItemColor: Colors.black54,
          iconSize: 30,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.apps),
              label: "",
              // backgroundColor: Colors.purple[600]
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "",
            ),
          ],
        ),
      ),
    );
  }
}
