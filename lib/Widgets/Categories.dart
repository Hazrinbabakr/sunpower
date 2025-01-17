// ignore_for_file: file_names, prefer_const_constructors, avoid_print

import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sunpower/app/AppColors.dart';
import 'package:sunpower/localization/AppLocal.dart';
import 'package:sunpower/screen/productList.dart';

class CategoriesWidget extends StatefulWidget {
  final VoidCallback callback;
  const CategoriesWidget({key, required this.callback}) : super(key: key);

  @override
  _CategoriesWidgetState createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('categories').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text(AppLocalizations.of(context).trans('wrong'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)
                          .trans("categories")
                          .toUpperCase(),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 4),
                      child: InkWell(
                          onTap: () {
                            widget.callback();
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => AllCategory(snapshot.data!.docs)),
                            // );
                          },
                          child: Text(
                            AppLocalizations.of(context).trans("ShowAll"),
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: height * 0.15,
                width: double.infinity,
                child: GridView.count(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  crossAxisCount: 2,
                  children: List.generate(10, (index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade600,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          );
        }
        return Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)
                        .trans("categories")
                        .toUpperCase(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 4),
                    child: InkWell(
                        onTap: () {
                          widget.callback();
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => AllCategory(snapshot.data!.docs)),
                          // );
                        },
                        child: Text(
                          AppLocalizations.of(context).trans("ShowAll"),
                          style: TextStyle(
                              fontSize: 12,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: height * 0.25,
              // height: 200,
              child: GridView.count(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.2,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                crossAxisCount: 2,
                children: List.generate(snapshot.data!.docs.length, (index) {
                  DocumentSnapshot data = snapshot.data!.docs.elementAt(index);
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProductsList(
                          data.id.toString(),
                          AppLocalizations.of(context)
                                      .locale
                                      .languageCode
                                      .toString() ==
                                  'ku'
                              ? data['nameK'].toString()
                              : AppLocalizations.of(context)
                                          .locale
                                          .languageCode
                                          .toString() ==
                                      'ar'
                                  ? data['nameA'].toString()
                                  : data['name'].toString(),
                        ),
                      ));
                    },
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: Colors.black12, width: 0.6),
                                image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: CachedNetworkImageProvider(
                                        data['img'].toString()))),
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          AppLocalizations.of(context)
                                      .locale
                                      .languageCode
                                      .toString() ==
                                  'ku'
                              ? data['nameK'].toString()
                              : AppLocalizations.of(context)
                                          .locale
                                          .languageCode
                                          .toString() ==
                                      'ar'
                                  ? data['nameA'].toString()
                                  : data['name'].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        );
      },
    );
  }
}
