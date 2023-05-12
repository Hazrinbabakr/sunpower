// ignore_for_file: file_names, prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sunpower/Widgets/BackArrowWidget.dart';
import 'package:sunpower/Widgets/empty.dart';
import 'package:sunpower/localization/AppLocal.dart';
import 'package:sunpower/screen/productList.dart';



class AllCategory extends StatefulWidget {
  final List<DocumentSnapshot> categoryList;
  const AllCategory(this.categoryList, {Key? key}) : super(key: key);
  @override
  _AllCategoryState createState() => _AllCategoryState();
}

class _AllCategoryState extends State<AllCategory> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: BackArrowWidget(),
          automaticallyImplyLeading: false,
          title:

          Text(AppLocalizations.of(context).trans("categories"),),
          elevation: 0,
        ),

        body:
        (widget.categoryList == null)
            ? EmptyWidget()
            : Padding(
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 2),
              child: GridView.count(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: false,
          // crossAxisSpacing: 1,
          // mainAxisSpacing: 1,
          //childAspectRatio: 0.8,
          childAspectRatio: 0.8, // (itemWidth/itemHeight),
          padding: EdgeInsets.symmetric(
                horizontal: 10, vertical: 0),
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: MediaQuery.of(context).orientation ==
                Orientation.portrait
                ? 3
                : 4,
          children:
          List.generate(widget.categoryList.length, (i) {
              //DocumentSnapshot data= widget.categoryList.elementAt(i);
              return (widget.categoryList[i] != null)
                  ? InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProductsList(
                      widget.categoryList[i].id.toString(),
                      AppLocalizations.of(context).locale.languageCode.toString()=='ku'?
                      widget.categoryList[i]['nameK'].toString():
                      AppLocalizations.of(context).locale.languageCode.toString()=='ar'?
                      widget.categoryList[i]['nameA'].toString():
                      widget.categoryList[i]['name'].toString(),


                    ),
                  ));
                },
                child:  Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(15)
                            //                 <--- border radius here
                          ),
                          border: Border.all(color: Colors.black12,width: 0.6),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  widget.categoryList[i]['img'].toString()))),
                    ),
                    SizedBox(height: 7,),
                    Text(
                      AppLocalizations.of(context).locale.languageCode.toString()=='ku'?
                      widget.categoryList[i]['nameK'].toString():
                      AppLocalizations.of(context).locale.languageCode.toString()=='ar'?
                      widget.categoryList[i]['nameA'].toString():
                      widget.categoryList[i]['name'].toString(),
                     style: TextStyle(fontWeight: FontWeight.w600,),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),)
                  : SizedBox();
          }),
        ),
            )
    );
  }
}



