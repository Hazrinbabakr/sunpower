import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sunpower/screen/products/product_horizontal_list.dart';
import 'package:sunpower/screen/products/product_provider.dart';

class SpecialOffersProducts extends StatefulWidget {
  const SpecialOffersProducts({Key? key}) : super(key: key);

  @override
  State<SpecialOffersProducts> createState() => _SpecialOffersProductsState();
}

class _SpecialOffersProductsState extends State<SpecialOffersProducts> {
  ProductProvider productProvider = ProductProvider();

  @override
  void initState() {
    super.initState();
    productProvider.getSpecialProducts();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: productProvider,
      child: Consumer<ProductProvider>(
        builder: (BuildContext context, ProductProvider value, Widget? child) {
          return ProductsHorizontalList(products: value.products);
        },
      ),
    );
  }
}
