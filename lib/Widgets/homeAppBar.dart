// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sunpower/localization/AppLocal.dart';
import 'package:sunpower/screen/cart_screen.dart';
import 'package:sunpower/screen/search.dart';
import 'package:sunpower/screen/search_by_barcode.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({key}) : super(key: key);

  @override
  _HomeAppBarState createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  //FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).hintColor.withOpacity(0.15),
                offset: Offset(0, 6),
                blurRadius: 20)
          ]),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 60, bottom: 20, left: 10, right: 10),
        child: Center(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  'images/category/logo.png',
                  width: 200,
                  color: Colors.white,
                ),
                FirebaseAuth.instance.currentUser != null
                    ? InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CartScreen(),
                          ));
                        },
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(user?.uid)
                                .collection('cart')
                                .snapshots(),
                            builder: (context, snapshot) {
                              return Stack(
                                children: [
                                  Icon(
                                    Icons.shopping_cart,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  Positioned(
                                      top: 0,
                                      child: snapshot.data?.docs?.length == null
                                          ? CircularProgressIndicator()
                                          : Container(
                                              width: 16,
                                              height: 16,
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15)
                                                    //                 <--- border radius here
                                                    ),
                                                //   border: Border.all(color: Colors.black12,width: 0.6),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  snapshot.data?.docs?.length
                                                          .toString() ??
                                                      '0',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )))
                                ],
                              );
                            }))
                    : SizedBox()
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      //Navigator.of(context).push(SearchModal());
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Search(),
                      ));
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search_rounded,
                                size: 25,
                              ),
                              Text(
                                AppLocalizations.of(context).trans('search'),
                                style: TextStyle(fontSize: 17),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                    onTap: () {
                      SearchByBarcode.openCamera(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      child: Image.asset(
                        "images/category/barcode.png",
                        color: Colors.grey[800],
                        width: 45,
                        height: 40,
                      ),
                    )
                )
              ],
            )
          ],
        )),
      ),
    );
  }
}
