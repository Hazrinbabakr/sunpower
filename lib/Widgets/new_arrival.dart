
// ignore_for_file: file_names, prefer_const_constructors, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onlineshopping/localization/AppLocal.dart';
import 'package:onlineshopping/screen/productDetails.dart';


class NewArrival extends StatefulWidget {
  const NewArrival({ key}) : super(key: key);

  @override
  _NewArrivalState createState() => _NewArrivalState();
}

class _NewArrivalState extends State<NewArrival> {
  // ignore: non_constant_identifier_names
  List<DocumentSnapshot> NewArrivalSnapshot;
  getNewArrival() {
    int i = 0;
    FirebaseFirestore.instance
        .collection('products').where("newArrival",isEqualTo: true)
        .get()
        .then((value) {
      NewArrivalSnapshot = new List<DocumentSnapshot>(value.docs.length);
      value.docs.forEach((element) async {
        setState(() {
          NewArrivalSnapshot[i] = element;
        });
        i++;
      });
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewArrival();
  }
  @override
  Widget build(BuildContext context) {
    return


      (NewArrivalSnapshot == null || NewArrivalSnapshot.isEmpty)
          ? SizedBox()
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            // color: Colors.red,
            // width: 200,
            height: 200,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: NewArrivalSnapshot.length<10? NewArrivalSnapshot.length:10,
                itemBuilder: (context, i) {
                  DocumentSnapshot data= NewArrivalSnapshot.elementAt(i);
                  return (NewArrivalSnapshot[i] != null)

                      ? Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: InkWell(
                    onTap: (){

                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProductDetails( NewArrivalSnapshot[i].id.toString()),
                      ));

                    },
                    child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child:
                        Column(
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(15)
                                    //                 <--- border radius here
                                  ),
                                  border: Border.all(color: Colors.black12,width: 0.6),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          NewArrivalSnapshot[i]['images'][0].toString()))),
                            ),
                            SizedBox(height: 7,),
                            Container(
                               width: 120,
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context).locale.languageCode.toString()=='ku'?
                                  NewArrivalSnapshot[i]['nameK']:
                                  AppLocalizations.of(context).locale.languageCode.toString()=='ar'?
                                  NewArrivalSnapshot[i]['nameA']:
                                  NewArrivalSnapshot[i]['name'],
                                  style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            )
                          ],
                        ),
                    ),),
                      )
                      : SizedBox();
                }),
          ),
        ],
      );



  }
}
