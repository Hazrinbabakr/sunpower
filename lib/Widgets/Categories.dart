
// ignore_for_file: file_names, prefer_const_constructors, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onlineshopping/localization/AppLocal.dart';
import 'package:onlineshopping/screen/productList.dart';


class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({ key}) : super(key: key);

  @override
  _CategoriesWidgetState createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    return
StreamBuilder<QuerySnapshot>(
stream: FirebaseFirestore.instance.collection('categories').snapshots(),
builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
if (snapshot.hasError) {
print('Errorrrrr ${snapshot.error}');
return const Text('Something went wrong');
}
if (snapshot.connectionState == ConnectionState.waiting) {
return const CircularProgressIndicator();
}

return  GridView.count(
  scrollDirection: Axis.vertical,
  shrinkWrap: true,
  primary: false,
  // crossAxisSpacing: 1,
  // mainAxisSpacing: 1,
  //childAspectRatio: 0.8,
  //childAspectRatio: 0.60, // (itemWidth/itemHeight),
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
    return  InkWell(
      onTap: (){
       // print('Main Category ID  ${data.id.toString()}');

          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductsList(
                data.id.toString(),
                AppLocalizations.of(context).locale.languageCode.toString()=='ku'?
                data['nameK'].toString():
                AppLocalizations.of(context).locale.languageCode.toString()=='ar'?
                data['nameA'].toString():
                data['name'].toString(),


            ),
          ));

      },
      child: Column(
        children: [
          Container(
            height: 130,
            width: 130,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(15)
                  //                 <--- border radius here
                ),
                border: Border.all(color: Colors.black12,width: 0.6),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        data['img'].toString()))),
          ),
          SizedBox(height: 7,),
          Text(
              AppLocalizations.of(context).locale.languageCode.toString()=='ku'?
            data['nameK'].toString():
              AppLocalizations.of(context).locale.languageCode.toString()=='ar'?
            data['nameA'].toString():
            data['name'].toString(),
            style: TextStyle(fontWeight: FontWeight.w600,),)
        ],
      ),
    );
  }),
);
},
);
  }
}
