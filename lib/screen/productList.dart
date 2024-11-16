
// ignore_for_file: file_names, prefer_const_constructors_in_immutables, prefer_const_constructors, unrelated_type_equality_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunpower/Widgets/BackArrowWidget.dart';
import 'package:sunpower/Widgets/empty.dart';
import 'package:sunpower/Widgets/product_card.dart';
import 'package:sunpower/localization/AppLocal.dart';
import 'package:sunpower/screen/productDetails.dart';
import 'package:sunpower/services/local_storage_service.dart';

class ProductsList extends StatefulWidget {
   final String categoryID;
   final categoryName;
   ProductsList(this.categoryID, this.categoryName, {Key? key}) : super(key: key);

  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  List<DocumentSnapshot> productListSnapShot = [];
  List<QueryDocumentSnapshot> makeList = [];
  int? makeLength;
  String? makeID;

  getProducts() {
    FirebaseFirestore.instance
        .collection('products')
        .where("categoryID",isEqualTo: widget.categoryID)
        .orderBy("itemCode", descending: false)
        .get()
        .then((value) {
      productListSnapShot.clear();
      productListSnapShot.addAll(value.docs);
      print(productListSnapShot.length);
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

    var makeSet = Set();
    makeSet.addAll(productListSnapShot.map((e) => e["makeId"].toString()));
    print(makeSet);

    //for(int i=0; i<productListSnapShot.length;i++) {
      await FirebaseFirestore.instance
          .collection('make')
          .where("makeId",whereIn: makeSet.toList()
         // isEqualTo: productListSnapShot[i]["makeId"].toString()
      )
          .get()
          .then((value) {
            makeList.addAll(value.docs);
            makeLength = makeList.length;
            print(makeList);
            // for(int j=0 ; j<value.docs.length ; j++){
            //   var element = value.docs[j];
            //   if(makeList.where((oldList) {
            //     return oldList["makeId"] == element["makeId"];
            //   }).isEmpty){
            //     makeList.add(element);
            //     makeLength=makeList.length;
            //   }
            // }
      });
      //     .whenComplete(() {
      //   if (mounted) {
      //     setState(() {
      //       makeList = makeList;
      //     });
      //   }
      // });
    //}
    if(mounted){
      setState(() {

      });
    }
  }

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
          title: Text(widget.categoryName,style: TextStyle(color: Colors.black87),),
          elevation: 0,
          leading: BackArrowWidget(),
          actions:[
            Builder(
            builder: (BuildContext context) {
              return productListSnapShot.length==0?SizedBox():
              IconButton(
                color: Colors.black87,
                icon: const Icon(Icons.filter_list),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),]
      ),
      body:Builder(builder: (context){
        if(productListSnapShot.isEmpty){
          return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
              )
          );
        }

        var filteredList = productListSnapShot;
        if(makeID != null){
          filteredList = productListSnapShot.where((element) => element['makeId'] == makeID).toList();
        }
        return GridView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 8,
              childAspectRatio: 0.7
          ),
          itemCount: filteredList.length,
          itemBuilder: (context, i) {
            // if (
            // true
            // //productListSnapShot[i]['categoryID'] == widget.categoryID && productListSnapShot[i]['newArrival'] //&& makeID == null
            // )
            // {
            //
            // }
            // print(makeID);
            // print(filteredList[i]['makeId']);
            // if(makeID != null && makeID != filteredList[i]['makeId']){
            //   return const SizedBox();
            // }

            return InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProductDetails( filteredList[i].id.toString()),
                ));
              },
              child: ProductCard(
                  productListSnapShot:filteredList[i]
              ),
            );

          },
        );
      }),


      endDrawer: Drawer(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 100,),
              Text(  AppLocalizations.of(context).trans("Filterbymake"),style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold),),
              makeList.isEmpty ?
                  const SizedBox():
              //EmptyWidget() :
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: makeList.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                      child: InkWell(
                        onTap: (){
                          makeID=makeList[i].id.toString();
                          setState(() {

                          });
                          //getProducts();
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            boxShadow:  [
                              BoxShadow(
                                color: makeID==makeList[i].id.toString()? Colors.red: Colors.grey[300]!,
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
              makeID==null?
              SizedBox():
              InkWell(
                onTap: (){
                  setState(() {
                    makeID=null;
                    //getProducts();
                   // Navigator.of(context).pop();
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).primaryColor,
                    boxShadow:  [
                      BoxShadow(
                        color: Colors.grey[300]!,
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

  // comment(){
  //   //( productListSnapShot[i]['categoryID']==widget.categoryID && productListSnapShot[i]['newArrival'] && (makeID.toString() == productListSnapShot[i]['makeId'] ))?
  //   InkWell(
  //   onTap: (){
  //   Navigator.of(context).push(MaterialPageRoute(
  //   builder: (context) => ProductDetails( productListSnapShot[i].id.toString()),
  //   ));
  //   },
  //   child: Padding(
  //   padding: const EdgeInsets.only(bottom: 5),
  //   child: Container(
  //   height: 140,
  //   decoration: BoxDecoration(
  //   color: Colors.white,
  //   boxShadow: [
  //   BoxShadow(
  //   color: Colors.grey[200]!,
  //   spreadRadius: 1,
  //   blurRadius: 10
  //   )
  //   ]
  //   ),
  //   child: Row(
  //   children: [
  //   Container(
  //   height: 140,
  //   width: 150,
  //   decoration: BoxDecoration(
  //   borderRadius: BorderRadius.all(
  //   Radius.circular(20)
  //   ),
  //   border: Border.all(color: Colors.black12,width: 0.6),
  //   image: DecorationImage(
  //   image: NetworkImage(
  //   productListSnapShot[i]['images'].isEmpty?
  //   "images/category/emptyimg.png":
  //   productListSnapShot[i]['images'][0].toString()
  //   )
  //   )
  //   ),
  //   ),
  //   Padding(
  //   padding: const EdgeInsets.only(bottom: 10,top: 20,left: 30,right: 10),
  //   child: Column(
  //   crossAxisAlignment: CrossAxisAlignment.start,
  //   children: [
  //   Container(
  //   width: 220,
  //   child: Text(
  //   AppLocalizations.of(context).locale.languageCode.toString()=='ku'?
  //   productListSnapShot[i]['nameK'].toString().toUpperCase():
  //   AppLocalizations.of(context).locale.languageCode.toString()=='ar'?
  //   productListSnapShot[i]['nameA'].toString().toUpperCase():
  //   productListSnapShot[i]['name'].toString().toUpperCase(),
  //   style: TextStyle(fontSize: 14,),
  //   overflow: TextOverflow.ellipsis,
  //   maxLines: 2,
  //   )
  //   ),
  //   SizedBox(height: 15,),
  //   FirebaseAuth.instance.currentUser != null ?
  //   Text('${LocalStorageService.instance.user!.role == 1? productListSnapShot[i]['wholesale price'].toString():productListSnapShot[i]['retail price'].toString()}\$',
  //   style: TextStyle(fontSize: 18,color: Colors.blue,fontWeight: FontWeight.w500),):
  //   Text('${productListSnapShot[i]['retail price'].toString()}\$',
  //   style: TextStyle(fontSize: 18,color: Colors.blue[800],fontWeight: FontWeight.w500),),
  //   SizedBox(height: 5,),
  //   Row(
  //   children: [
  //   Text( AppLocalizations.of(context).trans("ItemCode"),
  //   maxLines: 3,
  //   style: TextStyle(fontSize: 12),
  //   ),
  //   SizedBox(width: 5,),
  //   Container(
  //   width: 150,
  //   child: Text(productListSnapShot[i]['itemCode'].toString(),
  //   maxLines: 1,
  //   overflow: TextOverflow.ellipsis,
  //   style: TextStyle(fontSize: 14,color: Colors.red[900]),
  //   ),
  //   )
  //   ],
  //   ),
  //   ],
  //   ),
  //   ),
  //   ],
  //   )
  //   ),
  //   ),
  //   ) ;
  //   //: const SizedBox();
  // }
}



// bgsQNIHP9KcLBlaqyNWqvMRLvZc2: FirebaseAuthError: TOO_LONG
// p6NeE2855AReohljnNOh1Rc0q753: FirebaseAuthError: Invalid format.
// LkAmgxK4a1cCOmJhd5gj8Rkgj2C3: FirebaseAuthError: TOO_LONG