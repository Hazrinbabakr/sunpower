// ignore_for_file: file_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Offers extends StatelessWidget {
  const Offers({ key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [

          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('offers').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                print('Errorrrrr ${snapshot.error}');
                return const Text('Something went wrong with offers');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              return  Container(
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
                        items: snapshot.data.docs.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return
                                // Text('ssss ${i['test1'].toString()}');
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(i['img'].toString())

                                      )),
                                );
                            },
                          );
                        }).toList(),
                      )


                  ),
                ),
              );
            },
          ),

        ],
      ),
    );
  }
}

