import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunpower/models/category.dart';

class CategoriesProvider extends ChangeNotifier {

  static CategoriesProvider of(BuildContext context) => Provider.of<CategoriesProvider>(context,listen: false);

  List<Category>? categories;
  dynamic error;
  getCategories() async {
    try{
      var result = await FirebaseFirestore.instance.collection('categories').get();
      categories =  List<Category>.from(result.docs.map((e) => Category.fromDoc(e)));
      notifyListeners();
    } catch(error){
      this.error = error;
      notifyListeners();
    }
  }
}