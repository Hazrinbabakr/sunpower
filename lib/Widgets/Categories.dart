
// ignore_for_file: file_names, prefer_const_constructors, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onlineshopping/localization/AppLocal.dart';
import 'package:onlineshopping/screen/all_category.dart';
import 'package:onlineshopping/screen/productList.dart';


class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({ key}) : super(key: key);

  @override
  _CategoriesWidgetState createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  List<DocumentSnapshot> categorySnapshot;
  getCategry() {
    int i = 0;
    FirebaseFirestore.instance
        .collection('categories')
        .get()
        .then((value) {
      categorySnapshot = new List<DocumentSnapshot>(value.docs.length);
      value.docs.forEach((element) async {
        setState(() {
          categorySnapshot[i] = element;
        });
        i++;
      });
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategry();
  }
  @override
  Widget build(BuildContext context) {
    return


      (categorySnapshot == null || categorySnapshot.isEmpty)
          ? SizedBox()
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
    //AppLocalizations.of(context).trans("Deliverto"),
    AppLocalizations.of(context).trans("categories").toUpperCase(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),              InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AllCategory(categorySnapshot)),
                    );
                  },
                  child: Text( AppLocalizations.of(context).trans("ShowAll"),style: TextStyle(fontSize: 12,color: Theme.of(context).accentColor),)),

            ],
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              // color: Colors.red,
              // width: 200,
              height: 120,
              child: ListView.builder(

                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: categorySnapshot.length,
                  itemBuilder: (context, i) {
                    DocumentSnapshot data= categorySnapshot.elementAt(i);
                    return (categorySnapshot[i] != null)

                        ? Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Container(
                            width: 110,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(15)
                                  //                 <--- border radius here
                                ),
                                border: Border.all(color: Colors.black12,width: 0.6),
                               ),
                            child: InkWell(
                      onTap: (){
                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (context) => ProductDetails( modelListSnapShot[i].id.toString()),
                            // ));




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
                            margin: EdgeInsets.symmetric(horizontal: 0),
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                // color: Colors.green,
                                // borderRadius: BorderRadius.all(
                                //     Radius.circular(1)
                                //   //                 <--- border radius here
                                // ),
                               // border: Border.all(color: Colors.black12,width: 0.6),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        categorySnapshot[i]['img'].toString()))),
                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              AppLocalizations.of(context).locale.languageCode.toString()=='ku'? categorySnapshot[i]['nameK']:
                              AppLocalizations.of(context).locale.languageCode.toString()=='ar'?
                              categorySnapshot[i]['nameA']:
                              categorySnapshot[i]['name'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.w600,),),
                          )
                        ],
                      ),),
                          ),
                        )
                        : SizedBox();
                  }),
            ),
          ),
        ],
      );



  }
}
