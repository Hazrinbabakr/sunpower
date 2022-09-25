// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:onlineshopping/Widgets/Categories.dart';
import 'package:onlineshopping/Widgets/DeliveryAddress.dart';
import 'package:onlineshopping/Widgets/Offers.dart';
import 'package:onlineshopping/Widgets/SocialMediaWidget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Delivery address widget
            DeliveryAddress(),
            SizedBox(height: 10,),
            // Offers
            //Offers(),
            CategoriesWidget(),
            SizedBox(height: 120,),
            SocialMediaWidget()

          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}



// StreamBuilder<QuerySnapshot>(
// stream: FirebaseFirestore.instance.collection('test').snapshots(),
// builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
// if (snapshot.hasError) {
// print('Errorrrrr ${snapshot.error}');
// return const Text('Something went wrong');
// }
// if (snapshot.connectionState == ConnectionState.waiting) {
// return const CircularProgressIndicator();
// }
//
// return  Container(
// height: 1000,
//
// child: ListView(
// children: snapshot.data!.docs.map((DocumentSnapshot document) {
// Map<String, dynamic> data = document.data()!;
// return ListTile(
// title: Text('ssss ${data['test1'].toString()}'),
// );
// }).toList(),
// ),
// );
// },
// ),