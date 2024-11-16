import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunpower/models/product.dart';
import 'package:http/http.dart' as http;


class SearchProductProvider extends ChangeNotifier{
  static SearchProductProvider of(BuildContext context) => Provider.of<SearchProductProvider>(context,listen: false);

  List<Product>? products;
  dynamic error;
  bool working = false;

  getProducts(String search) async {
    try{
      products = null;
      working = true;
      notifyListeners();
      var response = await http.get(Uri.parse(
        //'http://127.0.0.1:5001/baharka-library-e410f/us-central1/searchByname'
        'https://searchbyname-idz2bbdwza-uc.a.run.app'
            '?text=${search}&lang=en'
      ));
      List decodedBody = json.decode(response.body)['results'] as List;


      products = decodedBody.map((e) => Product.fromJson(e)).toList();

      products = products!.toSet().toList();
      working = false;
      notifyListeners();
    }
    catch(error){
      print(error);
      working = false;

      this.error = error;
      notifyListeners();
    }
  }

}