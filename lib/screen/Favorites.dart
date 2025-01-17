// ignore_for_file: file_names, prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sunpower/Widgets/BackArrowWidget.dart';
import 'package:sunpower/Widgets/empty.dart';
import 'package:sunpower/Widgets/product_card.dart';
import 'package:sunpower/localization/AppLocal.dart';
import 'package:sunpower/screen/productDetails.dart';
import 'package:sunpower/services/local_storage_service.dart';


class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final userCollection = FirebaseFirestore.instance.collection('users');
  List<DocumentSnapshot>? allProductListSnapShot;
  List<DocumentSnapshot>? favListSnapShot;
  User user = FirebaseAuth.instance.currentUser!;
  FirebaseAuth _auth = FirebaseAuth.instance;
  List<String> favList=[];
  bool deleting = false;
  getFavProduct() {
    FirebaseFirestore.instance
        .collection('users').doc(user.uid).collection('favorite')
        .get()
        .then((value) {
          favListSnapShot = [];
      favList = [];
      allProductListSnapShot = [];
      favListSnapShot!.addAll(value.docs);
      favList.addAll(value.docs.map((e) => e.id));
    }).whenComplete((){
      if(favListSnapShot!.isNotEmpty){
        getAllProduct();
      }
      else{
        deleting = false;
        setState(() {

        });
      }

    });
  }
  getAllProduct() {
    allProductListSnapShot = [];
    for(int i=0; i<favListSnapShot!.length;i++) {
      FirebaseFirestore.instance
          .collection('products')
          .where("productID", isEqualTo: favList[i])
          .get()
          .then((value) {
        allProductListSnapShot!.addAll(value.docs);
        deleting = false;
        setState(() {

        });
      });
    }
  }


  @override
  void initState() {
    super.initState();
    getFavProduct();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
            title: Text(  AppLocalizations.of(context).trans("Favorite"),style: TextStyle(color: Colors.black87),),
            elevation: 0,
        ),
        body: Builder(
          builder: (BuildContext context) {
            if(allProductListSnapShot == null){
              return Center(child: const CircularProgressIndicator());
            }
            if(allProductListSnapShot!.isEmpty){
              return const SizedBox();
            }
            bool isTab = MediaQuery.of(context).orientation == Orientation.landscape || MediaQuery.of(context).size.width > 460;
            return GridView.builder(
              padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isTab ? 4 : 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.8
              ),
              itemCount: allProductListSnapShot!.length,
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductDetails( allProductListSnapShot![i].id.toString()),
                    ));
                  },
                  child: Stack(
                    children: [
                      ProductCard(
                          productListSnapShot:allProductListSnapShot![i].data()
                      ),
                      Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              shape: BoxShape.circle
                            ),
                            child: IconButton(
                              icon: Icon(Icons.favorite,size: 30,color: Colors.red,),
                              onPressed: () {
                                try {
                                  if(deleting){
                                    return;
                                  }
                                  deleting = true;
                                  User user = _auth.currentUser!;
                                  userCollection
                                      .doc(user.uid)
                                      .collection('favorite')
                                      .doc(allProductListSnapShot![i].id)
                                      .delete();
                                  getFavProduct();
                                  setState(() {});
                                } catch (error){
                                  deleting = false;
                                }
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
        )
    );
  }
}



