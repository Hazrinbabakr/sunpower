
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlineshopping/Widgets/BackArrowWidget.dart';
import 'package:onlineshopping/Widgets/empty.dart';
import 'package:onlineshopping/localization/AppLocal.dart';
import 'package:onlineshopping/screen/productDetails.dart';
import 'package:onlineshopping/services/local_storage_service.dart';

class ProductsList extends StatefulWidget {
  final String categoryID;
  final categoryName;
  ProductsList(this.categoryID, this.categoryName, {Key key}) : super(key: key);

  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  List<DocumentSnapshot> productListSnapShot;
  List<DocumentSnapshot> makeListSnapShot;
  List<QueryDocumentSnapshot> makeList = [];
  int makeLength;
  String makeID;
  int favLength;
  List<QueryDocumentSnapshot>  productList=[];
  getProducts() {
    int i = 0;
    FirebaseFirestore.instance
        .collection('products')
        .where('categoryID',isEqualTo: widget.categoryID)
        .where('makeId',isEqualTo: makeID)
        .get()
        .then((value) {
      productListSnapShot = new List<DocumentSnapshot>(value.docs.length);
      value.docs.forEach((element) async {
        setState(() {
          productListSnapShot[i] = element;
          productList.add(element);
          favLength=productListSnapShot.length;
        });
        i++;

      });
    });
  }

  getMakes() {

    makeListSnapShot = new List<DocumentSnapshot>(favLength);
    for(int i=0; i<favLength;i++) {
      FirebaseFirestore.instance
          .collection('make')
         // .where("makeId", isEqualTo: productList[i]["makeId"].toString())
          .get()
          .then((value) {
        value.docs.forEach((element) async {
          setState(() {
            makeList.add(element);
            // makeListSnapShot[i] =  element;
            makeLength=makeList.length;
          });
          i++;
        });
      });
    }
  }

  @override
  void initState() {
    getProducts();
    Future.delayed(Duration(milliseconds: 500),(){
      if(productList.length !=0){
        getMakes();
      }
    });
    // TODO: implement initState
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
                return productList.length==0?SizedBox():
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
        padding: const EdgeInsets.only(top: 20),
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
                            Container(
                              width: 150,
                              decoration: BoxDecoration(
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
                                    //color: Colors.red,
                                      width: 170,
                                      child: Text(
                                        AppLocalizations.of(context).locale.languageCode.toString()=='ku'?
                                        productListSnapShot[i]['nameK'].toString().toUpperCase():
                                        AppLocalizations.of(context).locale.languageCode.toString()=='ar'?
                                        productListSnapShot[i]['nameA'].toString().toUpperCase():
                                        productListSnapShot[i]['name'].toString().toUpperCase(),
                                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,


                                      )),
                                  SizedBox(height: 10,),
                                  //LocalStorageService.instance.user.role == 1?
                                  FirebaseAuth.instance.currentUser != null ?

                                  Text('${LocalStorageService.instance.user.role == 1? productListSnapShot[i]['wholesale price'].toString():productListSnapShot[i]['retail price'].toString()}\$',
                                    style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500),):
                                  Text('${productListSnapShot[i]['retail price'].toString()}\$',
                                    style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500),),
                                  SizedBox(height: 10,),
                                  FirebaseAuth.instance.currentUser != null ?
                                  Text( productListSnapShot[i]['old price'].toString()=='0'?'':'${productListSnapShot[i]['old price'].toString()}\$',style:
                                  TextStyle(fontSize: 18,color: Colors.black54,fontWeight: FontWeight.w500,decoration: TextDecoration.lineThrough),)
                                      : SizedBox()

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
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40,),
                Text(  AppLocalizations.of(context).trans("Filterbymake"),style: TextStyle(
                    fontSize: 25, fontWeight: FontWeight.bold),),
                Container(
                //  height: 800,
                  //color: Colors.red,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: makeLength,
                      itemBuilder: (context, i) {
                        return (makeList[i] == null)
                            ? EmptyWidget() :

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 5),
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
                ),


                makeID==null?SizedBox():
                InkWell(
                  onTap: (){
                    setState(() {
                      makeID=null;
                      getProducts();
                      Navigator.of(context).pop();
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
      ),
    );
  }
}