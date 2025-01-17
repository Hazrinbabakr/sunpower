// ignore_for_file: file_names

// import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sunpower/screen/productDetails.dart';

class Offers extends StatefulWidget {
  final String offerName;
  const Offers(this.offerName, {Key? key}) : super(key: key);

  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  List<String> imgList = [];
  DocumentSnapshot? offerSnapShot;
  Future getProducts() async {
    offerSnapShot = await FirebaseFirestore.instance
        .collection('Admin')
        .doc('admindoc')
        .get();
    setState(() {
      offerSnapShot![widget.offerName].forEach((element) {
        imgList.add(element);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return imgList.isEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade600,
              highlightColor: Colors.grey.shade100,
              child: Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: height * 0.2,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      viewportFraction: 1,
                      height: height * 0.2,
                      autoPlay: true,
                    ),
                    items: imgList.map((i) {
                      return GestureDetector(
                        onTap: () async {
                          Uri uri = Uri.parse(i);
                          final pathSegment = uri.pathSegments.last;
                          final decodedPath = Uri.decodeComponent(pathSegment);
                          final itemCode = offerSnapShot!['productsMapping'][decodedPath];
                          if ( itemCode != null){

                            var result = await FirebaseFirestore.instance.collection("products")
                                .where("itemCode",isEqualTo: itemCode)
                                .get();

                            if(result.size != 0){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                return ProductDetails(result.docs.first.id);
                              }));
                            }

                          }

                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(i.toString())
                              )
                          ),
                          child: CachedNetworkImage(
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            imageUrl: i,
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        ),
                      );
                    }).toList(),
                  )),
            ),
          );
  }
}
