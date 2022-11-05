// ignore_for_file: file_names, prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlineshopping/Widgets/BackArrowWidget.dart';
import 'package:onlineshopping/Widgets/empty.dart';
import 'package:onlineshopping/localization/AppLocal.dart';
import 'package:onlineshopping/screen/homepage.dart';
import 'package:onlineshopping/screen/productDetails.dart';
import 'package:collection/collection.dart';
import 'package:uuid/uuid.dart';

import 'order_history.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({Key key}) : super(key: key);
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  FirebaseAuth _auth;
  final userCollection = FirebaseFirestore.instance.collection('users');
  List<DocumentSnapshot> cart;
  List<Map> cartList = [];
  User user;
  double subTotal=0.0;
  DocumentSnapshot adminInfo;
  DocumentSnapshot adminInfoCollection;
  DocumentSnapshot userInfo;
  DocumentSnapshot userInfoCollection;
  double deliveryFee=0.0;
  double dinnar =00;
  String name='';
  String address='';
  String phone='';
  var uuid = Uuid();
  String rundomNumber;

  getCart() {
    cartList=[];
    subTotal=0.0;
    int i = 0;
    FirebaseFirestore.instance.collection('users').doc(user.uid).collection('cart').get().then((value) {
      cart = new List<DocumentSnapshot>(value.docs.length);
      value.docs.forEach((element) async {
        setState(() {
          cart[i] = element;
          cartList.add({
            'name':  cart[i]['name'],
            'price':  cart[i]['price'],
            'quantity':  cart[i]['quantity'],
            'img':  cart[i]['img'],
          });
          setState(() {
            subTotal += cart[i]['price']*cart[i]['quantity'];
          });
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
      deliveryFee =  double.parse('${adminInfo.data()['deliveryfee']}');
      dinnar =  double.parse('${adminInfo.data()['dinnar']}');
    });
  }
  getUserInfo() async{
    userInfoCollection = await FirebaseFirestore.instance
        .collection('users').doc(user.uid)
        .get();
    setState(() {
      userInfo=userInfoCollection;
      name =  userInfo.data()['username'];
      address =  userInfo.data()['address'];
      phone =  userInfo.data()['phone'];
    });
  }





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth = FirebaseAuth.instance;
    user = _auth.currentUser;
    getCart();
    getAdminInfo();
    getUserInfo();
    rundomNumber = uuid.v1();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title:  Text('Cart Screen'),
            elevation: 0,
            leading: BackArrowWidget()
        ),
        body:
        Builder(
            builder: (BuildContext context){
              return cartList.isEmpty? EmptyWidget(): Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          SizedBox(height: 10,),
                          Row(children: [
                            Text(' Delivery to  ',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(address,
                              style: TextStyle(color: Colors.indigo,fontSize: 16),
                            )
                          ],),
                        ],
                      ),
                    ),

                    SizedBox(height: 20,),

                    Expanded(

                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance.collection('users').doc(user.uid).collection('cart').snapshots(),
                          builder: ( _, snapshot) {
                            return Container(
                              // color: Colors.red,
                              child: ListView.builder(
                                itemCount: snapshot.data?.docs?.length ?? 0,
                                itemBuilder: (_, index) {

                                  if (snapshot.hasData) {
                                    DocumentSnapshot cartInfo = snapshot.data.docs[index];


                                    return  InkWell(
                                      onTap: (){
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 20),
                                        child: SingleChildScrollView(
                                          child: Stack(
                                            children: [

                                              Container(
                                                  height: 110,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white70,
                                                      // color: Colors.red,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.grey[200],
                                                            spreadRadius: 1,
                                                            blurRadius: 10)
                                                      ]),
                                                  child:
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          height: 100,
                                                          width: 100,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.all(
                                                                  Radius.circular(10)
                                                                //                 <--- border radius here
                                                              ),
                                                              border: Border.all(color: Colors.black12,width: 0.6),
                                                              image: DecorationImage(
                                                                  fit: BoxFit.cover,
                                                                  image: NetworkImage(
                                                                    cartInfo
                                                                        .data()["img"]
                                                                        .toString(),))),
                                                        ),

                                                        Expanded(
                                                          child: Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                                            child: Container(
                                                              //  color: Colors.red,
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [

                                                                  Text(
                                                                    cartInfo
                                                                        .data()["name"]
                                                                        .toString(),
                                                                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                                                                  ),
                                                                  SizedBox(height: 10,),
                                                                  // Text(
                                                                  //     '${ cartInfo
                                                                  //         .data()["price"]
                                                                  //         .toString()}\$'
                                                                  // ),

                                                                  Text(
                                                                    '${   ( cartInfo
                                                                        .data()["price"]* cartInfo.data()['quantity'])
                                                                        .toString()}\$',
                                                                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.green[900]),


                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],),
                                                  )
                                              ),
                                              Positioned(
                                                bottom: 15,
                                                right: 15,
                                                child: Row(
                                                  children: [

                                                    InkWell(
                                                      onTap: (){
                                                        setState(() {
                                                          subTotal += cartInfo.data()['price'];
                                                          User user = _auth.currentUser;
                                                          userCollection
                                                              .doc(user.uid)
                                                              .collection('cart')
                                                              .doc(cartInfo.id).update({
                                                            "quantity":  cartInfo.data()['quantity']+1,
                                                            // "subPrice": (cartInfo.data()['quantity'] +1) * cartInfo.data()['price']
                                                          });
                                                          //calculatingTotalPrice(cartInfo.data()['price'], cartInfo.data()['quantity']);
                                                          print('added');
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

                                                          height: 30,
                                                          width: 30,
                                                          // color: Colors.red,
                                                          child:  Icon(
                                                            Icons.add,
                                                            size: 23,
                                                            color: Theme.of(context).accentColor,
                                                          )
                                                      ),
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

                                                          height: 32,
                                                          width: 32,
                                                          // color: Colors.red,
                                                          child:  Center(child:
                                                          Text(cartInfo
                                                              .data()["quantity"]
                                                              .toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),))
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap:  () {
                                                        //Addtocart
                                                        setState(() {
                                                          if(  cartInfo.data()['quantity']>1){
                                                            //productListSnapShot[i]['quantity']-1;
                                                            subTotal -= cartInfo.data()['price'];
                                                            User user = _auth.currentUser;
                                                            userCollection
                                                                .doc(user.uid)
                                                                .collection('cart')
                                                                .doc(cartInfo.id).update({
                                                              "quantity":  cartInfo.data()['quantity']-1,
                                                              // "subPrice": (cartInfo.data()['quantity'] -1) * cartInfo.data()['price']

                                                            });

                                                            print('removed');
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

                                                          height: 30,
                                                          width: 30,
                                                          // color: Colors.red,
                                                          child:  Icon(
                                                            Icons.remove,
                                                            size: 25,
                                                            color: Theme.of(context).accentColor,
                                                          )
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),);
                                  } else {
                                    return EmptyWidget();
                                  }
                                },
                              ),
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
                              Text('SubTotal',
                                style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),
                              ),
                              Text('${subTotal.floor().toString()}\$',
                                style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          SizedBox(height: 2,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Delivery Fee',
                                style: TextStyle(fontSize: 16,),

                              ),
                              Text('${deliveryFee.floor()} \$',
                                style: TextStyle(fontSize: 16,),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total',
                                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                              ),
                              Text('${((subTotal+deliveryFee)*dinnar).floor().toString()} IQD',
                                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Today\'s Exchange Rate',
                                style: TextStyle(fontSize: 13,),

                              ),
                              Text('${(dinnar*100).floor().toString()} IQD',
                                style: TextStyle(fontSize: 13,),
                              ),
                            ],
                          ),



                          SizedBox(height: 25,),
                          InkWell(
                              onTap: (){
                                setState(() {
                                  // cartList.add({
                                  //   'name': snapshot.data.docs[index]['name'],
                                  //   'price': snapshot.data.docs[index]['price'],
                                  //   'quantity': snapshot.data.docs[index]['quantity'],
                                  // });

                                  getCart();
                                  Future.delayed(Duration(milliseconds: 100),(){
                                    FirebaseFirestore.instance.collection('Admin').doc('admindoc').collection('orders').add({
                                      "productList":cartList,
                                      "subTotal": subTotal,
                                      "totalPrice":(subTotal+deliveryFee)*dinnar,
                                      "deliveryFee":deliveryFee,
                                      "userID": user.uid,
                                      "userName": name,
                                      "userAddress": address,
                                      "userPhone": phone,
                                      "dinnar": dinnar,
                                      "orderID":rundomNumber
                                    });

                                    FirebaseFirestore.instance.collection('users').doc(user.uid).collection('orders').doc(rundomNumber).set({
                                      "productList":cartList,
                                      "subTotal": subTotal,
                                      "totalPrice":(subTotal+deliveryFee)*dinnar,
                                      "deliveryFee":deliveryFee,
                                      "userID": user.uid,
                                      "userName": name,
                                      "userAddress": address,
                                      "userPhone": phone,
                                      "dinnar": dinnar,
                                      "OrderStatus": 'Pending',
                                    });


                                  }).whenComplete(() {
                                    Scaffold.of(context).showSnackBar(_snackBar);

                                    Future.delayed(Duration(seconds: 2),(){
                                      Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => HomePage(),
                                      ));

                                      FirebaseFirestore.instance.collection('users').doc(user.uid).collection('cart').getDocuments().then((snapshot) {
                                        for (DocumentSnapshot doc in snapshot.docs) {
                                          doc.reference.delete();
                                        };
                                      });

                                      print('done');
                                    });



                                  });
// OrderHistoryScreen
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red[900],
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(8)
                                    //                 <--- border radius here
                                  ),),
                                width: double.infinity,

                                padding: EdgeInsets.all(15),
                                child: Center(child: Text('Send Order',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),)),
                        ],
                      ),
                    )

                  ],
                ),
              );
            }
        )



    );
  }
  final _snackBar = SnackBar(
    content: Text(
      'You order has been placed',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 17,
      ),
    ),
    backgroundColor: Colors.green,
    duration: Duration(seconds: 2),
  );

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
