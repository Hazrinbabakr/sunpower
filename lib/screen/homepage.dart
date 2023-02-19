// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sunpower/screen/profile.dart';
import 'Favorites.dart';
import 'auth/normal_user_login/login_main_page.dart';
import 'home.dart';
import 'order_history.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTabIndex=0;

  onTapped(int index) {
    setState(() {

      currentTabIndex=index;
    });
    if(currentTabIndex==3){
    }
  }

  final currentPage = [
    HomeScreen(),
    FirebaseAuth.instance.currentUser != null ?
    FavoriteScreen():MainLoginPage(),
    // CartScreen(),
    FirebaseAuth.instance.currentUser != null ?
    OrderHistoryScreen():MainLoginPage(),
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
          selectedItemColor: Colors.red[900],
          currentIndex: currentTabIndex,
          unselectedItemColor: Colors.black54,
          iconSize: 30,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(""),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              title: Text(''),
              // backgroundColor: Colors.purple[600]
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket),
              title: Text(""),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text(""),
            ),

          ],
        ),
      ),
    );
  }
}
