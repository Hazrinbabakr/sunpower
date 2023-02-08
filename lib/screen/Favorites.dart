// ignore_for_file: file_names, prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onlineshopping/Widgets/BackArrowWidget.dart';
import 'package:onlineshopping/Widgets/empty.dart';
import 'package:onlineshopping/localization/AppLocal.dart';
import 'package:onlineshopping/screen/productDetails.dart';
import 'package:onlineshopping/services/local_storage_service.dart';


class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key key}) : super(key: key);
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final userCollection = FirebaseFirestore.instance.collection('users');
  List<DocumentSnapshot> allProductListSnapShot;
  List<DocumentSnapshot> favListSnapShot;
  User user;
  FirebaseAuth _auth;
  int favLength;
  List<String> favList=[];
  getFavProduct() {
    int i = 0;
    FirebaseFirestore.instance
        .collection('users').doc(user.uid).collection('favorite')
        .get()
        .then((value) {
      value.docs.forEach((element) async {
        favListSnapShot = new List<DocumentSnapshot>(value.docs.length);
        setState(() {
          favListSnapShot[i] =  element;
          favLength=favListSnapShot.length;
          favList.add(favListSnapShot[i].id);
        });
        i++;
      });
    }).whenComplete((){
      if(favLength !=null){
        getAllProduct();
      }
    });
  }
  getAllProduct() {
    allProductListSnapShot = new List<DocumentSnapshot>(favLength);
    // allProductList = new List<Map>(productListSnapShot.length);
    for(int i=0; i<favLength;i++) {
      FirebaseFirestore.instance
          .collection('products').where("productID", isEqualTo: favList[i])
          .get()
          .then((value) {
        value.docs.forEach((element) async {
          setState(() {
            allProductListSnapShot[i] =  element;
          });
          i++;
        });
      });
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth= FirebaseAuth.instance;
    user=_auth.currentUser;
    getFavProduct();
// Future.delayed(Duration(seconds: 2),(){
//   getAllProduct();
// });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
            title: Text(  AppLocalizations.of(context).trans("Favorite"),),
            elevation: 0,
        ),

        body:
        (allProductListSnapShot == null || allProductListSnapShot.isEmpty)
            ? EmptyWidget()
            : Padding(
            padding: const EdgeInsets.only(top: 30),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: allProductListSnapShot.length,
                itemBuilder: (context, i) {
                  return (allProductListSnapShot[i] != null)
                      ? InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProductDetails( allProductListSnapShot[i].id.toString()),
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Stack(
                        children: [
                          Container(
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
                                    width: 120,
                                   // height: 100,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)
                                          //                 <--- border radius here
                                        ),
                                        border: Border.all(color: Colors.black12,width: 0.6),
                                        image: DecorationImage(
                                          // fit: BoxFit.cover,
                                            image: NetworkImage(
                                                allProductListSnapShot[i]['images'][0].toString()
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
                                              allProductListSnapShot[i]['nameK'].toString().toUpperCase():
                                              AppLocalizations.of(context).locale.languageCode.toString()=='ar'?
                                              allProductListSnapShot[i]['nameA'].toString().toUpperCase():
                                              allProductListSnapShot[i]['name'].toString().toUpperCase(),

                                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,), overflow: TextOverflow.visible,maxLines: 3,)),
                                        SizedBox(height: 5,),
                                        //LocalStorageService.instance.user.role == 1?
                                        Text('${LocalStorageService.instance.user.role == 1? allProductListSnapShot[i]['wholesale price'].toString():
                                        allProductListSnapShot[i]['retail price'].toString()}\$',style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500),),
                                        SizedBox(height: 5,),
                                        Text( allProductListSnapShot[i]['old price'].toString()=='0'?'':'${allProductListSnapShot[i]['old price'].toString()}\$',style:
                                        TextStyle(fontSize: 15,color: Colors.black54,fontWeight: FontWeight.w500,decoration: TextDecoration.lineThrough),),
                                      ],
                                    ),
                                  ),
                                ],
                              )),

                          Positioned(
                              right: 10,
                              bottom: 20,
                              child: InkWell(
                                  onTap: (){
                                    User user = _auth.currentUser;
                                    userCollection
                                        .doc(user.uid)
                                        .collection('favorite')
                                        .doc(allProductListSnapShot[i].id).delete();
                                    getFavProduct();
                                    setState(() {
                                    });
                                  },
                                  child: Icon(Icons.favorite,size: 30,color: Colors.red[900],)))
                        ],
                      ),
                    ),)
                      : SizedBox();
                }),
        )
    );
  }
}



