import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunpower/app/AppColors.dart';
import 'package:sunpower/localization/AppLocal.dart';
import 'package:sunpower/screen/Special_produt_list.dart';
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(value.products != null && value.products!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(AppLocalizations.of(context).trans('SpecialOffers').toUpperCase(),
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return SpecialProductsList(products: value.products!, title: AppLocalizations.of(context).trans('SpecialOffers').toUpperCase(),);
                        }));

                      },
                      child: Text(
                        AppLocalizations.of(context).trans("ShowAll"),
                        style: TextStyle(
                            fontSize: 12,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              if(value.products != null && value.products!.isNotEmpty)
              SizedBox(height: 12,),
              ProductsHorizontalList(products: value.products)
            ],
          );
        },
      ),
    );
  }
}
