
// ignore_for_file: file_names, prefer_const_constructors_in_immutables, prefer_const_constructors, unrelated_type_equality_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlineshopping/Widgets/BackArrowWidget.dart';
import 'package:onlineshopping/Widgets/empty.dart';
import 'package:onlineshopping/screen/productDetails.dart';

class ProductsList extends StatefulWidget {
   final String categoryID;
   final categoryName;
   ProductsList(this.categoryID, this.categoryName, {Key key}) : super(key: key);

  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  List<DocumentSnapshot> productListSnapShot;
  getProducts() {
    int i = 0;
    FirebaseFirestore.instance
        .collection('products').where('categoryID',isEqualTo: widget.categoryID)
        .get()
        .then((value) {
      productListSnapShot = new List<DocumentSnapshot>(value.docs.length);
      value.docs.forEach((element) async {
        setState(() {
          productListSnapShot[i] = element;
        });
        i++;
      });
    }).whenComplete(() {
      print(productListSnapShot.length);
    });

  }
  @override
  void initState() {
    getProducts();
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.categoryName),
        elevation: 0,
        leading: BackArrowWidget()
      ),
      body:
      (productListSnapShot == null)
          ? EmptyWidget()
          : Padding(
            padding: const EdgeInsets.only(top: 30),
            child: ListView.builder(
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
                    height: 150,
                    decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[200],
                                  spreadRadius: 1,
                                  blurRadius: 10
                              )

                            ]),
                    child: Row(
                        children: [
                          Container(
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20)
                                  //                 <--- border radius here
                                ),
                                border: Border.all(color: Colors.black12,width: 0.6),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        productListSnapShot[i]['img'].toString()))),
                          ),
                          //SizedBox(width: 30,),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10,top: 30,left: 30),
                            child: Column(
                             // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(productListSnapShot[i]['name'].toString().toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23),),
                                SizedBox(height: 10,),
                                Text('1,000 IQD',style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500),),
                                SizedBox(height: 10,),
                                Text('1,500 IQD',style: TextStyle(fontSize: 18,color: Colors.black54,fontWeight: FontWeight.w500,decoration: TextDecoration.lineThrough),),
                              ],
                            ),
                          ),



                        ],




                  )),
                        ),
                      )
                      : EmptyWidget();
                }),
          )
    );
  }
}
