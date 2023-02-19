
// ignore_for_file: file_names, prefer_const_constructors_in_immutables, prefer_const_constructors, unrelated_type_equality_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunpower/Widgets/BackArrowWidget.dart';
import 'package:sunpower/Widgets/empty.dart';
import 'package:sunpower/localization/AppLocal.dart';
import 'package:sunpower/screen/productDetails.dart';
import 'package:sunpower/services/local_storage_service.dart';

class ProductsList extends StatefulWidget {
   final String categoryID;
   final categoryName;
   ProductsList(this.categoryID, this.categoryName, {Key key}) : super(key: key);

  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  List<DocumentSnapshot> productListSnapShot = [];
  List<QueryDocumentSnapshot> makeList = [];
  int makeLength;
  String makeID;
  getProducts() {
    FirebaseFirestore.instance
        .collection('products')
        .where('categoryID',isEqualTo: widget.categoryID)
        .where('makeId',isEqualTo: makeID)
        .get()
        .then((value) {
      productListSnapShot.clear();
      productListSnapShot.addAll(value.docs);
      if(mounted){
        setState(() {

        });
      }
      getMakes();

    });
  }

  getMakes() async {
    if(makeList.isNotEmpty){
      return;
    }
    makeList.clear();
    for(int i=0; i<productListSnapShot.length;i++) {
      await FirebaseFirestore.instance
          .collection('make')
          .where("makeId", isEqualTo: productListSnapShot[i]["makeId"].toString())
          .get()
          .then((value) {
            for(int j=0 ; j<value.docs.length ; j++){
              var element = value.docs[j];
              if(makeList.where((oldList) {
                return oldList["makeId"] == element["makeId"];
              }).isEmpty){
                makeList.add(element);
                makeLength=makeList.length;
              }
            }
      });
    }
    if(mounted){
      setState(() {

      });
    }
  }

  @override
  void initState() {
    getProducts();
   // Future.delayed(Duration(milliseconds: 500),(){
   //  if(productList.length !=0){
   //    getMakes();
   //  }
   // });
   //  // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,

      appBar:
      AppBar(
          title: Text(widget.categoryName),
          elevation: 0,
          leading: BackArrowWidget(),
          actions:[
            Builder(
            builder: (BuildContext context) {
              return productListSnapShot.length==0?SizedBox():
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),]
      ),

      body:  (productListSnapShot == null || productListSnapShot.isEmpty)
          ? Padding(
            padding: const EdgeInsets.only(top: 300),
            child: Center(
            child: EmptyWidget()),
          )
          : SingleChildScrollView(
            child: Container(
              height:700,
             // color: Colors.red,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: productListSnapShot.length,
                        itemBuilder: (context, i) {
                          return (productListSnapShot[i] != null)
                              ? InkWell(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ProductDetails( productListSnapShot[i].id.toString()),
                              ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Container(
                                  height: 140,
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
                                      Container(
                                        height: 140,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          //color: Colors.red,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)
                                              //                 <--- border radius here
                                            ),
                                            border: Border.all(color: Colors.black12,width: 0.6),
                                            image: DecorationImage(
                                              // fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    productListSnapShot[i]['images'][0].toString()
                                                )
                                            )),
                                      ),
                                      //SizedBox(width: 30,),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 10,top: 20,left: 30,right: 10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              // color: Colors.red,
                                                width: 170,
                                                child: Text(
                                                  AppLocalizations.of(context).locale.languageCode.toString()=='ku'?
                                                  productListSnapShot[i]['nameK'].toString().toUpperCase():
                                                  AppLocalizations.of(context).locale.languageCode.toString()=='ar'?
                                                  productListSnapShot[i]['nameA'].toString().toUpperCase():
                                                  productListSnapShot[i]['name'].toString().toUpperCase(),
                                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                )),
                                            SizedBox(height: 5,),
                                            //LocalStorageService.instance.user.role == 1?
                                        FirebaseAuth.instance.currentUser != null ?

                                            Text('${LocalStorageService.instance.user.role == 1? productListSnapShot[i]['wholesale price'].toString():productListSnapShot[i]['retail price'].toString()}\$',
                                              style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500),):
                                        Text('${productListSnapShot[i]['retail price'].toString()}\$',
                                          style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500),),

                                            SizedBox(height: 15,),

                                            Row(
                                              //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Text( AppLocalizations.of(context).trans("ItemCode"),
                                                  maxLines: 3,
                                                  style: TextStyle(fontSize: 14),
                                                ),
                                                SizedBox(width: 5,),
                                                Container(
                                                  width: 100,
                                                  child: Text(productListSnapShot[i]['itemCode'].toString(),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                                  ),
                                                )
                                              ],),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                            ),)
                              : EmptyWidget();
                        }),
            ),
          ),


      endDrawer: Drawer(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 100,),
              Text(  AppLocalizations.of(context).trans("Filterbymake"),style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold),),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: makeList.length,
                  itemBuilder: (context, i) {
                    if(makeList.length <= i){
                      print(makeList.length);
                      return const SizedBox();
                    }
                    return (makeList[i] == null)
                        ? EmptyWidget() :

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                      child: InkWell(
                        onTap: (){
                          makeID=makeList[i].id.toString();
                          getProducts();
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            boxShadow:  [
                              BoxShadow(
                                color: Colors.grey[300],
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset: Offset(-4, 4),
                              ),
                            ],
                          ),

                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 6),
                            child: Text(
                              AppLocalizations.of(context).locale.languageCode.toString()=='ku'?
                              makeList[i]['makeK'].toString().toUpperCase():
                              AppLocalizations.of(context).locale.languageCode.toString()=='ar'?
                              makeList[i]['makeA'].toString().toUpperCase():
                              makeList[i]['make'].toString().toUpperCase(),

                              style: TextStyle(fontSize: 18,),
                              overflow: TextOverflow.visible,maxLines: 3,),
                          ),
                        ),
                      ),
                    );
                  }),

SizedBox(height: 100,),
              makeID==null?SizedBox():
              InkWell(
                onTap: (){
                  setState(() {
                    makeID=null;
                    getProducts();
                   // Navigator.of(context).pop();
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.red[900],
                    boxShadow:  [
                      BoxShadow(
                        color: Colors.grey[300],
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: Offset(-4, 4),
                      ),
                    ],
                  ),
                  child: Text('Remove Filter',style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight:  FontWeight.bold
                  ),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
