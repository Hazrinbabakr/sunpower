import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sunpower/screen/productDetails.dart';

import '../localization/AppLocal.dart';
import '../services/local_storage_service.dart';

class ProductCard extends StatefulWidget {
  final product;

  const ProductCard({Key? key, this.product}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFav = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  User user = FirebaseAuth.instance.currentUser!;
  final userCollection = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    NumberFormat formatter = NumberFormat("###,###,###,###");
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductDetails(
              widget.product.id.toString()),
        ));
      },
      child: Container(
        // decoration: BoxDecoration(
        //   // color: Colors.grey[20],
        //   borderRadius: BorderRadius.circular(20),
        //   border: Border.all(color: Colors.black12, width: 1.2),
        // ),
        child: Column(
          children: [
            Expanded(
              child: Container(

                  decoration: BoxDecoration(
                     color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      border: Border.all(color: Colors.grey[200]!)
                  ),
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                        widget.product['images'][0],
                        fit: BoxFit.cover
                    ),
                  )
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 5
              ),
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)
                                .locale
                                .languageCode
                                .toString() ==
                                'ku'
                                ? widget.product['nameK']
                                .toString()
                                .toUpperCase()
                                : AppLocalizations.of(context)
                                .locale
                                .languageCode
                                .toString() ==
                                'ar'
                                ? widget.product['nameA']
                                .toString()
                                .toUpperCase()
                                : widget.product['name']
                                .toString()
                                .toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            '${LocalStorageService.instance.user!.role == 1?
                            widget.product['wholesale price'].toString():widget.product['retail price'].toString()}',
                            style:
                            TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.blue[800]),

                          ),
                        ],
                      ),
                    ),

                    //Icon(Icons.add)


                    //favorite
                    // Container(
                    //     height: 50,
                    //     width: 50,
                    //     child: isFav
                    //         ? InkWell(
                    //       onTap: () {
                    //         setState(() {
                    //           User user = _auth.currentUser;
                    //           userCollection
                    //               .doc(user.uid)
                    //               .collection('favorite')
                    //               .doc(widget.product.id)
                    //               .delete();
                    //           isFav = !isFav;
                    //         });
                    //       },
                    //       child: Icon(
                    //         Icons.favorite,
                    //         size: 30,
                    //         color: Theme.of(context).colorScheme.secondary,
                    //       ),
                    //     )
                    //         : InkWell(
                    //       onTap: () {
                    //         setState(() {
                    //           User user = _auth.currentUser;
                    //           userCollection
                    //               .doc(user.uid)
                    //               .collection('favorite')
                    //               .doc(widget.product.id)
                    //               .set({"productID": widget.product.id});
                    //           isFav = !isFav;
                    //         });
                    //       },
                    //       child: Icon(
                    //         Icons.favorite_border,
                    //         size: 30,
                    //         color: Theme.of(context).colorScheme.secondary,
                    //       ),
                    //     )
                    // ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
