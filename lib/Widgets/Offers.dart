// ignore_for_file: file_names

// import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Offers extends StatefulWidget {
  final String offerName;
  const Offers(this.offerName, {Key? key}) : super(key: key);

  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  List<String> imgList=[];
  DocumentSnapshot? offerSnapShot;
  Future getProducts() async{
    offerSnapShot = await FirebaseFirestore.instance
        .collection('Admin').doc('admindoc')
        .get();
    setState(() {
      offerSnapShot![widget.offerName].forEach((element){
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
    return imgList.isEmpty? const SizedBox():
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 160.0,
        child:
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child:CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 1,
                  height:       160.0,
                  autoPlay:     true,
                ),
                items: imgList.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return
                        Container(
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
                            // placeholder: (context, url) => Image.asset(
                            //   'images/category/loading.jpeg',
                            //   fit: BoxFit.cover,
                            //   width: double.infinity,
                            //   height: 120,
                            // ),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        );
                    },
                  );
                }).toList(),
              )

          ),
        ),
      ),
    );
  }
}

