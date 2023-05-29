import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sunpower/screen/productDetails.dart';

import '../localization/AppLocal.dart';
import '../services/local_storage_service.dart';

class ProductCard extends StatefulWidget {
  final product;

  const ProductCard({Key? key, this.product}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  // bool isFav = false;
  // FirebaseAuth _auth = FirebaseAuth.instance;
  // User user = FirebaseAuth.instance.currentUser!;
  // final userCollection = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    //NumberFormat formatter = NumberFormat("###,###,###,###");
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductDetails(
              widget.product.id.toString()),
        ));
      },
      child: Container(
          height: 140,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[200]!,
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
                            widget.product['images'].isEmpty?
                            "images/category/emptyimg.png":
                            widget.product['images'][0].toString()
                        )
                    )
                ),
              ),
              //SizedBox(width: 30,),
              Padding(
                padding: const EdgeInsets.only(bottom: 10,top: 20,left: 30,right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //name
                    Container(
                      // color: Colors.red,
                        width: 220,
                        child: Text(
                          AppLocalizations.of(context).locale.languageCode.toString()=='ku'?
                          widget.product['nameK'].toString().toUpperCase():
                          AppLocalizations.of(context).locale.languageCode.toString()=='ar'?
                          widget.product['nameA'].toString().toUpperCase():
                          widget.product['name'].toString().toUpperCase(),

                          style: TextStyle(fontSize: 14,),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        )),



                    SizedBox(height: 15,),
                    //LocalStorageService.instance.user.role == 1?
                    FirebaseAuth.instance.currentUser != null ?

                    Text('${LocalStorageService.instance.user!.role == 1? widget.product['wholesale price'].toString():widget.product['retail price'].toString()}\$',
                      style: TextStyle(fontSize: 18,color: Colors.blue,fontWeight: FontWeight.w500),):
                    Text('${widget.product['retail price'].toString()}\$',
                      style: TextStyle(fontSize: 18,color: Colors.blue[800],fontWeight: FontWeight.w500),),

                    SizedBox(height: 5,),





                    // item code
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text( AppLocalizations.of(context).trans("ItemCode"),
                          maxLines: 3,
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(width: 5,),
                        Container(
                          width: 150,
                          child: Text(widget.product['itemCode'].toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 12,color: Colors.red[900]),
                          ),
                        )
                      ],),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
