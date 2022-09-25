import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onlineshopping/Widgets/BackArrowWidget.dart';
import 'package:onlineshopping/Widgets/empty.dart';

class ProductDetails extends StatefulWidget {
  final String productID;
  const ProductDetails(this.productID, {Key key}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  DocumentSnapshot productDetailSnapShot;
  DocumentSnapshot snapshot;
  Future getProducts() async{
     productDetailSnapShot = await FirebaseFirestore.instance
        .collection('products').doc(widget.productID)
        .get();
     setState(() {
       snapshot=productDetailSnapShot;
     });
  }
  @override
  void initState() {
    getProducts();
    print(widget.productID+'   Product ID');
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text('Product details'),
        leading: BackArrowWidget(),

      ),
      body:snapshot==null?
      EmptyWidget():
      Text(snapshot.data()['name']),
    );
  }
}
