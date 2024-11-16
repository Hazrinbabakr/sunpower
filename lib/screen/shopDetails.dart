// ignore_for_file: file_names, prefer_const_constructors, avoid_print, prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShopDetail extends StatefulWidget {
  final String shopEmail;
  final String shopDocID;

  ShopDetail(this.shopEmail,this.shopDocID, {Key? key}) : super(key: key);
  @override
  _ShopDetailState createState() => _ShopDetailState();
}

class _ShopDetailState extends State<ShopDetail> {
  List<QueryDocumentSnapshot> shopCategorySnapshots =[];
  //QuerySnapshot? shopInfo;
 //late List<QueryDocumentSnapshot> categoryProductSnapshots;
 String selectedCategory='';
 //DocumentSnapshot data;
 @override
 void initState() {
   // TODO: implement initState
   Future.delayed(Duration(milliseconds: 1),(){
     setState(() {
       getShopCategorySnapshots();
       //getCategoryProductSnapshots();
     });
   });
   print(widget.shopEmail.toString());
   getShopInfo();
   super.initState();

 }
 getShopCategorySnapshots() {
    setState(() {
      FirebaseFirestore.instance
          .collection('shops/${widget.shopDocID}/category').snapshots().listen((event) {
            shopCategorySnapshots= event.docs;
            if(shopCategorySnapshots.isNotEmpty)
            {
              setState(() {
                DocumentSnapshot datas= shopCategorySnapshots.elementAt(0);
                selectedCategory= datas.id;
              });
            }
           // DocumentSnapshot data= event.docs.elementAt(index);
      });
    });
  }
String name='';
 String phone='';
 String email ='';
  Future getShopInfo() async {
    DocumentSnapshot snapshot =
    await FirebaseFirestore.instance.collection('shops').doc('Cm5JHbaj1rdaayxUeTdFBVRGkJZ2').get();
    setState(() {
      name= snapshot['shopName'];
      phone= snapshot['phoneNum'];
      email= snapshot['shopEmail'];
print(name+'nmeeeee');
    });
  }
  // getShopInfoSnapshots() {
  //   setState(() {
  //     var snapshots = FirebaseFirestore.instance
  //         .collection('shops').where('shopEmail', isEqualTo: widget.shopEmail??'').snapshots();
  //     name = snapshots.data()['name'];
  //   });
  //
  //   // ().listen((event) {
  //   //   shopInfo= event.docs;
  //   //   if(shopCategorySnapshots.isNotEmpty)
  //   //   {
  //   //     setState(() {
  //   //       DocumentSnapshot datas= shopCategorySnapshots.elementAt(0);
  //   //       selectedCategory= datas.id;
  //   //     });
  //   //   }
  //   //   // DocumentSnapshot data= event.docs.elementAt(index);
  //   // });
  // }
 // getCategoryProductSnapshots() {
 //   setState(() {
 //     FirebaseFirestore.instance
 //         .collection('shops/${widget.shopDocID}/product').snapshots().listen((event) {
 //       categoryProductSnapshots= event.docs;
 //     });
 //   });
 // }


  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: shopCategorySnapshots?.length??0,
      child: Scaffold(
        // appBar: AppBar(
        //   titleSpacing: 8,
        //   title: Text('testtt',style: TextStyle(color: Colors.red),),
        //
        //
        //   automaticallyImplyLeading: false,
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        //   centerTitle: true,
        //
        // ),
        body: Center(child: Column(
          children: [
            SizedBox(height: 50,),
            Text(name??''),
            Text(phone),
            Text(email),
            SizedBox(height: 30,),
            PreferredSize(
              preferredSize: Size.fromHeight(30),
              child: shopCategorySnapshots.isEmpty
                  ? Text('Empty category')
                  : TabBar(
                  labelColor: Theme.of(context).colorScheme.primary,
                  unselectedLabelColor: Theme.of(context).hintColor,
                  labelStyle: Theme.of(context).textTheme.subtitle2,
                  isScrollable: false,
                  indicatorPadding: EdgeInsets.symmetric(horizontal: 20),
                  indicatorSize: TabBarIndicatorSize.tab,
                  onTap: (i) {
                    DocumentSnapshot data= shopCategorySnapshots.elementAt(i);
                    selectedCategory=data.id;
                    setState(() {});
                  },
                  tabs: shopCategorySnapshots
                      .map<Widget>((e) {
                    return
                      Tab(
                        text: e['name'],
                      );
                  }

                  )
                      .toList()),
            ),





            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('shops/${widget.shopDocID}/product').where("categoryID", isEqualTo: selectedCategory.toString()).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
//print('Errorrrrr ${snapshot.error}');
                  return const Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                return  Container(
                  height: 300,

                  child: ListView(
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                      return ListTile(
                        title: Text('Product Name:  ${data['name'].toString()}'),
                      );
                    }).toList(),
                  ),
                );
              },
            ),

          ],
        )),
      ),
    );

  }
}
