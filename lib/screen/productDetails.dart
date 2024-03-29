import 'package:barcode_widget/barcode_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sunpower/Widgets/BackArrowWidget.dart';
import 'package:sunpower/Widgets/empty.dart';
import 'package:sunpower/Widgets/photo_gellary.dart';
import 'package:sunpower/localization/AppLocal.dart';
import 'package:sunpower/screen/productDetailPDF.dart';
import 'package:sunpower/services/local_storage_service.dart';

import 'auth/normal_user_login/login_main_page.dart';

class ProductDetails extends StatefulWidget {
  final String productID;
  const ProductDetails(this.productID, {Key? key}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  DocumentSnapshot? productDetailSnapShot;
  DocumentSnapshot? modelSnapshot;
  DocumentSnapshot? makeSnapshot;
  DocumentSnapshot? productSnapshot;
  List<DocumentSnapshot>? makeListSnapShot;
  List<DocumentSnapshot>? modelListSnapShot;
  String modelName='';
  String makeName='';
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  List<String> imgList=[];

  int _current = 0;
  TextEditingController quantityController = TextEditingController(text: "1");

  @override
  dispose(){
    quantityController.dispose();
    super.dispose();
  }

  int inPrice= 0;
  final userCollection = FirebaseFirestore.instance.collection('users');

  Future getProducts() async{
    productDetailSnapShot = await FirebaseFirestore.instance
        .collection('products').doc(widget.productID)
        .get();
    if(mounted) {
      setState(() {
        productSnapshot = productDetailSnapShot;
        // inPrice= int.parse(productSnapshot.data()['retail price']);
        // //print(inPrice.toString());
        ////print('${productDetailSnapShot.data()['images'].toString()} imgggg');
        productDetailSnapShot!['images'].forEach((element) {
          imgList.add(element);
        });
        // imgList.add(productDetailSnapShot.data()['images'].toString());
        // //print('${productDetailSnapShot.data()['images'].length.toString()} imgggg');

      });
    }
  }
  Future getMake() async{

    productDetailSnapShot = await FirebaseFirestore.instance
        .collection('make').doc(productSnapshot!['makeId'].toString())
        .get();
    if(mounted) {
      setState(() {
        makeSnapshot = productDetailSnapShot;
        //makeName=
        makeName =
        AppLocalizations
            .of(context)
            .locale
            .languageCode
            .toString() == 'ku' ?
        makeSnapshot!['makeK'] :
        AppLocalizations
            .of(context)
            .locale
            .languageCode
            .toString() == 'ar' ?
        makeSnapshot!['makeA'] :
        makeSnapshot!['make'];
        print('testtttt');
        print(modelName.toString());
      });
    }
  }
  Future getModel() async{
    productDetailSnapShot = await FirebaseFirestore.instance
        .collection('make').doc(productSnapshot!['makeId'].toString()).
    collection('models').doc(productSnapshot!['modelId'].toString())
        .get();
    if(mounted) {
      setState(() {
        modelSnapshot = productDetailSnapShot;
        modelName =
        AppLocalizations
            .of(context)
            .locale
            .languageCode
            .toString() == 'ku' ?
        modelSnapshot!['mnameK'] :
        AppLocalizations
            .of(context)
            .locale
            .languageCode
            .toString() == 'ar' ?
        modelSnapshot!['mnameA'] :
        modelSnapshot!['mname'];
      });
    }
  }
  getMakeRelated() {
    int i = 0;
    FirebaseFirestore.instance
        .collection('products')
        .where('makeId',isEqualTo: productSnapshot!['makeId'])
    //.where('productID',isNotEqualTo: productSnapshot.id)
        .get()
        .then((value) {
      makeListSnapShot = [];
      makeListSnapShot!.addAll(value.docs);
      if(mounted) {
        setState(() {});
      }

    }).whenComplete(() {
    });

  }
  getModelRelated() {
    int i = 0;
    FirebaseFirestore.instance
        .collection('products')
        .where('modelId',isEqualTo: productSnapshot!['modelId'])
        .get()
        .then((value) {
      modelListSnapShot= [];
      modelListSnapShot!.addAll(value.docs);
      if(mounted) {
        setState(() {});
      }
    });

  }
  @override
  void initState() {
    getProducts().then((value)
    => getMake().then((value)
    => getModel()).then((value)
    => getMakeRelated()).then((value)
    => getModelRelated()));
    if(  FirebaseAuth.instance.currentUser != null ){
      if(mounted) {
        setState(() {
          getFavList();
        });
      }
    }

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(  AppLocalizations.of(context).trans("ProductDetails"),style: TextStyle(color: Colors.black87),),
            leading: BackArrowWidget(),
          ),
          body:

          Builder(
              builder: (BuildContext context){
                return  productSnapshot==null?
                EmptyWidget():
                //Text(snapshot['name']),
                Stack(
                  fit: StackFit.expand,
                  children: <Widget>[

                    Container(

                      margin: EdgeInsets.only(bottom: 125),
                      padding: EdgeInsets.only(bottom: 15),
                      child: CustomScrollView(
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
                            //size
                            expandedHeight: 280,
                            floating: false,
                            pinned: true,
                            snap: false,
                            elevation: 0,
                            automaticallyImplyLeading: false,
                            flexibleSpace:
                            FlexibleSpaceBar(
                              background: GestureDetector(
                                onTap: () {},
                                child: Hero(
                                  tag: 'testt',
                                  child: imgList == null
                                      ? Center(
                                      child: CircularProgressIndicator())
                                      : Column(
                                    children: [
                                      SizedBox(
                                        height: 0,
                                      ),
                                      ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          child: Stack(
                                            children: [
                                              CarouselSlider(
                                                options: CarouselOptions(
                                                    viewportFraction: 1,
                                                    autoPlay: false,
                                                    onPageChanged:
                                                        (index, reason) {
                                                      setState(() {
                                                        _current = index;
                                                      });
                                                    }),
                                                items: imgList.map((i) {
                                                  return GestureDetector(
                                                    onTap: (){
                                                      int ind = 0;
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  PhotosGalleryPage(
                                                                    initialPage: 0,
                                                                    galleryItems: [
                                                                      GalleryItem(
                                                                          id: widget.productID
                                                                              +
                                                                              "_" +
                                                                              (ind++)
                                                                                  .toString(),
                                                                          image: i)
                                                                    ],
                                                                  )
                                                          )
                                                      );
                                                    },
                                                    child: SizedBox(
                                                        width: double.infinity,
                                                        child:
                                                        Image.network(
                                                          i.toString(),
                                                          fit: BoxFit.cover,
                                                        )),
                                                  );
                                                }).toList(),
                                              ),
                                            ],
                                          )),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          for (int i = 0;
                                          i < imgList.length;
                                          i++)
                                            Center(
                                              child: Container(
                                                height: 8,
                                                width: 8,
                                                margin: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: _current == i
                                                      ? Theme.of(context)
                                                      .colorScheme.secondary
                                                      : Theme.of(context)
                                                      .colorScheme.secondary
                                                      .withOpacity(
                                                      0.2),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            )
                                        ],
                                      ),
                                    ],
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

                                                      AppLocalizations.of(context).locale.languageCode.toString()=='ku'?
                                                      productSnapshot!['nameK'] ?? '':
                                                      AppLocalizations.of(context).locale.languageCode.toString()=='ar'?
                                                      productSnapshot!['nameA'] ?? '':
                                                      productSnapshot!['name'] ?? '',

                                                      // overflow: TextOverflow.fade,
                                                      maxLines: 3,
                                                      style: Theme.of(
                                                          context)
                                                          .textTheme
                                                          .headline3!
                                                          .merge(TextStyle(
                                                          fontSize: 22,
                                                          fontWeight: FontWeight.bold,
                                                          color:Colors.black
                                                      )),
                                                    ),
                                                    SizedBox(height: 5,),
                                                    Row(
                                                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: [
                                                        Text( AppLocalizations.of(context).trans("ItemCode"),
                                                          maxLines: 3,
                                                          style: TextStyle(fontSize: 14),
                                                        ),
                                                        SizedBox(width: 10,),
                                                        Text(productSnapshot!['itemCode'].toString(),
                                                          maxLines: 5,
                                                          style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                                        )
                                                      ],),
                                                    SizedBox(
                                                      height: 30,
                                                    ),
                                                    Row(children: [
                                                      Text(AppLocalizations.of(context).trans("Availability"),
                                                        style: TextStyle(
                                                            fontSize: 15,fontWeight: FontWeight.bold),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      productSnapshot!['quantity']==0 ||productSnapshot!['quantity']<0 ||productSnapshot!['quantity']< quantity?
                                                      Text(  AppLocalizations.of(context).trans("OutofStock"),

                                                        style: TextStyle(
                                                            fontSize: 15,fontWeight: FontWeight.bold,color: Colors.red),
                                                      ):
                                                      Text( AppLocalizations.of(context).trans("InStock"),
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
                                                padding: const EdgeInsets.only(left: 20,top: 7),
                                                child: Column(
                                                  children: [
                                                    Container(

                                                        height: 40,
                                                        width: 140,
                                                        // color: Colors.red,
                                                        child:  Row(
                                                          children: [
                                                            FirebaseAuth.instance.currentUser != null ?
                                                            Text(

                                                              '${LocalStorageService.instance.user!.role == 1?
                                                            productSnapshot!['wholesale price'].toString():productSnapshot!['retail price'].toString()}',
                                                              style:
                                                              TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color: Colors.blue[800]),

                                                            ):
                                                            Text('${productSnapshot!['retail price'].toString()}',
                                                              style:
                                                              TextStyle(fontWeight: FontWeight.bold,fontSize:22,color: Colors.blue[800]),),
                                                            Text('\$',style:
                                                            TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.blue[800]),),
                                                          ],
                                                        )
                                                    ),
                                                    Container(
                                                        height: 20,
                                                        width: 140,
                                                        // color: Colors.red,
                                                        child:  Row(
                                                          children: [
                                                            Text( productSnapshot!['old price'].toString()=='0'?'':'${productSnapshot!['old price'].toString()}',style:
                                                            TextStyle(fontSize: 16,decoration: TextDecoration.lineThrough,color: Colors.red),),
                                                            Text(  productSnapshot!['old price'].toString()=='0'?'':'\$',style:
                                                            TextStyle(fontSize: 14,decoration: TextDecoration.lineThrough,color: Colors.red),),
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
                                                    indicatorColor: Theme.of(context).colorScheme.secondary,
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
                                                      Tab(text:
                                                      AppLocalizations.of(context).trans("Specification"),
                                                      ),
                                                      Tab(text:
                                                      AppLocalizations.of(context).trans("Description"),
                                                      ),
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

                                    (makeListSnapShot == null || makeListSnapShot!.isEmpty)
                                        ? SizedBox()
                                        : Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(makeListSnapShot!.length >1 ?  AppLocalizations.of(context).trans("RelatedMake"):'',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                        SizedBox(height: 15,),
                                        Container(
                                          // color: Colors.red,
                                          // width: 200,
                                          height: 270,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemCount: makeListSnapShot!.length,
                                              itemBuilder: (context, i) {
                                                return (makeListSnapShot![i] != null && makeListSnapShot![i]['name'] !=  productSnapshot!['name'] )
                                                    ? InkWell(
                                                  onTap: (){
                                                    Navigator.of(context).push(MaterialPageRoute(
                                                      builder: (context) => ProductDetails( makeListSnapShot![i].id.toString()),
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
                                                                      makeListSnapShot![i]['images'][0].toString()
                                                                  )
                                                              )),
                                                        ),

                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Container(
                                                              width: 150,
                                                              height: 30,
                                                              //color: Colors.grey,
                                                              child: Center(
                                                                child: Text(makeListSnapShot![i]['name'],
                                                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,), overflow: TextOverflow.ellipsis,),
                                                              ),
                                                            ),
                                                            //  SizedBox(height: 10,),
                                                            FirebaseAuth.instance.currentUser != null ?
                                                            Text('${LocalStorageService.instance.user!.role == 1? makeListSnapShot![i]['wholesale price'].toString():makeListSnapShot![i]['retail price'].toString()}\$',
                                                              style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.w500),):
                                                            Text('${makeListSnapShot![i]['retail price'].toString()}\$',
                                                              style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.w500),),
                                                            SizedBox(height: 10,),
                                                            FirebaseAuth.instance.currentUser != null ?
                                                            Text( makeListSnapShot![i]['old price'].toString()=='0'?'':'${makeListSnapShot![i]['old price'].toString()}\$',style:
                                                            TextStyle(fontSize: 18,color: Colors.black54,fontWeight: FontWeight.w500,decoration: TextDecoration.lineThrough),):
                                                                SizedBox()

                                                          ],
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

                                    (modelListSnapShot == null || modelListSnapShot!.isEmpty)
                                        ? SizedBox()
                                        : Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(modelListSnapShot!.length >1 ?  AppLocalizations.of(context).trans("RelatedModel"):'',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                        SizedBox(height: 15,),
                                        Container(
                                          // color: Colors.red,
                                          // width: 200,
                                          height: 270,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemCount: modelListSnapShot!.length,
                                              itemBuilder: (context, i) {
                                                return (modelListSnapShot![i] != null && modelListSnapShot![i]['name'] !=  productSnapshot!['name'] )
                                                    ? InkWell(
                                                  onTap: (){
                                                    Navigator.of(context).push(MaterialPageRoute(
                                                      builder: (context) => ProductDetails( modelListSnapShot![i].id.toString()),
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
                                                                      modelListSnapShot![i]['images'][0].toString()
                                                                  )
                                                              )),
                                                        ),

                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Container(
                                                              width: 150,
                                                              height: 30,
                                                              //color: Colors.grey,
                                                              child: Center(
                                                                child: Text(modelListSnapShot![i]['name'],
                                                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,), overflow: TextOverflow.ellipsis,),
                                                              ),
                                                            ),
                                                            //  SizedBox(height: 10,),
                                                            FirebaseAuth.instance.currentUser != null ?
                                                            Text('${LocalStorageService.instance.user!.role == 1? modelListSnapShot![i]['wholesale price'].toString():modelListSnapShot![i]['retail price'].toString()}\$',
                                                              style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.w500),):
                                                            Text('${modelListSnapShot![i]['retail price'].toString()}\$',
                                                              style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.w500),),
                                                            SizedBox(height: 10,),
                                                            FirebaseAuth.instance.currentUser != null ?
                                                            Text( modelListSnapShot![i]['old price'].toString()=='0'?'':'${modelListSnapShot![i]['old price'].toString()}\$',style:
                                                            TextStyle(fontSize: 18,color: Colors.black54,fontWeight: FontWeight.w500,decoration: TextDecoration.lineThrough),):
                                                                SizedBox()
                                                          ],
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
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        if(quantity>1){
                                          quantity= quantity-1;
                                          quantityController.text = quantity.toString();
                                        }


                                      });
                                    },

                                    child: Container(
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
                                          color: Theme.of(context).colorScheme.secondary,
                                        )
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 2, color: Colors.red[900]!.withOpacity(0.5),),
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
                                        width: 60,
                                        alignment: Alignment.center,
                                        // color: Colors.red,
                                        child: SizedBox(
                                          height: 40,
                                          child: TextField(
                                            onChanged: (val){
                                              int? number = int.tryParse(val);
                                              if(number != null){
                                                quantity = number;
                                              }
                                            },
                                            onSubmitted: (val){
                                              int? number = int.tryParse(val);
                                              if(number != null){
                                                quantity = number;
                                              }
                                            },
                                            controller: quantityController,
                                            textAlign: TextAlign.center,
                                            keyboardType: TextInputType.numberWithOptions(signed: true),
                                            inputFormatters: [
                                              FilteringTextInputFormatter.digitsOnly,
                                              LengthLimitingTextInputFormatter(3),
                                              //FilteringTextInputFormatter.deny(r"0"),
                                              ArabicToEnglishNumbers(),
                                            ],
                                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              isDense: true,
                                              contentPadding: EdgeInsets.symmetric(
                                                vertical: 0
                                              )
                                            ),
                                          ),
                                        )
                                        // Center(child:
                                        //     Text(quantity.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                                        // ))
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        quantity= quantity+1;
                                        quantityController.text = quantity.toString();

                                      });
                                    },
                                    child: Container(
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
                                          color: Theme.of(context).colorScheme.secondary,
                                        )
                                    ),
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
                                    child: isfav? InkWell(

                                      onTap: (){
                                       setState(() {
                                         if(   FirebaseAuth.instance.currentUser != null){
                                           User user = _auth.currentUser!;
                                           userCollection
                                               .doc(user.uid)
                                               .collection('favorite')
                                               .doc(widget.productID).delete();
                                           // //print('added to fav');
                                           isfav= !isfav;
                                           ScaffoldMessenger.of(context).showSnackBar(_snackBarRemoveFromFav);

                                         }else{
                                           print('no user');
                                         }

                                       });
                                      },
                                      child: Icon(
                                        Icons.favorite,
                                        size: 30,
                                        color: Theme.of(context).colorScheme.secondary,
                                      ),
                                    ):

                                    InkWell(
                                      onTap: (){
                                       setState(() {
                                         if(   FirebaseAuth.instance.currentUser != null){
                                           User user = _auth.currentUser!;
                                           userCollection
                                               .doc(user.uid)
                                               .collection('favorite')
                                               .doc(widget.productID)
                                               .set({
                                             "productID":widget.productID
                                           });
                                           isfav= !isfav;
                                           // //print('added to fav');
                                           ScaffoldMessenger.of(context).showSnackBar(_snackBarAddToFav);

                                         }else{
                                           Navigator.of(context).push(MaterialPageRoute(
                                             builder: (context) => MainLoginPage(),
                                           ));
                                         }

                                       });
                                      },
                                      child: Icon(
                                        Icons.favorite_border,
                                        size: 30,
                                        color: Theme.of(context).colorScheme.secondary,
                                      ),
                                    )
                                ),


