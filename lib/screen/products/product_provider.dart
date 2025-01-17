import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunpower/models/product.dart';
import 'package:sunpower/services/local_storage_service.dart';

class ProductProvider extends ChangeNotifier{
  static ProductProvider of(BuildContext context) => Provider.of<ProductProvider>(context,listen: false);

//  List<Product>? products;
  List<DocumentSnapshot>? products;
  dynamic error;
  getSpecialProducts() async {
    try{
      var result;
      var query = FirebaseFirestore.instance.collection('products');
      if(LocalStorageService.instance.user == null || LocalStorageService.instance.user!.role != 1){
        result = await query.where('old price',isGreaterThan: 0).get();
      } else {
        result = await query.where('old wholesale price',isGreaterThan: 0).get();
      }


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
          .where('isNew',isEqualTo: true)
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