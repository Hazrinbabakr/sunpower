// ignore_for_file: file_names, prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key key}) : super(key: key);
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<DocumentSnapshot> allProductListSnapShot;
  List<DocumentSnapshot> favListSnapShot;
  User user;
  FirebaseAuth _auth;
  int cartLength;
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
            cartLength=favListSnapShot.length;
            print('iDDDDDD ${favListSnapShot[i].id}');
          });
          i++;
        });
        print('lengthhhh $cartLength');
      });
  }
  getAllProduct() {
  allProductListSnapShot = new List<DocumentSnapshot>(cartLength);
  for(int i=0; i<cartLength;i++) {

    FirebaseFirestore.instance
        .collection('products').where("productID", isEqualTo: favListSnapShot[i].id)
        .get()
        .then((value) {
      value.docs.forEach((element) async {
        setState(() {
          allProductListSnapShot[i] =  element;
        });
        i++;
        print('${allProductListSnapShot[i]['name']}  nameeee');

      });
      print('${allProductListSnapShot.length}  22222lenthhhh');

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
Future.delayed(Duration(seconds: 2),(){
  getAllProduct();
});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorite Screen'),),
    );
  }
}
