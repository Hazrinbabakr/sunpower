import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sunpower/Widgets/product_card.dart';
import 'package:sunpower/screen/productDetails.dart';

class ProductsHorizontalList extends StatelessWidget {
  final List<DocumentSnapshot>? products;

  const ProductsHorizontalList({Key? key, required this.products})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(products != null){
      double width = (MediaQuery.of(context).size.width - 68) / 2;
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
                    child: ProductCard(productListSnapShot: products![index],)),
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
    return const SizedBox(
      height: 120,
    );

  }
}
