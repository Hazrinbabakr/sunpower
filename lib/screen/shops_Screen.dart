
// ignore_for_file: file_names, prefer_const_constructors_in_immutables, prefer_const_constructors, unrelated_type_equality_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onlineshopping/screen/shopDetails.dart';

class ShopsScreen extends StatefulWidget {
   final String categoryID;
   ShopsScreen(this.categoryID, {Key key}) : super(key: key);



  @override
  _ShopsScreenState createState() => _ShopsScreenState();
}

class _ShopsScreenState extends State<ShopsScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('shops').where('categoryID', isEqualTo: widget.categoryID).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Errorrrrr ${snapshot.error}');
            return const Text('Something went wrong with shopss');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          }
          if (snapshot.data.docs.isEmpty) {
            return Center(child: const Text('emptyyy'));
          }
          return  GridView.count(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            primary: false,
            // crossAxisSpacing: 1,
            //  mainAxisSpacing: 1,
            //childAspectRatio: 0.8,
            childAspectRatio: 0.99, // (itemWidth/itemHeight),
            padding: EdgeInsets.symmetric(
                horizontal: 10, vertical: 10),
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            crossAxisCount: MediaQuery.of(context).orientation ==
                Orientation.portrait
                ? 2
                : 4,
            children:
            List.generate(snapshot.data.docs.length, (index) {
              DocumentSnapshot data= snapshot.data.docs.elementAt(index);
              return  Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    print('shop ID  ${data.id.toString()}');

                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ShopDetail(data['shopEmail'].toString(),data.id.toString()),
                    ));

                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(100)
                        //                 <--- border radius here
                      ),
                      border: Border.all(color: Colors.black12,width: 2),
                    ),
                    child:  Center(child: Text(data['shopName'].toString(),style: TextStyle(fontWeight: FontWeight.w600,),))
                  ),
                ),
              );
            }),
          );
        },
      )
    );
  }
}
