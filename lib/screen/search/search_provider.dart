import 'dart:convert';

import 'package:algoliasearch/algoliasearch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunpower/models/product.dart';
import 'package:http/http.dart' as http;

class SearchProductProvider extends ChangeNotifier{
  static SearchProductProvider of(BuildContext context) => Provider.of<SearchProductProvider>(context,listen: false);

  List<Product>? products;
  dynamic error;
  bool working = false;
  final client = SearchClient(
    appId: 'NCGLNUOYVK',
    apiKey: '9c9e1f5676a0a5ada638b135a1893f63',
  );



  getProducts(String search,{reset = true}) async {
    try{
      if(reset){
        products = null;
        working = true;
        notifyListeners();
      }
      if(products != null && products!.length % 15 != 0){
        return;
      }
      var queryHits = SearchForHits(
          indexName: 'index',
          query: "${search}",
          length: 15,

          //filters: "itemCode:${search}",
          //queryType: QueryType.prefixLast,

          page: reset ? 0 : products!.length ~/ 15,
      );
      
      final responseHits = await client.searchIndex(request: queryHits);
      final List<String >objectsId = responseHits.hits.map((e) => e.objectID).toList();

      if(products == null){
        products = [];
      }

      if(objectsId.isNotEmpty){
        final documents = await
        FirebaseFirestore
            .instance
            .collection("products")
            .where("productID",whereIn: objectsId)
            .get();

        products!.addAll(documents.docs.map((e) => Product.fromDoc(e)));
      }

      // var response = await http.get(Uri.parse(
      //   //'http://127.0.0.1:5001/baharka-library-e410f/us-central1/searchByname'
      //   'https://searchbyname-idz2bbdwza-uc.a.run.app'
      //       '?text=${search}&lang=en'
      // ));
      // List decodedBody = json.decode(response.body)['results'] as List;
      // products = decodedBody.map((e) => Product.fromJson(e)).toList();
      //
      // products = products!.toSet().toList();
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