// ignore_for_file: use_key_in_widget_constructors, file_names, prefer_const_constructors, avoid_unnecessary_containers, deprecated_member_use, avoid_print, unnecessary_null_comparison, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'addProduct.dart';

class ShopHome extends StatefulWidget {
   String shopEmail;
   ShopHome({Key key,  this.shopEmail}) : super(key: key);
  @override
  _ShopHomeState createState() => _ShopHomeState();
}

class _ShopHomeState extends State<ShopHome> {
   User user;
  @override
  Widget build(BuildContext context) {
    return
StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('shops').where("shopEmail",isEqualTo: widget.shopEmail).snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasError) {
    print('Errorrrrr ${snapshot.error}');
    return const Text('Something went wrong');
    }
    if (snapshot.connectionState == ConnectionState.waiting) {
    return const CircularProgressIndicator();
    }
    return  Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data();
                    return Text('Shop Name: ${data['shopName'].toString()}');
                  }).toList(),
                ),
              ),

              InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          AddProduct(),
                    ));
                  },
                  child: Text('Add Product'))
            ],
          ),
        ),
      ),
    );
    },
    );

  }
}
