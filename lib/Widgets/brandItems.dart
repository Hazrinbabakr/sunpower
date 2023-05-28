import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


import '../localization/AppLocal.dart';
import '../screen/productDetails.dart';
import '../screen/products_widget.dart';
import 'BackArrowWidget.dart';
import 'empty.dart';

class BrandItems extends StatefulWidget {
  final String brandID;
  final brandName;
  BrandItems(this.brandID, this.brandName, {Key? key}) : super(key: key);

  @override
  _BrandItemsState createState() => _BrandItemsState();
}

class _BrandItemsState extends State<BrandItems> {
  List<DocumentSnapshot>? productListSnapShot ;

  getProducts() {
    //int i = 0;
    FirebaseFirestore.instance
        .collection('products')
        .orderBy("itemCode", descending: false)
     //.where('brand',isEqualTo:widget.brandName)
        .get()
        .then((value) {
      productListSnapShot = [];
      productListSnapShot!.addAll(value.docs);
      setState(() {

      });
    });
  }

  @override
  void initState() {
    getProducts();
    // getProducts();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {



    return
      Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: BackArrowWidget(),
        title: Text(widget.brandName,style: TextStyle(color:Colors.black87),),
        elevation: 0,),
        body: (productListSnapShot == null || productListSnapShot!.isEmpty)
            ? Center(child: EmptyWidget())
            : SingleChildScrollView(
            child:
            Container(
              height:700,
              // color: Colors.red,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: productListSnapShot!.length,
                  itemBuilder: (context, i) {
                    DocumentSnapshot data=  productListSnapShot!.elementAt(i);
                    return
                      productListSnapShot![i]['brand']==widget.brandName?
                      ProductCard(
                              product: data,
                            ):SizedBox();
                  }),
            )


          // Column(
          //   children: [
          //     // Text(makeListSnapShot[1]["make"].toString()??""),
          //     Padding(
          //       padding: const EdgeInsets.only(top: 30),
          //       child: ListView.builder(
          //           shrinkWrap: true,
          //           itemCount: productListSnapShot.length,
          //           itemBuilder: (context, i) {
          //             return (productListSnapShot[i] != null)
          //                 ? InkWell(
          //               onTap: (){
          //                 Navigator.of(context).push(MaterialPageRoute(
          //                   builder: (context) => ProductDetails( productListSnapShot[i].id.toString()),
          //                 ));
          //               },
          //               child: Padding(
          //                 padding: const EdgeInsets.only(bottom: 20),
          //                 child: Container(
          //                     height: 175,
          //                     decoration: BoxDecoration(
          //                         color: Colors.white,
          //                         boxShadow: [
          //                           BoxShadow(
          //                               color: Colors.grey[200],
          //                               spreadRadius: 1,
          //                               blurRadius: 10)
          //                         ]),
          //                     child: Row(
          //                       children: [
          //                         Container(
          //                           width: 150,
          //                           decoration: BoxDecoration(
          //                               borderRadius: BorderRadius.all(
          //                                   Radius.circular(20)
          //                                 //                 <--- border radius here
          //                               ),
          //                               border: Border.all(color: Colors.black12,width: 0.6),
          //                               image: DecorationImage(
          //                                  fit: BoxFit.cover,
          //                                   image: NetworkImage(
          //                                       productListSnapShot[i]['img'][0].toString()
          //                                   )
          //                               )),
          //                         ),
          //                         //SizedBox(width: 30,),
          //                         Padding(
          //                           padding: const EdgeInsets.only(bottom: 10,top: 20,left: 30,right: 10),
          //                           child: Column(
          //                             crossAxisAlignment: CrossAxisAlignment.start,
          //                             children: [
          //                               Container(
          //                                   width: 170,
          //                                   child: Text(
          //                                     AppLocalizations.of(context).locale.languageCode.toString()=='ku'?
          //                                     productListSnapShot[i]['nameK'].toString().toUpperCase():
          //                                     AppLocalizations.of(context).locale.languageCode.toString()=='ar'?
          //                                     productListSnapShot[i]['nameA'].toString().toUpperCase():
          //                                     productListSnapShot[i]['name'].toString().toUpperCase(),
          //
          //                                     style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,), overflow: TextOverflow.visible,maxLines: 3,)),
          //                               SizedBox(height: 10,),
          //                               //LocalStorageService.instance.user.role == 1?
          //                               Text('${productListSnapShot[i]['price'].toString()}\$',
          //                                 style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500),),
          //
          //                             ],
          //                           ),
          //                         ),
          //                       ],
          //                     )),
          //               ),
          //
          //
          //             )
          //                 : EmptyWidget();
          //           }),
          //     ),
          //   ],
          // ),
        )
      );
  }
}
