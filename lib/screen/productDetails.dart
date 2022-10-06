import 'package:barcode_widget/barcode_widget.dart';
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
  DocumentSnapshot modelSnapshot;
  DocumentSnapshot makeSnapshot;
  DocumentSnapshot productSnapshot;
  List<DocumentSnapshot> makeListSnapShot;
  List<DocumentSnapshot> modelListSnapShot;
  String modelName='';
  String makeName='';
  Future getProducts() async{
     productDetailSnapShot = await FirebaseFirestore.instance
        .collection('products').doc(widget.productID)
        .get();
     setState(() {
       productSnapshot=productDetailSnapShot;
     });
  }
  Future getMake() async{
    productDetailSnapShot = await FirebaseFirestore.instance
        .collection('make').doc(productSnapshot.data()['makeId'].toString())
        .get();
    setState(() {
      makeSnapshot=productDetailSnapShot;
      makeName=makeSnapshot.data()['make'];

    });
  }
  Future getModel() async{
    productDetailSnapShot = await FirebaseFirestore.instance
        .collection('make').doc(productSnapshot.data()['makeId'].toString()).
    collection('models').doc(productSnapshot.data()['modelId'].toString())
        .get();
    setState(() {
      modelSnapshot=productDetailSnapShot;
      modelName=modelSnapshot.data()['mname'];
    });
  }
  getMakeRelated() {
    int i = 0;
    FirebaseFirestore.instance
        .collection('products')
        .where('makeId',isEqualTo: productSnapshot.data()['makeId'])
        //.where('productID',isNotEqualTo: productSnapshot.id)
        .get()
        .then((value) {
      makeListSnapShot = new List<DocumentSnapshot>(value.docs.length);
      value.docs.forEach((element) async {
        setState(() {
          makeListSnapShot[i] = element;
        });
        i++;
      });
    }).whenComplete(() {
      print(makeListSnapShot.length);
    });

  }
  getModelRelated() {
    int i = 0;
    FirebaseFirestore.instance
        .collection('products')
        .where('modelId',isEqualTo: productSnapshot.data()['modelId'])
        .get()
        .then((value) {
      modelListSnapShot = new List<DocumentSnapshot>(value.docs.length);
      value.docs.forEach((element) async {
        setState(() {
          modelListSnapShot[i] = element;
        });
        i++;
      });
    }).whenComplete(() {
      print(modelListSnapShot.length);
    });

  }
  @override
  void initState() {
    getProducts().then((value)
    => getMake().then((value)
    => getModel()).then((value)
    => getMakeRelated()).then((value)
    => getModelRelated()));
    //print(widget.productID+'   Product ID');
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
      body:productSnapshot==null?
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
                             // fit: BoxFit.cover,
                              //fit: BoxFit.contain,
                              imageUrl: productSnapshot.data()['img'].toString(),
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
                              horizontal: 10, vertical: 15),
                          child: Wrap(
                            runSpacing: 15,
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
                                        flex: 2,
                                        child: Container(
                                          // color: Colors.red,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                            children: <Widget>[
                                              SizedBox(height: 10,),
                                              Text(
                                                productSnapshot.data()['name'] ??
                                                    '',
                                               // overflow: TextOverflow.fade,
                                                maxLines: 3,
                                                style: Theme.of(
                                                    context)
                                                    .textTheme
                                                    .headline3
                                                    .merge(TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                  color:Colors.black
                                                )),
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              Row(children: [
                                                Text('Availability:',
                                                  style: TextStyle(
                                                      fontSize: 15,fontWeight: FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                productSnapshot.data()['quantity']==0?
                                                Text('Out of Stock',
                                                  style: TextStyle(
                                                      fontSize: 15,fontWeight: FontWeight.bold,color: Colors.red),
                                                ):
                                                Text('In Stock',
                                                  style: TextStyle(
                                                      fontSize: 15,fontWeight: FontWeight.bold,color: Colors.green),
                                                ),
                                              ],),
                                              SizedBox(
                                                height: 30,
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 20),
                                          child: Column(
                                            children: [
                                              Container(

                                                height: 40,
                                                width: 140,
                                                // color: Colors.red,
                                                child:  Row(
                                                  children: [
                                                    Text(productSnapshot.data()['retail price'],style:
                                                    TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                                    Text(' IQD',style:
                                                    TextStyle(fontWeight: FontWeight.bold,fontSize: 10),),
                                                  ],
                                                )
                                              ),
                                              Container(
                                                  height: 20,
                                                  width: 140,
                                                  // color: Colors.red,
                                                  child:  Row(
                                                    children: [
                                                      Text('35 000',style:
                                                      TextStyle(fontSize: 16,decoration: TextDecoration.lineThrough),),
                                                      Text(' IQD',style:
                                                      TextStyle(fontSize: 8,decoration: TextDecoration.lineThrough),),
                                                    ],
                                                  )
                                              ),


                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),


                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        DefaultTabController(
                                          length: 2, // length of tabs
                                          initialIndex: 0,
                                          child: Container(
                                            // color: Colors.red,
                                            child: TabBar(
                                              indicatorColor: Theme.of(context).accentColor,
                                              indicatorPadding: EdgeInsets.all(0),
                                              labelPadding: EdgeInsets.symmetric(horizontal: 50),
                                              // indicator: UnderlineTabIndicator(
                                              //     borderSide: BorderSide(width: 1.0),
                                              //     insets: EdgeInsets.symmetric(horizontal:10.0)
                                              // ),
                                              //indicatorSize: TabBarIndicatorSize.,//TabBarIndicatorSize(3),
                                              onTap: (index){
                                                setState(() {
                                                  selectedIndex = index;
                                                });
                                              },
                                              isScrollable: true,
                                              tabs: [
                                                Tab(text:  "Specification"),
                                                Tab(text:  "Description"),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    top: BorderSide(
                                                        color: Colors.grey,
                                                        width: 0.5))),
                                            child: Padding(
                                                padding:
                                                const EdgeInsets.all(15.0),
                                                child: getCurrentPage()
                                            ))
                                      ])



                                ],



                              ),


                              SizedBox(
                                height: 190,
                              ),

                              (makeListSnapShot == null || makeListSnapShot.isEmpty)
                                  ? SizedBox()
                                  : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Related Make',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                      SizedBox(height: 15,),
                                      Container(
                              // color: Colors.red,
                               // width: 200,
                                        height: 270,
                                        child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemCount: makeListSnapShot.length,
                                              itemBuilder: (context, i) {
                                                return (makeListSnapShot[i] != null)
                                                    ? InkWell(
                                                  onTap: (){
                                                    Navigator.of(context).push(MaterialPageRoute(
                                                      builder: (context) => ProductDetails( makeListSnapShot[i].id.toString()),
                                                    ));
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(right: 15),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          width: 150,
                                                          height: 150,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.all(
                                                                  Radius.circular(20)
                                                                //                 <--- border radius here
                                                              ),
                                                              border: Border.all(color: Colors.black12,width: 0.6),
                                                              image: DecorationImage(
                                                                // fit: BoxFit.cover,
                                                                  image: NetworkImage(
                                                                      makeListSnapShot[i]['img'].toString()
                                                                  )
                                                              )),
                                                        ),

                                                     Padding(
                                                       padding: const EdgeInsets.only(left: 10,top: 10),
                                                       child: Column(
                                                         //crossAxisAlignment: CrossAxisAlignment.start,
                                                         children: [
                                                           Container(
                                                             width: 150,
                                                             height: 30,
                                                             //color: Colors.grey,
                                                             child: Text(makeListSnapShot[i]['name'],
                                                               style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,), overflow: TextOverflow.ellipsis,),
                                                           ),
                                                         //  SizedBox(height: 10,),
                                                           Text('1,000 IQD',style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.w500),),
                                                           SizedBox(height: 10,),
                                                           Text('1,500 IQD',style: TextStyle(fontSize: 12,color: Colors.black54,fontWeight: FontWeight.w500,decoration: TextDecoration.lineThrough),),
                                                         ],
                                                       ),
                                                     )
                                                      ],
                                                    ),
                                                  ),)
                                                    : SizedBox();
                                              }),
                                      ),
                                    ],
                                  ),
                              SizedBox(
                                height: 300,
                              ),

                              (modelListSnapShot == null || modelListSnapShot.isEmpty)
                                  ? SizedBox()
                                  : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Related Model',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                  SizedBox(height: 15,),
                                  Container(
                                    // color: Colors.red,
                                    // width: 200,
                                    height: 270,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: modelListSnapShot.length,
                                        itemBuilder: (context, i) {
                                          return (modelListSnapShot[i] != null)
                                              ? InkWell(
                                            onTap: (){
                                              Navigator.of(context).push(MaterialPageRoute(
                                                builder: (context) => ProductDetails( modelListSnapShot[i].id.toString()),
                                              ));
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 15),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 150,
                                                    height: 150,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(20)
                                                          //                 <--- border radius here
                                                        ),
                                                        border: Border.all(color: Colors.black12,width: 0.6),
                                                        image: DecorationImage(
                                                          // fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                                modelListSnapShot[i]['img'].toString()
                                                            )
                                                        )),
                                                  ),

                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 10,top: 10),
                                                    child: Column(
                                                      //crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          width: 150,
                                                          height: 30,
                                                          //color: Colors.grey,
                                                          child: Text(modelListSnapShot[i]['name'],
                                                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,), overflow: TextOverflow.ellipsis,),
                                                        ),
                                                        //  SizedBox(height: 10,),
                                                        Text('1,000 IQD',style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.w500),),
                                                        SizedBox(height: 10,),
                                                        Text('1,500 IQD',style: TextStyle(fontSize: 12,color: Colors.black54,fontWeight: FontWeight.w500,decoration: TextDecoration.lineThrough),),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),)
                                              : SizedBox();
                                        }),
                                  ),
                                ],
                              ),
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
                          child:  productSnapshot.data()['quantity']==0?
                               Center(
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
                                                'Add To Cart',
                                                textAlign:
                                                TextAlign.center,
                                                style: TextStyle(
                                                    color:
                                                    Theme.of(context)
                                                        .primaryColor,
                                                    fontSize: 18,
                                                    fontWeight:
                                                    FontWeight.bold),
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
          ),
          // Positioned(
          //   top: 100,
          //   right: 10,
          //   child: stock != 0
          //       ? Text('out of stock',
          //     style: TextStyle(
          //         fontSize: 15,color: Colors.red),
          //   )
          //       : SizedBox(),),
        ],
      ),
    );
  }
  int selectedIndex = 0;
  getCurrentPage(){
    if(selectedIndex == 1){
      return Text(productSnapshot.data()['desc'],style: TextStyle(fontSize: 16,height: 1.3),);

    }else if (selectedIndex == 0){
      return
       Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Row(
             //mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: [
               Expanded(
                 child: Text('Make',
                   maxLines: 3,
                   style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                 ),
               ),
               Expanded(
                 child: Text(makeName.toString(),
                   maxLines: 5,
                   style: TextStyle(fontSize: 15),
                 ),
               )
             ],),
           SizedBox(height: 15,),
           Row(
             //mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: [
               Expanded(
                 child: Text('Model',
                   maxLines: 3,
                   style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                 ),
               ),
               Expanded(
                 child: Text(modelName,
                   maxLines: 5,
                   style: TextStyle(fontSize: 15),
                 ),
               )
             ],),


           SizedBox(height: 15,),
           Row(
             //mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: [
               Expanded(
                 child: Text('Brand',
                   maxLines: 3,
                   style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                 ),
               ),
               Expanded(
                 child: Text(productSnapshot.data()['brand'],
                   maxLines: 5,
                   style: TextStyle(fontSize: 15),
                 ),
               )
             ],),
           SizedBox(height: 15,),
           Row(
             //mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: [
               Expanded(
                 child: Text('Item Code',
                   maxLines: 3,
                   style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                 ),
               ),
               Expanded(
                 child: Text(productSnapshot.data()['itemCode'].toString(),
                   maxLines: 5,
                   style: TextStyle(fontSize: 15),
                 ),
               )
             ],),
           SizedBox(height: 15,),
           Row(
             //mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: [
               Expanded(
                 child: Text('oemCode',
                   maxLines: 3,
                   style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                 ),
               ),
               Expanded(
                 child: Text(productSnapshot.data()['oemCode'].toString(),
                   maxLines: 5,
                   style: TextStyle(fontSize: 15),
                 ),
               )
             ],),
           SizedBox(height: 15,),
           Row(
             //mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: [
               Expanded(
                 child: Text('piecesInBox',
                   maxLines: 3,
                   style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                 ),
               ),
               Expanded(
                 child: Text(productSnapshot.data()['piecesInBox'].toString(),
                   maxLines: 5,
                   style: TextStyle(fontSize: 15),
                 ),
               )
             ],),
           SizedBox(height: 15,),
           Row(
             //mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: [
               Expanded(
                 child: Text('volt',
                   maxLines: 3,
                   style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                 ),
               ),
               Expanded(
                 child: Text(productSnapshot.data()['volt'],
                   maxLines: 5,
                   style: TextStyle(fontSize: 15),
                 ),
               )
             ],),
           SizedBox(height: 35,),
           Container(
             height: 65,
              width: 200,
             child: BarcodeWidget(
               data: productSnapshot.data()['barCode'].toString(),
               barcode: Barcode.code128(escapes: true),
             ),
           ),


       ],);

    }

  }
}
