// ignore_for_file: file_names, prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlineshopping/Widgets/BackArrowWidget.dart';
import 'package:onlineshopping/Widgets/empty.dart';
import 'package:onlineshopping/localization/AppLocal.dart';
import 'package:onlineshopping/screen/productDetails.dart';

class OrderHistoryScreen extends StatefulWidget {
  OrderHistoryScreen({Key key}) : super(key: key);

  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  List<DocumentSnapshot> orderHistoryList;
  FirebaseAuth _auth;
  User user;
  
  getProducts() {
    int i = 0;
    FirebaseFirestore.instance.collection('users').doc(user.uid).collection('orders')
        .get()
        .then((value) {
      orderHistoryList = new List<DocumentSnapshot>(value.docs.length);
      value.docs.forEach((element) async {
        setState(() {
          orderHistoryList[i] = element;
        });
        i++;
      });
    }).whenComplete(() {
      print(orderHistoryList.length);
    });
  }
  
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth= FirebaseAuth.instance;
    user=_auth.currentUser;
    getProducts();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: Text('Order History'),
            elevation: 0,
        ),
        body:
        (orderHistoryList == null)
            ? EmptyWidget()
            : Padding(
          padding: const EdgeInsets.only(top: 30),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: orderHistoryList.length,
              itemBuilder: (context, i) {
                return (orderHistoryList[i] != null)
                    ? InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductDetails( orderHistoryList[i].id.toString()),
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                        height: 175,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[200],
                                  spreadRadius: 1,
                                  blurRadius: 10)
                            ]),
                        child: Row(
                          children: [
                            Text(orderHistoryList[i]['OrderStatus'])
                          ],
                        )),
                  ),)
                    : EmptyWidget();
              }),
        )
    );
  }
}
