// ignore_for_file: file_names, prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onlineshopping/Widgets/empty.dart';
import 'package:onlineshopping/localization/AppLocal.dart';
import 'package:onlineshopping/screen/productDetails.dart';
import 'package:collection/collection.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({Key key}) : super(key: key);
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  FirebaseAuth _auth;
  final userCollection = FirebaseFirestore.instance.collection('users');
 // List<DocumentSnapshot> productListSnapShot;
  //List<DocumentSnapshot> allProductListSnapShot=[];
  //List<String> cartIDs =[];
  //List<Map> allProductMap;

  List<DocumentSnapshot> cart;
  //int cartLength=2;
  User user;
  getCart() {
cartList=[];
    int i = 0;
    FirebaseFirestore.instance.collection('users').doc(user.uid).collection('cart').get().then((value) {
      cart = new List<DocumentSnapshot>(value.docs.length);
      value.docs.forEach((element) async {
        setState(() {
          cart[i] = element;
         // print(cart[i]['name']);
          cartList.add({
            'name':  cart[i]['name'],
            'price':  cart[i]['price'],
            'quantity':  cart[i]['quantity'],
          });
          print('${cartList[i]['name']}   name');
          print('${cartList[i]['price']}   price');
          print('${cartList[i]['quantity']}   quantity');
        });
        i++;
      });
    }).whenComplete(() {

    });

  }


  // String name='';
  // String pricee='';
  //int quantity=1;


  // getAllProduct() {
  //   allProductListSnapShot = new List<DocumentSnapshot>(productListSnapShot.length);
  //  // allProductList = new List<Map>(productListSnapShot.length);
  //   print(productListSnapShot.length);
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
  //          // print( productListSnapShot[i].id);
  //
  //         });
  //         i++;
  //       });
  //     }).whenComplete(() {
  //       calculatingTotalPrice();
  //     });
  //   }
  // }
 int test;
  //
  List<Map> cartList = [];
  // calculatingTotalPrice(int price, int quantity){
  //   setState(() {
  //     for (int index = 0; index <  2; index++) {
  //       totalPrice =  price * quantity ;
  //     }
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth = FirebaseAuth.instance;
    user = _auth.currentUser;
    // calculatingTotalPrice();
    // Future.delayed(Duration(seconds: 1),(){
    //   calculatingTotalPrice();
    // });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: InkWell(
          onTap: (){

          },
          child: Text('Cart Screen')),),
      body:

      Column(
        children: [
         // Text(totalPrice.toString()),
          Expanded(

            child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('users').doc(user.uid).collection('cart').snapshots(),
                builder: ( _, snapshot) {
                  return ListView.builder(
                      itemCount: snapshot.data?.docs?.length ?? 0,
                      itemBuilder: (_, index) {
                        //cartLength= snapshot.data.docs.length;
                        //print(cartList[index]['name']);

                       // totalPrice= totalPrice + (snapshot.data.docs[index]['price'] * snapshot.data.docs[index]['quantity']);
                       // total = total.add(snapshot.data.docs[index]['subPrice']);

                        if (snapshot.hasData) {
                          DocumentSnapshot cartInfo = snapshot.data.docs[index];
                          // total.add(snapshot.data.docs[index]['subPrice']);
                          // num sum = 0;
                          // total.forEach((num e){sum += e;});
                          // totalPrice= sum;
                          // print(sum);

                          return  InkWell(
                            onTap: (){
                              // Navigator.of(context).push(MaterialPageRoute(
                              //   builder: (context) => ProductDetails( allProductListSnapShot[i].id.toString()),
                              //));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: SingleChildScrollView(
                                child: Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey[200],
                                              spreadRadius: 1,
                                              blurRadius: 10)
                                        ]),
                                    child:
                                    Column(children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top:15,left: 100,bottom: 15),
                                        child: Row(
                                          children: [

                                            InkWell(
                                              onTap: (){
                                                setState(() {
                                                  User user = _auth.currentUser;
                                                  userCollection
                                                      .doc(user.uid)
                                                      .collection('cart')
                                                      .doc(cartInfo.id).update({
                                                    "quantity":  cartInfo.data()['quantity']+1,
                                                    "subPrice": (cartInfo.data()['quantity'] +1) * cartInfo.data()['price']
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
                                                  Text(cartInfo
                                                      .data()["quantity"]
                                                      .toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),))
                                              ),
                                            ),
                                            InkWell(
                                              onTap:  () {
                                                //Addtocart
                                                setState(() {
                                                  if(  cartInfo.data()['quantity']>1){
                                                    //productListSnapShot[i]['quantity']-1;
                                                    User user = _auth.currentUser;
                                                    userCollection
                                                        .doc(user.uid)
                                                        .collection('cart')
                                                        .doc(cartInfo.id).update({
                                                      "quantity":  cartInfo.data()['quantity']-1,
                                                      "subPrice": (cartInfo.data()['quantity'] -1) * cartInfo.data()['price']

                                                    });
                                                    //calculatingTotalPrice(cartInfo.data()['price'], cartInfo.data()['quantity']);

                                                    // totalPrice= totalPrice -productListSnapShot[i]['price'];
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
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Text(
                                      //   //price.toString()
                                      //     (allProductListSnapShot[i]['retail price'] *  productListSnapShot[i]['quantity']).toString()??''
                                      // ),
                                      SizedBox(height: 20,),
                                      Text(
                                        cartInfo
                                            .data()["subPrice"]
                                            .toString(),
                                      ),
                                      Text(
                                        cartInfo
                                            .data()["name"]
                                            .toString(),
                                      ),
                                      Text(
                                        cartInfo
                                            .data()["price"]
                                            .toString(),
                                      ),

                                    ],)


                                ),
                              ),
                            ),);
                        } else {
                          return EmptyWidget();
                        }
                      },
                  );
    }),
          ),
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
                    FirebaseFirestore.instance.collection('orders').add({
                      "productList":cartList,
                      "price":'120',
                    });
                  });

                });
              },
              child: Container(
                color: Colors.red[900],
                padding: EdgeInsets.all(30),
                child: Text('send order',style: TextStyle(color: Colors.white,fontSize: 30),),)),
        ],
      )
    );
  }
  final _snackBar = SnackBar(
    content: Text(
      'Do you want to delete from cart',
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
}


