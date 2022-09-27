import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onlineshopping/Widgets/BackArrowWidget.dart';
import 'package:onlineshopping/Widgets/empty.dart';

class ProductDetails extends StatefulWidget {
  final String productID;
  const ProductDetails(this.productID, {Key key}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  DocumentSnapshot productDetailSnapShot;
  DocumentSnapshot snapshot;
  Future getProducts() async{
     productDetailSnapShot = await FirebaseFirestore.instance
        .collection('products').doc(widget.productID)
        .get();
     setState(() {
       snapshot=productDetailSnapShot;
     });
  }
  @override
  void initState() {
    getProducts();
    print(widget.productID+'   Product ID');
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text('Product details'),
        leading: BackArrowWidget(),
      ),
      body:snapshot==null?
      EmptyWidget():
     //Text(snapshot.data()['name']),

      Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(

            margin: EdgeInsets.only(bottom: 125),
            padding: EdgeInsets.only(bottom: 15),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CustomScrollView(
                  primary: true,
                  shrinkWrap: false,
                  slivers: <Widget>[
                    SliverAppBar(
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.vertical(
                      //     bottom: Radius.circular(35),
                      //   ),
                      // ),
                      backgroundColor: Theme.of(context)
                          .primaryColor
                          .withOpacity(0.9),
                      expandedHeight: 350,
                      floating: false,
                      pinned: true,
                      snap: false,
                      elevation: 0,
                      automaticallyImplyLeading: false,

                      flexibleSpace:  FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        background: GestureDetector(
                          onTap: () {

                          },
                          child: Hero(
                            tag: 'testt',
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              //fit: BoxFit.contain,
                              imageUrl: snapshot.data()['img'].toString(),
                              placeholder: (context, url) =>
                                  Image.asset(
                                    'images/category/loadingimg.jpeg',
                                    fit: BoxFit.cover,
                                  ),
                              errorWidget:
                                  (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                     // bottom:  PreferredSize(child: Text('tat')),


                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        decoration: BoxDecoration(
                          //color: Colors.pinkAccent,
                          color: Colors.white,
                          // borderRadius: BorderRadius.only(
                          //   topLeft: Radius.circular(20),
                          //   topRight: Radius.circular(20)
                          // )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 15),
                          child: Wrap(
                            runSpacing: 8,
                            children: [
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: const EdgeInsets
                                              .symmetric(
                                              horizontal: 30),
                                          child: Container(
                                            // color: Colors.red,
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: <Widget>[
                                                Text(
                                                 'name' ??
                                                      '',
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                  maxLines: 3,
                                                  style: Theme.of(
                                                      context)
                                                      .textTheme
                                                      .headline3
                                                      .merge(TextStyle(
                                                    fontSize: 23,
                                                    //color: Color(0xff828282)
                                                  )),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text('112',
                                                  style: Theme.of(
                                                      context)
                                                      .textTheme
                                                      .headline5
                                                      .merge(TextStyle(
                                                      fontSize:
                                                      16)),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                stock == 0
                                                    ? Text('out of stock',
                                                  style: Theme.of(
                                                      context)
                                                      .textTheme
                                                      .subtitle2
                                                      .merge(TextStyle(
                                                      color: Colors
                                                          .red)),
                                                )
                                                    : SizedBox()
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Container(
                                          // decoration: BoxDecoration(
                                          //   color: Theme.of(context)
                                          //       .primaryColor,
                                          //   borderRadius:
                                          //   BorderRadius.circular(
                                          //       5),
                                          //   boxShadow: [
                                          //     BoxShadow(
                                          //       color: Colors.grey
                                          //           .withOpacity(0.5),
                                          //       spreadRadius: 2,
                                          //       blurRadius: 8,
                                          //       //offset: Offset(1, 0),
                                          //     ),
                                          //   ],
                                          // ),
                                          height: 40,
                                          width: 140,
                                          // color: Colors.red,
                                          child:  Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(child: Row(
                                              children: [
                                                Text('120,000 ',style:
                                                TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                                                Text('IQD',style:
                                                TextStyle(fontWeight: FontWeight.bold,fontSize: 13),),
                                              ],
                                            )),
                                          )
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: const EdgeInsets
                                              .symmetric(
                                              horizontal: 30),
                                          child: Row(
                                            children: [
                                              Text('p122'),
                                              SizedBox(width: 14),
                                            ],
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                  Text('discount price'),
                                  SizedBox(
                                    height: 50,
                                  ),

                                ],
                              ),


                              Text('related product'),
                              SizedBox(
                                height: 300,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),

          Positioned(
            bottom: 0,
            child: Container(
              height: 160,
              padding:
              EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color:  Colors.white
              ),
              child: Column(
                children: [

                  //countnumber

                  Padding(
                    padding: const EdgeInsets.only(top:15,left: 100,bottom: 15),
                    child: Row(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor,
                              borderRadius:
                              BorderRadius.circular(
                                  10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.4),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  //offset: Offset(1, 0),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10),
                            height: 40,
                            width: 40,
                            // color: Colors.red,
                            child:  Icon(
                              Icons.add,
                              size: 25,
                              color: Theme.of(context).accentColor,
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(width: 2, color: Colors.red[900].withOpacity(0.5),),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: Colors.white,

                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.4),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    //offset: Offset(1, 0),
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10),
                              height: 40,
                              width: 40,
                              // color: Colors.red,
                              child:  Center(child:
                              Text('3',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),))
                          ),
                        ),
                        Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor,
                              borderRadius:
                              BorderRadius.circular(
                                  10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.4),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  //offset: Offset(1, 0),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10),
                            height: 40,
                            width: 40,
                            // color: Colors.red,
                            child:  Icon(
                              Icons.remove,
                              size: 25,
                              color: Theme.of(context).accentColor,
                            )
                        ),
                      ],
                    ),
                  ),

                  Row(
                    children: [
                      // addtofav
                      Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .primaryColor,
                            borderRadius:
                            BorderRadius.circular(
                                10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.4),
                                spreadRadius: 1,
                                blurRadius: 7,
                                //offset: Offset(1, 0),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10),
                          height: 50,
                          width: 50,
                          // color: Colors.red,
                          child:  Icon(
                            Icons.favorite,
                            size: 30,
                            color: Theme.of(context).accentColor,
                          )
                      ),
                      // addtocart
                      SizedBox(
                          width: MediaQuery.of(context).size.width - 40,
                          child: stock == 0
                              ? Center(
                            child: Stack(
                              fit: StackFit.loose,
                              alignment: AlignmentDirectional.centerEnd,
                              children: <Widget>[
                                SizedBox(
                                  width:
                                  MediaQuery.of(context).size.width -
                                      110,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 20),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[400],
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    child: InkWell(
                                      onTap: () {
                                        print('out of stock');
                                        // showErrorToast(context,
                                        //     S.of(context).out_of_stock);
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        padding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 25),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                'Add to cart',
                                                textAlign:
                                                TextAlign.center,
                                                style: TextStyle(
                                                    color:
                                                    Theme.of(context)
                                                        .primaryColor,
                                                    fontSize: 17,
                                                    fontWeight:
                                                    FontWeight.w600),
                                              ),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              Icon(
                                                Icons
                                                    .shopping_cart_outlined,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  // child: Helper.getPrice(
                                  //   _con.total,
                                  //   context,
                                  //   style: Theme.of(context)
                                  //       .textTheme
                                  //       .headline4
                                  //       .merge(TextStyle(
                                  //           color: Theme.of(context)
                                  //               .primaryColor)),
                                  // ),
                                ),
                              ],
                            ),
                          )
                              : Stack(
                                fit: StackFit.loose,
                                alignment: AlignmentDirectional.bottomCenter,
                                children: <Widget>[
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width - 110,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20),
                                      decoration: BoxDecoration(
                                          color: Colors.deepOrange[900],
                                          borderRadius:
                                          BorderRadius.circular(10)),
                                      child: InkWell(
                                        onTap: () {
                                          print('Add to cart');
                                          // showErrorToast(context,
                                          //     S.of(context).out_of_stock);
                                        },
                                        child: Container(
                                          padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 25),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text(
                                                  'Add to cart',
                                                  textAlign:
                                                  TextAlign.center,
                                                  style: TextStyle(
                                                      color:
                                                      Theme.of(context)
                                                          .primaryColor,
                                                      fontSize: 17,
                                                      fontWeight:
                                                      FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Icon(
                                                  Icons
                                                      .shopping_cart_outlined,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  int stock=1;
}
