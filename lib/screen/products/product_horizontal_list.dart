import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sunpower/Widgets/product_card.dart';
import 'package:sunpower/screen/productDetails.dart';

class ProductsHorizontalList extends StatelessWidget {
  final List<DocumentSnapshot>? products;

  const ProductsHorizontalList({Key? key, required this.products})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isTab = MediaQuery.of(context).orientation == Orientation.landscape || MediaQuery.of(context).size.width > 460;
    double width = (MediaQuery.of(context).size.width - 68) / (isTab? 4 :2);
    if(products != null && products!.isEmpty){
      return const SizedBox();
    }
    if(products != null){
      return SizedBox(
        height: width / 0.7,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProductDetails( products![index].id.toString()),
                  ));
                },
                child: SizedBox(
                    width: width,
                    child: ProductCard(productListSnapShot: products![index].data(),)),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: 12,
              );
            },
            itemCount: products!.length
        ),
      );
    }

    return SizedBox(
      height: width / 0.7,
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
                width: width,
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
}
