import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sunpower/Widgets/product_card.dart';
import 'package:sunpower/screen/productDetails.dart';
import 'BackArrowWidget.dart';
import 'empty.dart';

class BrandItems extends StatefulWidget {
  final String brandID;
  final brandName;
  BrandItems(this.brandID, this.brandName, {Key? key}) : super(key: key);

  @override
  _BrandItemsState createState() => _BrandItemsState();
}

class _BrandItemsState extends State<BrandItems> {
  List<DocumentSnapshot>? productListSnapShot ;

  getProducts() {
    //int i = 0;
    FirebaseFirestore.instance
        .collection('products')
        .where('brand',isEqualTo:widget.brandName)
        .orderBy("itemCode", descending: false)
        .get()
        .then((value) {
          productListSnapShot = [];
          productListSnapShot!.addAll(value.docs);
          setState(() {

          });
    });
  }

  @override
  void initState() {
    getProducts();
    // getProducts();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: BackArrowWidget(),
          title: Text(widget.brandName,style: TextStyle(color:Colors.black87),), elevation: 0,),
          body: Builder(
            builder: (BuildContext context) {
              if (productListSnapShot == null){
                return Center(child: CircularProgressIndicator());
              }
              if(productListSnapShot!.isEmpty){
                return const SizedBox();
              }
              bool isTab = MediaQuery.of(context).orientation == Orientation.landscape || MediaQuery.of(context).size.width > 460;
              return GridView.builder(
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
                itemCount: productListSnapShot!.length,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProductDetails( productListSnapShot![i].id.toString()),
                      ));
                    },
                    child: ProductCard(
                        productListSnapShot:productListSnapShot![i].data()
                    ),
                  );

                },
              );
              /*return SingleChildScrollView(
                  child: Container(
                    height:700,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: productListSnapShot!.length,
                        itemBuilder: (context, i) {
                          DocumentSnapshot data=  productListSnapShot!.elementAt(i);
                          return productListSnapShot![i]['brand']==widget.brandName?
                            ProductCard(
                              product: data,
                            ):SizedBox();
                        }
                        ),
                  )
              );*/
            },
          )
      );
  }
}
