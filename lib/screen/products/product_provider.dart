import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunpower/models/product.dart';

class ProductProvider extends ChangeNotifier{
  static ProductProvider of(BuildContext context) => Provider.of<ProductProvider>(context,listen: false);

//  List<Product>? products;
  List<DocumentSnapshot>? products;
  dynamic error;
  getSpecialProducts() async {
    try{
      print("getSpecialProducts");
      var result = await FirebaseFirestore.instance
          .collection('products')
          .where('old price',isGreaterThan: 0)
          .get();
      products = result.docs;
      // List<Product>.from(result.docs.map((e) => Product.fromDoc(e)));
      notifyListeners();
    } catch(error){
      print(error);
      this.error = error;
      notifyListeners();
    }
  }


  getNewProducts() async {
    try{
      var result = await FirebaseFirestore.instance
          .collection('products')
          .where('newArrival',isEqualTo: true)
          .get();
      products =  result.docs;
      //List<Product>.from(result.docs.map((e) => Product.fromDoc(e)));
      notifyListeners();
    } catch(error){
      this.error = error;
      notifyListeners();
    }
  }

}