

// ignore_for_file: file_names, prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  // List<DocumentSnapshot> currentOrderList;
  FirebaseAuth _auth;
  User user;

  getProducts() {
    int i = 0;
    FirebaseFirestore.instance.collection('users').doc(user.uid).collection('orders').
    orderBy('date', descending: true)
  //  where("OrderStatus",isNotEqualTo: "Pending")
        .get()
        .then((value) {
      orderHistoryList = new List<DocumentSnapshot>(value.docs.length);
      value.docs.forEach((element) async {
        setState(() {
          orderHistoryList[i] = element;
          length= orderHistoryList.length;
        });
        i++;
      });
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
  int length=0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth= FirebaseAuth.instance;
    user=_auth.currentUser;
    getProducts();
    //getCurrentProducts();
  }


  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2, // length of tabs
      initialIndex: 0,
      child: Scaffold(

          backgroundColor: Colors.white,

          body:
          SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                 SizedBox(   height:  MediaQuery.of(context).size.height - 750,),
                  Container(
            // color: Colors.red,
            height: 30,
              width: double.infinity,
              // padding: const EdgeInsets.symmetric(
              //   horizontal: 20,
              //   vertical: 5,
              // ),
              child: TabBar(
                // labelColor:  Colors.white,
                // unselectedLabelColor: Colors.grey[700],
                // indicatorSize: TabBarIndicatorSize.tab,
                // indicator: BoxDecoration(
                //   borderRadius: BorderRadius.circular(50),
                //  // color: Theme.of(context).accentColor,
                // ),
                // indicatorPadding: EdgeInsets.all(90),
indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: Theme.of(context).accentColor,
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
                  Container(
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  color: Colors.grey,
                                  width: 0.5))),
                      child: Padding(
                          padding:
                          const EdgeInsets.all(15.0),
                          child: getCurrentPage()
                      ))
                ]),
          )
      ),
    );
  }




  int selectedIndex = 0;
  getCurrentPage(){
    if(selectedIndex == 0){
      return
        (length==0)
            ? Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Center(child: EmptyWidget()),
            )
            : Container(
              color: Colors.white,
              height:  MediaQuery.of(context).size.height - 200,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: orderHistoryList.length,
                  itemBuilder: (context, i) {
                    return (orderHistoryList[i] != null && orderHistoryList[i]['OrderStatus'] == "Pending")
                        ? ExpansionTile(title: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        // height: 175,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[200],
                                    spreadRadius: 1,
                                    blurRadius: 10)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(


                                  AppLocalizations.of(context).trans(orderHistoryList[i]['OrderStatus']),
                                  style: TextStyle(color: Colors.deepOrange[600],fontSize: 18),),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical:7 ),
                                  child: Text(orderHistoryList[i]['date'],style: TextStyle(fontSize: 12),),
                                ),
                                Row(
                                  children: [
                                    Text(AppLocalizations.of(context).trans("Deliverto"),style: TextStyle(fontWeight: FontWeight.bold),),
                                    Expanded(child: Text(orderHistoryList[i]['userAddress'].toString())),
                                  ],
                                ),




                              ],
                            ),
                          )),
                    ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(children: [
                            Container(
                              height: 60,
                              // color: Colors.red,
                              // margin: EdgeInsets.only(
                              //     left: 15.0),
                              child: ListView.builder(
                                  itemCount: orderHistoryList[i][
                                  "productList"]
                                      .length,
                                  itemBuilder:
                                      (context, index) {
                                    return Container(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          Row(
                                            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Text('${orderHistoryList[i]["productList"][index]['quantity'].toString()}x'),
                                              SizedBox(width: 10,),
                                              Text(

                                                orderHistoryList[i]["productList"][index]['name'],


                                                //
                                                // AppLocalizations.of(context).locale.languageCode.toString()=='ku'?
                                                // currentOrderList[i]["productList"][index]['nameK'].toString().toUpperCase():
                                                // AppLocalizations.of(context).locale.languageCode.toString()=='ar'?
                                                // currentOrderList[i]["productList"][index]['namA'].toString().toUpperCase():
                                                // currentOrderList[i]["productList"][index]['name'].toString().toUpperCase(),


                                                style:
                                                TextStyle(fontSize: 14
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5,),

                                        ],
                                      ),
                                    );
                                  }),
                            ),
                            Row(
                              children: [
                                Text(  AppLocalizations.of(context).trans("DeliveryFee"),style: TextStyle(fontWeight: FontWeight.bold),),
                                Expanded(child: Text('${orderHistoryList[i]['deliveryFee'].toString()}\$')),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Total Price: ',style: TextStyle(fontWeight: FontWeight.bold),),
                                Expanded(child: Text('${orderHistoryList[i]['totalPrice'].toString()}\S')),
                              ],
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text( AppLocalizations.of(context).trans("Exchangedrate"),
                                  style: TextStyle(fontWeight: FontWeight.bold),

                                ),
                                SizedBox(width: 10,),
                                Text('${(orderHistoryList[i]['dinnar']*100).floor().toString()} IQD',
                                  style: TextStyle(fontSize: 13,),
                                ),
                              ],
                            ),

                            SizedBox(height: 10,)

                          ],),
                        )

                      ],
                    )
                        : SizedBox();
                  }),
            );

    }

    else {
      return
        (orderHistoryList.length==0)
            ? EmptyWidget()
            : Container(
              color: Colors.white,
              height:  MediaQuery.of(context).size.height - 200,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: orderHistoryList.length,
                  itemBuilder: (context, i) {
                    return (orderHistoryList[i] != null  && orderHistoryList[i]['OrderStatus'] == "Accepted")
                        ? ExpansionTile(title: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        // height: 175,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[200],
                                    spreadRadius: 1,
                                    blurRadius: 10)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context).trans(orderHistoryList[i]['OrderStatus'].toString()),

                                  style: TextStyle(color:
                                  orderHistoryList[i]['OrderStatus']==   AppLocalizations.of(context).trans("rejected")?
                                  Colors.red[700]:  Colors.green[700]

                                      ,fontSize: 18,fontWeight: FontWeight.bold),),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical:7 ),
                                  child: Text(orderHistoryList[i]['date'],style: TextStyle(fontSize: 12,color: Colors.black),),
                                ),
                                Row(
                                  children: [
                                    Text(  AppLocalizations.of(context).trans("Deliverto"),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                                    Expanded(child: Text(orderHistoryList[i]['userAddress'].toString(),style: TextStyle(color: Colors.black),)),
                                  ],
                                ),




                              ],
                            ),
                          )),
                    ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(children: [
                            Container(
                              height: 80,
                              // color: Colors.red,
                              // margin: EdgeInsets.only(
                              //     left: 15.0),
                              child: ListView.builder(
                                  itemCount: orderHistoryList[i][
                                  "productList"]
                                      .length,
                                  itemBuilder:
                                      (context, index) {
                                    return Container(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          Row(
                                            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Text('${orderHistoryList[i]["productList"][index]['quantity'].toString()}x'),
                                              SizedBox(width: 10,),
                                              Text(
                                                orderHistoryList[i]["productList"][index]['name'],
                                                style:
                                                TextStyle(fontSize: 14
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5,),

                                        ],
                                      ),
                                    );
                                  }),
                            ),
                            Row(
                              children: [
                                Text(  AppLocalizations.of(context).trans("DeliveryFee"),style: TextStyle(fontWeight: FontWeight.bold),),
                                Expanded(child: Text('${orderHistoryList[i]['deliveryFee'].toString()}\$')),
                              ],
                            ),
                            Row(
                              children: [
                                Text( AppLocalizations.of(context).trans("TotalPrice"),style: TextStyle(fontWeight: FontWeight.bold),),
                                Expanded(child: Text('${orderHistoryList[i]['totalPrice'].toString()}\S')),
                              ],
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text( AppLocalizations.of(context).trans("Exchangedrate"),
                                  style: TextStyle(fontWeight: FontWeight.bold),

                                ),
                                SizedBox(width: 10,),
                                Text('${(orderHistoryList[i]['dinnar']*100).floor().toString()} IQD',
                                  style: TextStyle(fontSize: 13,),
                                ),
                              ],
                            ),

                            SizedBox(height: 10,)

                          ],),
                        )

                      ],
                    )
                        : SizedBox();
                  }),
            );

    }

  }

}




