// ignore_for_file: file_names, prefer_const_constructors
import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunpower/Widgets/BackArrowWidget.dart';
import 'package:sunpower/Widgets/empty.dart';
import 'package:sunpower/app/AppColors.dart';
import 'package:sunpower/localization/AppLocal.dart';
import 'package:sunpower/screen/homepage.dart';
import 'package:uuid/uuid.dart';



class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  FirebaseAuth? _auth;
  User? user;
  final userCollection = FirebaseFirestore.instance.collection('users');
  List<DocumentSnapshot> cart = [];
  List<Map> cartList = [];
  double subTotal=0.0;
  DocumentSnapshot? adminInfo;
  DocumentSnapshot? adminInfoCollection;
  DocumentSnapshot? userInfo;
  DocumentSnapshot? userInfoCollection;
  double deliveryFee=0.0;
  double dinnar =00;
  String name='';
  String address='';
  String phone='';
  var uuid = Uuid();
  String? rundomNumber;
  var formatter = NumberFormat('#,###,000');
  getCart() {
    cartList=[];
    subTotal=0.0;
    int i = 0;
    FirebaseFirestore.instance.collection('users')
        .doc(user?.uid??null).collection('cart').get().then((value) {
      value.docs.forEach((element) async {
        setState(() {
          cart.add(element);
          cartList.add({
            'name':  cart[i]['name'],
            'price':  cart[i]['price'],
            'productID':  cart[i]['productID'],
            'quantity':  cart[i]['quantity'],
            'img':  cart[i]['img'],
            'itemCode':  cart[i]['itemCode'],
          });
          //setState(() {
            subTotal += cart[i]['price']*cart[i]['quantity'];
          //});
        });
        i++;
      });
    }).whenComplete(() {

    });

  }
  getAdminInfo() async{
    adminInfoCollection = await FirebaseFirestore.instance
        .collection('Admin').doc('admindoc')
        .get();
    setState(() {
      adminInfo=adminInfoCollection;
      deliveryFee =  double.parse('${adminInfo!['deliveryfee']}');
      dinnar =  double.parse('${adminInfo!['dinnar']}');
    });
  }
  getUserInfo() async{
    userInfoCollection = await FirebaseFirestore.instance
        .collection('users').doc(user?.uid??null)
        .get();
    setState(() {
      userInfo=userInfoCollection;
      name =  userInfo!['username'];
      address =  userInfo!['address'];
      phone =  userInfo!['phone'];
    });
  }


  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    user = _auth!.currentUser!;
    getCart();
    getAdminInfo();
    getUserInfo();
    rundomNumber = uuid.v1();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initSnackBar();
    });
  }

  late Flushbar _snackBarOrderPLaced;
  initSnackBar(){
    _snackBarOrderPLaced = Flushbar(
      title: AppLocalizations.of(context).trans("orderPlaced"),
      message: AppLocalizations.of(context).trans("orderPlacedMessage"),
      duration: Duration(seconds: 2),
      backgroundGradient: LinearGradient(colors: [ Colors.black87,AppColors.primaryColor]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            title:  Text(AppLocalizations.of(context).trans("CartScreen"),style: TextStyle(color: Colors.black87),),
            automaticallyImplyLeading: false
        ),
        body: Builder(
            builder: (BuildContext context){
              if(cartList.isEmpty){
                return Padding(
                  padding: const EdgeInsets.only(top: 250),
                  child: Center(child: EmptyWidget()),
                );
              }
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16,),
                    child: Row(
                      children: [
                        Text(
                          AppLocalizations.of(context).trans("Address"),
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(width: 10,),
                        Expanded(child: Text(address.toString(), style: TextStyle(color: Colors.indigo,fontSize: 16),),)
                      ],
                    ),
                  ),

                  SizedBox(height: 20,),

                  Expanded(
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance.collection('users').doc(user!.uid).collection('cart').snapshots(),
                        builder: ( _, snapshot) {
                          return ListView.builder(
                            itemCount: snapshot.data?.docs.length ?? 0,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16
                            ),
                            itemBuilder: (_, index) {
                              if (snapshot.hasData) {
                                DocumentSnapshot cartInfo = snapshot.data!.docs[index];
                                return  Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Stack(
                                    children: [
                                      Container(
                                          height: 110,
                                          decoration: BoxDecoration(
                                              color: Colors.white70,
                                              borderRadius: BorderRadius.circular(16),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey[200]!,
                                                    spreadRadius: 1,
                                                    blurRadius: 10
                                                )
                                              ],
                                            border: Border.all(
                                              color: Colors.black12
                                            )
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 5),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 100,
                                                  child: AspectRatio(
                                                    aspectRatio: 0.7,
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(15),
                                                      child: CachedNetworkImage(
                                                        imageUrl: cartInfo["img"].toString(),
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          cartInfo["name"].toString(),
                                                          style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),
                                                        ),
                                                        SizedBox(height: 10,),
                                                        Text(
                                                          '${   ( cartInfo
                                                              ["price"]* cartInfo['quantity'])
                                                              .toStringAsFixed(2)}\$',
                                                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.green[900]),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                      ),
                                      PositionedDirectional(
                                        bottom: 15,
                                        end: 15,
                                        child: Row(
                                          children: [
                                            cartInfo["quantity"].toString()=="1"?
                                            InkWell(
                                              onTap:  () {
                                                showDialog(
                                                  context:context, builder: (_){
                                                    return AlertDialog(title: Text(AppLocalizations.of(context).trans('areYouSure')),
                                                    // shape: CircleBorder(),
                                                    shape: BeveledRectangleBorder(
                                                      borderRadius: BorderRadius.circular(5.0),
                                                    ),
                                                    elevation: 30,
                                                    backgroundColor: Colors.white,
                                                    actions: <Widget>[

                                                      InkWell(
                                                          onTap:(){
                                                            Navigator.of(context).pop();
                                                          },

                                                          child: Text(AppLocalizations.of(context).trans('no'),style: TextStyle(fontSize: 20,color: Theme.of(context).primaryColor),)),
                                                      SizedBox(height: 30,),
                                                      InkWell(
                                                        onTap: (){
                                                          setState(() {
                                                            //productListSnapShot[i]['quantity']-1;
                                                            subTotal -= cartInfo['price'];
                                                            User user = _auth!.currentUser!;
                                                            userCollection
                                                                .doc(user.uid)
                                                                .collection('cart')
                                                                .doc(cartInfo.id).delete();

                                                            Navigator.of(context).pop();

                                                          });
                                                        },
                                                        child: Text(AppLocalizations.of(context).trans('yes'),style: TextStyle(fontSize: 20,color: Colors.green[900])),
                                                      )
                                                    ],
                                                  );
                                                  },
                                                );
                                              },

                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context).colorScheme.secondary,
                                                    borderRadius: BorderRadius.circular(10),
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

                                                  height: 30,
                                                  width: 30,
                                                  // color: Colors.red,
                                                  child:  Icon(
                                                    Icons.delete,
                                                    size: 25,
                                                    color: Colors.white,
                                                  )
                                              ),
                                            ):
                                            InkWell(
                                              onTap:  () {
                                                setState(() {
                                                  if(  cartInfo['quantity']>1){
                                                    //productListSnapShot[i]['quantity']-1;
                                                    subTotal -= cartInfo['price'];
                                                    User user = _auth!.currentUser!;
                                                    userCollection
                                                        .doc(user.uid)
                                                        .collection('cart')
                                                        .doc(cartInfo.id).update({
                                                      "quantity":  cartInfo['quantity']-1,
                                                      // "subPrice": (cartInfo.data()['quantity'] -1) * cartInfo.data()['price']

                                                    });

                                                  }
                                                });
                                              },

                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context).primaryColor,
                                                    borderRadius: BorderRadius.circular(10),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.4),
                                                        spreadRadius: 1,
                                                        blurRadius: 7,
                                                      ),
                                                    ],
                                                  ),
                                                  height: 30,
                                                  width: 30,
                                                  child:  Icon(
                                                    Icons.remove,
                                                    size: 25,
                                                    color: Colors.white,
                                                  )
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(width: 2, color: Theme.of(context).primaryColor!.withOpacity(0.5),),
                                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.4),
                                                        spreadRadius: 1,
                                                        blurRadius: 7,
                                                      ),
                                                    ],
                                                  ),
                                                  height: 32,
                                                  width: 32,
                                                  child:  Center(child: Text(cartInfo["quantity"].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),))
                                              ),
                                            ),
                                            InkWell(
                                              onTap: (){
                                                setState(() {
                                                  subTotal += cartInfo['price'];
                                                  User user = _auth!.currentUser!;
                                                  userCollection
                                                      .doc(user.uid)
                                                      .collection('cart')
                                                      .doc(cartInfo.id).update({
                                                    "quantity":  cartInfo['quantity']+1,
                                                    // "subPrice": (cartInfo['quantity'] +1) * cartInfo['price']
                                                  });
                                                  //calculatingTotalPrice(cartInfo['price'], cartInfo['quantity']);
                                                  print('added');
                                                });


                                              },
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .colorScheme.secondary,
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

                                                  height: 30,
                                                  width: 30,
                                                  // color: Colors.red,
                                                  child:  Icon(
                                                    Icons.add,
                                                    size: 23,
                                                    color: Theme.of(context).colorScheme.primary,
                                                  )
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return EmptyWidget();
                              }
                            },
                          );
                        }),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(  AppLocalizations.of(context).trans("subtotal"),
                              style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),
                            ),
                            Text('${subTotal.toStringAsFixed(2)}\$',
                              style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        SizedBox(height: 2,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(  AppLocalizations.of(context).trans("DeliveryFee"),
                              style: TextStyle(fontSize: 14,),
                            ),
                            Text( subTotal==0 ?
                            '0': subTotal<= 100?'${deliveryFee.floor()} \$': "${0}",
                              style: TextStyle(fontSize: 14,),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(  AppLocalizations.of(context).trans("total"),
                              style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                            ),
                            Text(
                              subTotal==0 ? '0': subTotal <=100 ?
                              '${formatter.format(((subTotal+deliveryFee)*dinnar)).toString()} IQD' :
                              '${ formatter.format(((subTotal)*dinnar)).toString()} IQD',
                              style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context).trans("TodayExchangeRate"),
                              style: TextStyle(fontSize: 13,),
                            ),
                            Text('${ formatter.format(dinnar*100).toString()} IQD',
                              style: TextStyle(fontSize: 13,),
                            ),
                          ],
                        ),
                        SizedBox(height: 25,),
                        subTotal == 0 ?
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: double.infinity,
                          padding: EdgeInsets.all(15),
                          child: Center(
                              child: Text(AppLocalizations.of(context).trans("Sendorder"),style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                          ),
                        )
                            :
                        InkWell(
                            onTap: (){
                              setState(() {
                                var date =  DateTime.now();
                                var orderDate = DateFormat('MM-dd-yyyy, hh:mm a').format(date);
                                getCart();
                                Future.delayed(Duration(milliseconds: 100),(){
                                  FirebaseFirestore.instance.collection('Admin').doc('admindoc').collection('orders').doc(rundomNumber).set({
                                    "productList":cartList,
                                    "subTotal": subTotal,
                                    "totalPrice": subTotal <=100 ? (subTotal+deliveryFee)*dinnar :(subTotal)*dinnar ,
                                    "deliveryFee":subTotal <=100 ?  deliveryFee : 0,
                                    "userID": user!.uid,
                                    "userName": name,
                                    "userAddress": address,
                                    "userPhone": phone,
                                    "dinnar": dinnar,
                                    "orderID":rundomNumber,
                                    "OrderStatus": 'Pending',
                                    "date": orderDate,
                                    "itemCode": orderDate,
                                  });

                                  FirebaseFirestore.instance.collection('users').doc(user!.uid).collection('orders').doc(rundomNumber).set({
                                    "productList":cartList,
                                    "subTotal": subTotal,
                                    "totalPrice": subTotal <=100 ? (subTotal+deliveryFee)*dinnar :(subTotal)*dinnar ,
                                    "deliveryFee":subTotal <=100 ?  deliveryFee : 0,
                                    "userID": user!.uid,
                                    "userName": name,
                                    "userAddress": address,
                                    "userPhone": phone,
                                    "dinnar": dinnar,
                                    "OrderStatus": 'Pending',
                                    "date": orderDate,
                                    "orderID":rundomNumber,
                                  });

                                }).whenComplete(() {
                                  _snackBarOrderPLaced.show(context);

                                  Future.delayed(Duration(seconds: 2),(){
                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => HomePage(),
                                    ));

                                    FirebaseFirestore.instance.collection('users').doc(user!.uid).collection('cart')
                                        .get().then((snapshot) {
                                      for (DocumentSnapshot doc in snapshot.docs) {
                                        doc.reference.delete();
                                      };
                                    });
                                  });
                                });
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              width: MediaQuery.of(context).size.width * 0.8,
                              padding: EdgeInsets.all(8),
                              child: Center(child: Text(  AppLocalizations.of(context).trans("Sendorder"),style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)),)),
                      ],
                    ),
                  )

                ],
              );
            }
        )
    );
  }


// getAllProduct() {
//   allProductListSnapShot = new List<DocumentSnapshot>(productListSnapShot.length);
//  // allProductList = new List<Map>(productListSnapShot.length);
//   for(int i=0; i<productListSnapShot.length;i++) {
//
//     FirebaseFirestore.instance
//         .collection('products').where("productID", isEqualTo: productListSnapShot[i].id)
//         .get()
//         .then((value) {
//       value.docs.forEach((element) async {
//         setState(() {
//           allProductListSnapShot[i] =  element;
//           price=    allProductListSnapShot[i]['retail price'] *  productListSnapShot[i]['quantity'];
//          // name= allProductListSnapShot[i]['name'];
//
//           // allProductList.add({
//           //   "name":  allProductListSnapShot[i]['name']
//           // });
//
//         });
//         i++;
//       });
//     }).whenComplete(() {
//       calculatingTotalPrice();
//     });
//   }
// }

}







//



// calculatingTotalPrice(int price, int quantity){
//   setState(() {
//     for (int index = 0; index <  2; index++) {
//       totalPrice =  price * quantity ;
//     }
//   });
// }