                                // addtocart
                                SizedBox(
                                    width: MediaQuery.of(context).size.width - 40,
                                    child:  productSnapshot!['quantity']==0 ||productSnapshot!['quantity']<0  ||productSnapshot!['quantity']< quantity?
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
                                                  //print('out of stock');
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
                                                          AppLocalizations.of(context).trans("Addtocart"),
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
                                        :
                                    //Addtocart
                                    Stack(
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

 if(   FirebaseAuth.instance.currentUser != null){
  User user = _auth.currentUser!;
  userCollection
        .doc(user.uid)
        .collection('cart')
        .doc(widget.productID)
        .set({
      "productID": widget.productID,
      "quantity": quantity,
      "price":
      LocalStorageService.instance.user!.role == 1?
      productSnapshot!['wholesale price']
          :productSnapshot!['retail price'],
      "name": productSnapshot!['name'],
      "nameA": productSnapshot!['nameA'],
      "nameK": productSnapshot!['nameK'],
      "supPrice":
      ( LocalStorageService.instance.user!.role == 1?
      productSnapshot!['wholesale price']
          :productSnapshot!['retail price']) * quantity,


      "img": productSnapshot!['images'][0],
    "itemCode": productSnapshot!['itemCode'],
  });
  //print('added');
  ScaffoldMessenger.of(context).showSnackBar(_snackBar);

}else{
  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MainLoginPage(),
  ));
}

//Addtocart

                                              },
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 35),
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

                                      ],
                                    )
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                );
              }
          )


      ),
    );
  }
  int selectedIndex = 0;
  getCurrentPage(){
    if(selectedIndex == 1){
      return Text(


        AppLocalizations.of(context).locale.languageCode.toString()=='ku'?
        productSnapshot!['descK'] ?? '':
        AppLocalizations.of(context).locale.languageCode.toString()=='ar'?
        productSnapshot!['descA'] ?? '':
        productSnapshot!['desc'] ?? '',

       style: TextStyle(fontSize: 16,height: 1.3),);

    }else if (selectedIndex == 0){
      return
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Text(  AppLocalizations.of(context).trans("Make"),
                    maxLines: 3,
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text( makeName.isEmpty?'': makeName.toString(),
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
                  child: Text( AppLocalizations.of(context).trans("Model"),
                    maxLines: 3,
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(modelName.isEmpty?'': modelName,
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
                  child: Text( AppLocalizations.of(context).trans("Brand"),
                    maxLines: 3,
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(productSnapshot!['brand'],
                    maxLines: 5,
                    style: TextStyle(fontSize: 15),
                  ),
                )
              ],),
           // SizedBox(height: 15,),

            SizedBox(height: 15,),
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Text( AppLocalizations.of(context).trans("OEMCode"),
                    maxLines: 3,
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(productSnapshot!['oemCode'].toString(),
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
                  child: Text(  AppLocalizations.of(context).trans("PiecesInBox"),
                    maxLines: 3,
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(productSnapshot!['piecesInBox'].toString(),
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
                  child: Text(  AppLocalizations.of(context).trans("volt"),
                    maxLines: 3,
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(productSnapshot!['volt'],
                    maxLines: 5,
                    style: TextStyle(fontSize: 15),
                  ),
                )
              ],),
            SizedBox(height: 15,),


            productSnapshot!['pdfUrl'].toString()==""?
                SizedBox():
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Text('Catalog',
                    maxLines: 3,
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: InkWell(
                      onTap: (){
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => PdfBook(
    pdfUrl:productSnapshot!['pdfUrl'].toString(),
    )
    ));
    },
                      child: Icon(Icons.picture_as_pdf_outlined))
                )
              ],),
            SizedBox(height: 35,),
            Container(
              height: 65,
              width: 250,
              child:
              // SfBarcodeGenerator(
              //   value: productSnapshot!['barCode'].toString(),
              //   symbology: EAN13(),
              //   showValue: true,
              // ),
              BarcodeWidget(
                data: productSnapshot!['barCode'].toString(),
                barcode: Barcode.code128(escapes: true),
              ),
            ),


          ],);

    }

  }

  int quantity = 1;

  final _snackBar = SnackBar(
   // behavior: SnackBarBehavior.floating,
    // margin: EdgeInsets.only(bottom: 400,left: 20,right: 20),

    content:
    Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
            borderRadius: BorderRadius.all(
                Radius.circular(15)
              //                 <--- border radius here
            ),
           // border: Border.all(color: Colors.black12,width: 0.6),
         ),
        height:130,
        width: 300,
        child: Center(
          child: Text('Added Successfully',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    ),
   backgroundColor: Colors.transparent,
    duration: Duration(seconds: 2),
  );

  final _snackBarAddToFav = SnackBar(

    content:
    Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
              Radius.circular(15)
            //                 <--- border radius here
          ),
          // border: Border.all(color: Colors.black12,width: 0.6),
        ),
        height:130,
        width: 300,
        child: Center(
          child: Text(
            'Added To Favorite',
            //AppLocalizations.of(context).trans("Addedtofavorite"),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    ),
    backgroundColor: Colors.transparent,
    duration: Duration(seconds: 1),
  );
  final _snackBarRemoveFromFav = SnackBar(
    content:
    Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
              Radius.circular(15)
          ),
        ),
        height:130,
        width: 300,
        child: Center(
          child: Text('Removed From Favorite',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    ),
    backgroundColor: Colors.transparent,
    duration: Duration(seconds: 1),
  );
  bool isfav=false;
  List<DocumentSnapshot>? getFav;
  List <String> favList=[];


  getFavList() {

    int i = 0;
    FirebaseFirestore.instance.collection('users').doc(user?.uid).collection('favorite').get().then((value) {
      getFav = [];//new List<DocumentSnapshot>(value.docs.length);
      getFav!.addAll(value.docs);
      if(favList.contains(widget.productID)){
        isfav=true;
      }else{
        isfav=false;
      }
      setState(() {

      });

    });

  }




}

class ArabicToEnglishNumbers extends TextInputFormatter{
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(
        text: _replaceArabicNumber(newValue.text)
    );
  }

  String _replaceArabicNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(arabic[i], english[i]);
    }
    if(input.length > 0 && input[0] == '0'){
      input = input.replaceFirst("0","");
    }
    return input;
  }
}
