// ignore_for_file: file_names, prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunpower/Widgets/language_bottom_sheet.dart';
import 'package:sunpower/Widgets/profileavatarWidget.dart';
import 'package:sunpower/app/Application.dart';
import 'package:sunpower/localization/AppLocal.dart';
import 'package:sunpower/screen/contact_us.dart';
import 'package:sunpower/screen/order_history.dart';
import 'package:sunpower/services/local_storage_service.dart';

import 'Favorites.dart';
import 'about_us.dart';
import 'notification/notification_list.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool guest =true;
  User user = FirebaseAuth.instance.currentUser!;
  DocumentSnapshot? userInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom - 60,
          child: Column(
            children: <Widget>[
              ProfileAvatarWidget(
                userID: user.uid??"",
              ),
              SizedBox(height: 16,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                decoration: BoxDecoration(
                  color: Colors.white,//Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color:
                        Theme.of(context).hintColor.withOpacity(0.15),
                        offset: Offset(0, 3),
                        blurRadius: 10)
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> OrderHistoryScreen()));
                        },
                        dense: true,
                        leading: Icon(
                          Icons.shopping_bag_outlined,
                          size: 22,
                          color: Theme.of(context).focusColor,
                        ),
                        title: Text(
                          AppLocalizations.of(context).trans("orderHistory"),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,color: Colors.black26,size: 22,)
                    ),
                    ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> FavoriteScreen()));
                        },
                        dense: true,
                        leading: Icon(
                          Icons.favorite_border,
                          size: 22,
                          color: Theme.of(context).focusColor,
                        ),
                        title: Text(
                          AppLocalizations.of(context).trans("favorite"),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,color: Colors.black26,size: 22,)),
                    ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> NotificationsList()));
                        },
                        dense: true,
                        leading: Icon(
                          Icons.notifications_active_outlined,
                          size: 22,
                          color: Theme.of(context).focusColor,
                        ),
                        title: Text(
                          AppLocalizations.of(context).trans("notifications"),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,color: Colors.black26,size: 22,)
                    ),
                    ListTile(
                        onTap: () {
                          LanguageBottomSheet.showLanguageBottomSheet(context);
                        },
                        dense: true,
                        leading: Icon(
                          Icons.translate,
                          size: 22,
                          color: Theme.of(context).focusColor,
                        ),
                        title: Text(
                          AppLocalizations.of(context).trans("language"),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,color: Colors.black26,size: 22,)),
                    // ListTile(
                    //     onTap: () {
                    //       Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ContactUS()));
                    //     },
                    //     dense: true,
                    //     leading: Icon(
                    //       Icons.contact_phone_outlined,
                    //       size: 22,
                    //       color: Theme.of(context).focusColor,
                    //     ),
                    //     title: Text(AppLocalizations.of(context).trans('contact_us'),
                    //       style: Theme.of(context).textTheme.subtitle1,
                    //     ),
                    //     trailing: Icon(Icons.arrow_forward_ios,color: Colors.black26,size: 22,)
                    // ),
                    ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AboutUs()));
                        },
                        dense: true,
                        leading: Icon(
                          Icons.perm_device_info,
                          size: 22,
                          color: Theme.of(context).focusColor,
                        ),
                        title: Text(AppLocalizations.of(context).trans('about_us'),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,color: Colors.black26,size: 22,)),
                    ListTile(
                        onTap: ()  {
                          showDialog(context:context,
                            builder: (_)=>  AlertDialog(
                              title: Column(
                                children: [
                                  Text(AppLocalizations.of(context).trans('areYouSure'),style: TextStyle(color: Colors.red,fontSize: 20),),
                                 SizedBox(height: 10,),
                                  Text(AppLocalizations.of(context).trans('areYouSureDeleteAccount')),
                                ],
                              ),

                              // shape: CircleBorder(),
                              shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              elevation: 30,
                              backgroundColor: Colors.white,
                              actions: <Widget>[
                                InkWell(
                                    onTap:(){
                                      Navigator.of(context).pop();
                                    },

                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: Text(AppLocalizations.of(context).trans('no'),style: TextStyle(fontSize: 20,color: Colors.green[900]),),
                                    )),
                                SizedBox(height: 30,),
                                InkWell(
                                  onTap: ()async{

                                    try {
                                      User user2 = FirebaseAuth.instance.currentUser!;
                                      await user2.delete();
                                    } on FirebaseAuthException catch (e) {
                                      print(e.message.toString());
                                      if (e.code == 'requires-recent-login') {
                                        print(e.message.toString());
                                      }
                                    }
                                     // user.delete();
                                     FirebaseFirestore.instance.collection("users").doc(user.uid).delete();
                                      Application.restartApp(context);

                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Text(AppLocalizations.of(context).trans('yes'),style: TextStyle(fontSize: 20,color: Theme.of(context).primaryColor)),
                                  ),
                                )
                              ],
                            ),
                          );
                          //Addtocart
                        },
                        dense: true,
                        leading: Icon(
                          Icons.perm_device_info,
                          size: 22,
                          color: Theme.of(context).focusColor,
                        ),
                        title: Text(
                          AppLocalizations.of(context).trans('deleteAccount'),
                          style: TextStyle(color: Colors.red,fontSize: 16),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,color: Colors.black26,size: 22,)),
                    ListTile(
                        onTap: () async {
                          LocalStorageService.instance.user = null;
                          await FirebaseAuth.instance.signOut();
                          Application.restartApp(context);
                        },
                        dense: true,
                        leading: Icon(
                          Icons.exit_to_app_sharp,
                          size: 22,
                          color: Theme.of(context).focusColor,
                        ),
                        title: Text(
                          AppLocalizations.of(context).trans('logout'),
                          style: TextStyle(color: Colors.black,fontSize: 16),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,color: Colors.black26,size: 22,)),
                  ],
                ),
              ),
              Expanded(child: SizedBox()),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text("Version 2.1",style: TextStyle(fontSize: 16,color: Colors.black54),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
