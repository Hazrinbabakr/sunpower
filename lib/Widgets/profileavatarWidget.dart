// import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunpower/localization/AppLocal.dart';
import 'package:sunpower/services/local_storage_service.dart';

import 'profile_image/profile_image_dialog.dart';


class ProfileAvatarWidget extends StatefulWidget {

  final String? userID;

  ProfileAvatarWidget({
    Key? key,
    this.userID
  }) : super(key: key);

  @override
  _ProfileAvatarWidgetState createState() => _ProfileAvatarWidgetState();
}

class _ProfileAvatarWidgetState extends State<ProfileAvatarWidget> {
  TextEditingController? _nameFieldController;
  TextEditingController? _textFieldController;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40,bottom: 30),
      decoration: BoxDecoration(
          color: Colors.white,//Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)
          ),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).hintColor.withOpacity(0.15),
                offset: Offset(0, 6),
                blurRadius: 20)
          ]),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child:
              StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("users")
                      .doc(widget.userID)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.data == null){
                      return SizedBox();
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          //if(FirebaseAuth.instance.currentUser?.photoURL != null)
                          InkWell(
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.black12,
                              backgroundImage: FirebaseAuth.instance.currentUser?.photoURL != null? NetworkImage(FirebaseAuth.instance.currentUser?.photoURL??''):null,
                              child: FirebaseAuth.instance.currentUser?.photoURL != null ?
                              const SizedBox() :  Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white
                                      ),
                                    ),
                                    const SizedBox(height: 1,),
                                    Container(
                                      width: 50,
                                      height: 15,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          color: Colors.white,
                                        borderRadius: BorderRadius.circular(200)
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            borderRadius: BorderRadius.circular(200),
                            onTap: () async {
                              var res = await ProfileImageDialog.show(context);
                              if(res??false){
                                setState(() {
                                  //print(FirebaseAuth.instance.currentUser?.photoURL);
                                });
                              }
                            },
                          ),
                          SizedBox(width: 16,),
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("${ snapshot.data!['username'].toUpperCase().toString()??''}",
                                    style: TextStyle(fontSize: 22,color: Colors.black),
                                  ),
                                  Text(_getUserType,
                                    style: TextStyle(
                                        fontSize: 14
                                    ),
                                    maxLines: 2,
                                  ),
                                  SizedBox(height: 4,),
                                  Text("+${snapshot.data!['country_code']??''}${snapshot.data!['phone'].toString()??''}",
                                    style: Theme.of(context).textTheme.subtitle1!.merge(
                                    TextStyle(color: Theme.of(context).hintColor)),
                                  ),
                                  SizedBox(height: 4,),
                                  InkWell(
                                    onTap: (){
                                      _nameFieldController = TextEditingController(text:  snapshot.data!['username'].toString());
                                      _textFieldController = TextEditingController(text:  snapshot.data!['address'].toString());

                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title:  Text( AppLocalizations.of(context).trans('editYourAddress'),),
                                              content: Container(
                                                height: 150,
                                                child: Column(
                                                  children: [
                                                    TextField(
                                                      controller: _nameFieldController,
                                                      decoration:  InputDecoration(hintText:  AppLocalizations.of(context).trans('name'),),
                                                    ),
                                                    SizedBox(height: 10,),
                                                    TextField(
                                                      controller: _textFieldController,
                                                      decoration:  InputDecoration(hintText:  AppLocalizations.of(context).trans('address'),),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[
                                               Row(
                                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                 children: [
                                                 ElevatedButton(
                                                     child:  Text( AppLocalizations.of(context).trans('cancel'),style: TextStyle(color: Colors.white),),
                                                     onPressed: () => Navigator.pop(context),
                                                     style: ButtonStyle(
                                                         backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                                         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                             RoundedRectangleBorder(
                                                               borderRadius: BorderRadius.circular(10.0),
                                                             )
                                                         )
                                                     )
                                                 ),
                                                 ElevatedButton(
                                                     style: ButtonStyle(
                                                         backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                                         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                             RoundedRectangleBorder(
                                                               borderRadius: BorderRadius.circular(10.0),
                                                             )
                                                         )
                                                     ),
                                                     child:  Text( AppLocalizations.of(context).trans('edit'),style: TextStyle(color: Colors.white),),
                                                     onPressed: () {
                                                       // widget.address=_textFieldController.text;
                                                       FirebaseFirestore.instance
                                                           .collection("users").doc(widget.userID).update({
                                                         "username":  _nameFieldController!.text,
                                                         "address":  _textFieldController!.text,
                                                         // "subPrice": (cartInfo.data()['quantity'] +1) * cartInfo.data()['price']
                                                       });
                                                       Navigator.pop(context);

                                                     }

                                                 ),
                                               ],)
                                              ],
                                            );
                                          });
                                    },

                                    child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                        Expanded(
                                          child: Text(snapshot.data!['address'].toString()??'',
                                            style: Theme.of(context).textTheme.subtitle1,
                                            maxLines: 2,
                                          ),
                                        ),
                                        SizedBox(width: 10,),

                                        Icon(Icons.edit)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                          ),
                        ],
                      ),
                    );
                  }
              )

            ),
          ),
          // Expanded(
          //   child: Text('Edit')
          // )
        ],
      ),
    );
  }

  get _getUserType {
    if(LocalStorageService.instance.user!.role == 1){
      return "(${AppLocalizations.of(context).trans("wholesaleUser")})";
    }
    else {//
      return "(${AppLocalizations.of(context).trans("normalUser")})";
    }
  }

  @override
  void dispose() {
    _nameFieldController?.dispose();
    _textFieldController?.dispose();
    super.dispose();
  }
}
