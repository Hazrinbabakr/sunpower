// ignore_for_file: file_names, prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onlineshopping/Widgets/BackArrowWidget.dart';
import 'package:onlineshopping/Widgets/empty.dart';
import 'package:onlineshopping/localization/AppLocal.dart';
import 'package:onlineshopping/screen/productList.dart';



class AllCategory extends StatefulWidget {
  final List<DocumentSnapshot> categoryList;
  const AllCategory(this.categoryList, {Key key}) : super(key: key);
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
            : GridView.count(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: false,

          crossAxisSpacing: 12,
          //mainAxisSpacing: 15,
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
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                  //height: 900,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(15)
                        //                 <--- border radius here
                      ),
                      border: Border.all(color: Colors.black12,width: 0.6),
                    ),
                    child: Column(
                      //  crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        Container(
                          height: 90,
                          width: 130,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(15)
                                //                 <--- border radius here
                              ),
                              //border: Border.all(color: Colors.black12,width: 0.6),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      widget.categoryList[i]['img'].toString()))),
                        ),
                        SizedBox(height: 15,),
                        Container(
                          //color: Colors.red,
                            width: 170,
                            child: Text(
                              AppLocalizations.of(context).locale.languageCode.toString()=='ku'?
                              widget.categoryList[i]['nameK'].toString().toUpperCase():
                              AppLocalizations.of(context).locale.languageCode.toString()=='ar'?
                              widget.categoryList[i]['nameA'].toString().toUpperCase():
                              widget.categoryList[i]['name'].toString().toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,), overflow: TextOverflow.visible,maxLines: 3,)),
                        // SizedBox(height: 5,),
                        //LocalStorageService.instance.user.role == 1?


                        //SizedBox(width: 30,),

                      ],
                    )),
              ),)
                : SizedBox();
          }),
        )
    );
  }
}



