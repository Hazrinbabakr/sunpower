

// ignore_for_file: file_names, prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sunpower/Widgets/BackArrowWidget.dart';
import 'package:sunpower/Widgets/empty.dart';
import 'package:sunpower/localization/AppLocal.dart';
import 'package:sunpower/screen/order_details.dart';
import 'package:sunpower/screen/productDetails.dart';

class OrderHistoryScreen extends StatefulWidget {
  OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  List<DocumentSnapshot>? orderHistoryList;
  User user = FirebaseAuth.instance.currentUser!;
  getProducts() {
    FirebaseFirestore.instance.collection('users')
        .doc(user.uid)
        .collection('orders')
        .orderBy('date', descending: true)
        .get()
        .then((value) {
          orderHistoryList = [];
          orderHistoryList!.addAll(value.docs);
          setState(() {});
        }).whenComplete(() {
      // print(orderHistoryList.length);
    });
  }
  // getCurrentProducts() {
  //   int i = 0;
  //   FirebaseFirestore.instance.collection('users').doc(user.uid).collection('orders').
  //   orderBy('date', descending: true)
  //   //where("OrderStatus",isEqualTo: "Pending")
  //       .get()
  //       .then((value) {
  //     currentOrderList = new List<DocumentSnapshot>(value.docs.length);
  //     value.docs.forEach((element) async {
  //       setState(() {
  //         currentOrderList[i] = element;
  //         length= currentOrderList.length;
  //       });
  //       i++;
  //     });
  //   }).whenComplete(() {
  //     // print(currentOrderList.length);
  //   });
  // }


  @override
  void initState() {
    super.initState();
    getProducts();
  }


  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 30,
                  width: double.infinity,
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: Theme.of(context).colorScheme.primary,
                    indicatorPadding: EdgeInsets.all(0),
                    labelPadding: EdgeInsets.symmetric(horizontal: 50),
                    onTap: (index){
                      setState(() {
                        selectedIndex = index;
                      });
                      },
                    isScrollable: true,
                    tabs: [
                      Tab(
                          child: Text(
                            AppLocalizations.of(context).trans("currentorder"),
                            style: TextStyle(fontSize: 15),
                          ),
                      ),
                      Tab(
                        child: Text(
                            AppLocalizations.of(context).trans("Previousorder"),
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  color: Colors.grey,
                                  width: 0.5)
                          )
                      ),
                      child: Padding(
                          padding:
                          const EdgeInsets.all(15.0),
                          child: getCurrentPage()
                      )
                  ),
                )
              ]
          )
      ),
    );
  }




  int selectedIndex = 0;
  getCurrentPage(){
    if(selectedIndex == 0){
      if(orderHistoryList?.isEmpty??true){
        return Center(child: CircularProgressIndicator());
      }
      List orders = orderHistoryList!.where((element) => element['OrderStatus'] == "Pending" ).toList();

      return Container(
        color: Colors.white,
        child: ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: orders.length,
            itemBuilder: (context, i) {
              return InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return OrderDetailsPage(order: orders[i],);
                  }));
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[200]!,
                              spreadRadius: 1,
                              blurRadius: 10
                          )
                        ]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context).trans(orders[i]['OrderStatus'].toString()),
                            style: TextStyle(
                                color: Colors.orange,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical:7 ),
                            child: Text(orders[i]['date'],style: TextStyle(fontSize: 12,color: Colors.black),),
                          ),
                          Row(
                            children: [
                              Text(
                                AppLocalizations.of(context).trans("Deliverto"),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                ),
                              ),
                              Expanded(child: Text(orders[i]['userAddress'].toString(),style: TextStyle(color: Colors.black),)),
                            ],
                          ),
                        ],
                      ),
                    )
                ),
              );
            }, separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 16,);
        },),
      );
    }



    else {
      if(orderHistoryList?.isEmpty??true){
        return Center(child: EmptyWidget());
      }
      List orders = orderHistoryList!.where((element) => element['OrderStatus'] == "Accepted" || element['OrderStatus'] == "Rejected").toList();
      return Container(
          color: Colors.white,
          child: ListView.separated(
              itemCount: orders.length,
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return OrderDetailsPage(order: orders[i],);
                    }));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[200]!,
                                spreadRadius: 1,
                                blurRadius: 10
                            )
                          ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context).trans(orders[i]['OrderStatus'].toString()),
                              style: TextStyle(
                                  color: orders[i]['OrderStatus']== "Rejected"?
                                  Colors.red[700]:  Colors.green[700],
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical:7 ),
                              child: Text(orders[i]['date'],style: TextStyle(fontSize: 12,color: Colors.black),),
                            ),
                            Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context).trans("Deliverto"),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black
                                  ),
                                ),
                                Expanded(child: Text(orders[i]['userAddress'].toString(),style: TextStyle(color: Colors.black),)),
                              ],
                            ),
                          ],
                        ),
                      )
                  ),
                );
              },
            separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 16,);
            },),
        );
    }
  }
}




