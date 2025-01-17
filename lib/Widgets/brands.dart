
// ignore_for_file: file_names, prefer_const_constructors, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sunpower/services/brands_service.dart';


import '../localization/AppLocal.dart';
import 'brandItems.dart';


class Brands extends StatefulWidget {
  const Brands({ key}) : super(key: key);

  @override
  _BrandsState createState() => _BrandsState();
}

class _BrandsState extends State<Brands> {
  List<DocumentSnapshot>? brandsSnapshot;
  getBrands() {
    FirebaseFirestore.instance
        .collection('brands')
        .where('img',isNull: false)
        .get()
        .then((value) {
          brandsSnapshot = [];
          brandsSnapshot!.addAll(value.docs.where((element) => element['img'].isNotEmpty));
          //BrandsService.localInit(brandsSnapshot!);
          setState(() {

          });
        });
  }
  @override
  void initState() {
    super.initState();
    getBrands();
  }
  @override
  Widget build(BuildContext context) {
    if(brandsSnapshot == null || brandsSnapshot!.isEmpty){
      return SizedBox(
        height: 100,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade600,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(15),
                  ),

                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: 12,
              );
            },
            itemCount: 3
        ),
      );
    }
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: 16,
        ),
        shrinkWrap: true,
        itemCount: brandsSnapshot!.length,
        itemBuilder: (context, i) {
          DocumentSnapshot data= brandsSnapshot!.elementAt(i);
          if((data.data() as Map)['img'] == null || (data.data() as Map)['img'] == ''){
            return const SizedBox();
          }
          return InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BrandItems(
                    data.id.toString(),
                    AppLocalizations.of(context).locale.languageCode.toString()=='ku'?
                    data['nameK'].toString():
                    AppLocalizations.of(context).locale.languageCode.toString()=='ar'?
                    data['nameA'].toString():
                    data['name'].toString(),
                  ),
                ));

              },
              child: Container(
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: Colors.grey.shade200
                    )
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: (data.data() as Map)['img'],
                    fit: BoxFit.contain,
                  ),
                ),
              )
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: 12,);
        },),
    );
  }
}
// comment(){
//   Padding(
//     padding: const EdgeInsets.only(right: 15,left: 10),
//     child:
//     Column(
//       children: [
//
//         // Container(
//         //   height: 80,
//         //   width: 80,
//         //   decoration: BoxDecoration(
//         //       color: Colors.white,
//         //       borderRadius: BorderRadius.all(
//         //           Radius.circular(15)
//         //         //                 <--- border radius here
//         //       ),
//         //       border: Border.all(color: Colors.black12,width: 0.6),
//         //       image: DecorationImage(
//         //           fit: BoxFit.cover,
//         //           image: NetworkImage(
//         //               brandsSnapshot![i]['img'].toString()))),
//         // ),
//         SizedBox(height: 7,),
//         Container(
//           padding: EdgeInsets.all(10),
//           decoration:BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.red.withOpacity(0.2),
//                 spreadRadius: 2,
//                 blurRadius: 8,
//                 offset: Offset(0, 3),
//               ),
//             ],
//           ),
//           child: Text(
//             AppLocalizations.of(context).locale.languageCode.toString()=='ku'? brandsSnapshot![i]['nameK']:
//             AppLocalizations.of(context).locale.languageCode.toString()=='ar'?
//             brandsSnapshot![i]['nameA']:
//             brandsSnapshot![i]['name'],
//             style: TextStyle(fontWeight: FontWeight.w600,),
//           ),
//         )
//       ],
//     ),
//   );
// }