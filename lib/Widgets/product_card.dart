import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sunpower/localization/AppLocal.dart';
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
                  aspectRatio: 1,
                  child: SizedBox(
                    child: productListSnapShot['images'].isEmpty?
                    Image.asset("images/category/emptyimg.png",fit: BoxFit.cover,):
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
                        SizedBox(
                          child: FirebaseAuth.instance.currentUser != null ?
                          Text('${LocalStorageService.instance.user?.role == 1?
                          productListSnapShot['wholesale price'].toString():productListSnapShot['retail price'].toString()}\$',
                            style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold),):
                          Text('${productListSnapShot['retail price'].toString()}\$',
                            style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                        Row(
                          children: [
                            Text(AppLocalizations.of(context).trans("ItemCode"),
                              style: TextStyle(fontSize: 10),
                            ),
                            Container(
                              child: Text(productListSnapShot['itemCode'].toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 10,color: Theme.of(context).primaryColor),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }
}
