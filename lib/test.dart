// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:onlineshopping/screen/pages.dart';
import 'package:onlineshopping/shop/signup.dart';


class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
SizedBox(height: 220,),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Pages(),
                  ));
                },
                child: Text('Userr',style: TextStyle(fontSize: 90),)),
            SizedBox(height: 50,),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SignUpScreen(),
                  ));
                },
                child: Text('Shop',style: TextStyle(fontSize: 90),)),
            SizedBox(height: 50,),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SignUpScreen(),
                  ));
                },
                child: Text('Admin',style: TextStyle(fontSize: 90),)),
          ],
        ),
      ),
    );
  }
}
