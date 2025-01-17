import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sunpower/Widgets/product_card.dart';

import 'productDetails.dart';

class SpecialProductsList extends StatefulWidget {
  final List products;
  final String title;
  const SpecialProductsList({Key? key, required this.products, required this.title}) : super(key: key);

  @override
  State<SpecialProductsList> createState() => _SpecialProductsListState();
}

class _SpecialProductsListState extends State<SpecialProductsList> {
  @override
  Widget build(BuildContext context) {
    bool isTab = MediaQuery.of(context).orientation == Orientation.landscape || MediaQuery.of(context).size.width > 460;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GridView.builder(
        padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isTab ? 4 : 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 8,
            childAspectRatio: 0.8
        ),
        itemCount: widget.products.length,
        itemBuilder: (context, i) {
          return InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductDetails( widget.products[i].id.toString()),
              ));
            },
            child: ProductCard(
                productListSnapShot:widget.products[i].data()
            ),
          );

        },
      ),
    );
  }
}
