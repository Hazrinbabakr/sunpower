import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sunpower/localization/AppLocal.dart';
import 'package:sunpower/services/brands_service.dart';
import 'package:sunpower/services/local_storage_service.dart';

class ProductCard extends StatelessWidget {
  final productListSnapShot;
  const ProductCard({Key? key, this.productListSnapShot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.black12,
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[200]!,
                  spreadRadius: 1,
                  blurRadius: 10
              )
            ]
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(1),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: AspectRatio(
                  aspectRatio: 1.6,
                  child: SizedBox(
                    child: productListSnapShot['images'].isEmpty?
                    Image.asset("images/category/emptyimg.png",fit: BoxFit.contain,):
                    CachedNetworkImage(imageUrl:productListSnapShot['images'][0].toString(),fit: BoxFit.cover,),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context).locale.languageCode.toString()=='ku'?
                      productListSnapShot['nameK'].toString().toUpperCase():
                      AppLocalizations.of(context).locale.languageCode.toString()=='ar'?
                      productListSnapShot['nameA'].toString().toUpperCase():
                      productListSnapShot['name'].toString().toUpperCase(),
                      style: TextStyle(fontSize: 11,),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text('${_getPrice(productListSnapShot)}\$', style: TextStyle(fontSize: 12,color: Colors.blue,fontWeight: FontWeight.bold),),
                              if(_getOldPrice(productListSnapShot).isNotEmpty && _getOldPrice(productListSnapShot) != '0' && _getOldPrice(productListSnapShot) != '0.0')
                                Padding(
                                  padding: EdgeInsetsDirectional.only(
                                    start: 4
                                  ),
                                  child: Text(
                                    '${_getOldPrice(productListSnapShot)}\$',
                                    style: TextStyle(fontSize: 12,color: Colors.red,fontWeight: FontWeight.bold,decoration: TextDecoration.lineThrough),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 35,
                          child: BrandsService.getBrandImage(productListSnapShot['brand']).isNotEmpty?
                          CachedNetworkImage(imageUrl: BrandsService.getBrandImage(productListSnapShot['brand'])):null,
                        ),
                      ],
                    ),
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context).trans("ItemCode"),
                                  style: TextStyle(fontSize: 10),
                                ),
                                const SizedBox(width: 8,),
                                Flexible(
                                  child: Text(productListSnapShot['itemCode'].toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 11,color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }

  String _getOldPrice(dynamic product){
    if(FirebaseAuth.instance.currentUser != null){
      if(LocalStorageService.instance.user?.role == 1){
        return product['old wholesale price']?.toString()??'';
      }
      else {
        return product['old price']?.toString()??"";
      }
    }
    return product['old price']?.toString()??"";

  }

  String _getPrice(dynamic product){
    if(FirebaseAuth.instance.currentUser != null){
      if(LocalStorageService.instance.user?.role == 1){
        return product['wholesale price']?.toString()??'';
      }
      else {
        return product['retail price']?.toString()??"";
      }
    }
    return product['retail price']?.toString()??"";
  }
}
