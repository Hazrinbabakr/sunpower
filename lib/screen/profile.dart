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
import 'package:sunpower/services/local_storage_service.dart';

import 'about_us.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool guest =true;
  User user;
  FirebaseAuth _auth;
  DocumentSnapshot userInfo;
  // Future getUserInfo()async{
  //   userInfo= await FirebaseFirestore.instance.collection("users").doc(user.uid).get();
  //
  //   setState(() {
  //    name= userInfo.data()['username'];
  //    phone= userInfo.data()['phone'];
  //    address= userInfo.data()['address'];
  //
  //    //print(name);
  //
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth= FirebaseAuth.instance;
    user=_auth.currentUser;
   // getUserInfo();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // drawer: DrawerWidget(),
      body:
          SingleChildScrollView(
      //  scrollDirection: Axis.vertical,
//              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Column(
         
          children: <Widget>[
            //guest?
            ProfileAvatarWidget(
              userID: user?.uid??"",
              //isGuest: true,
            ),
          SizedBox(height: 120,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
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
                      trailing: Icon(Icons.arrow_forward_ios)),
                  ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ContactUS()));





                      },
                      dense: true,
                      leading: Icon(
                        Icons.contact_phone_outlined,
                        size: 22,
                        color: Theme.of(context).focusColor,
                      ),
                      title: Text(AppLocalizations.of(context).trans('contact_us'),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios)),
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
                      trailing: Icon(Icons.arrow_forward_ios)),
                  // ListTile(
                  //     onTap: () {
                  //     },
                  //     dense: true,
                  //     leading: Icon(
                  //       Icons.feedback_outlined,
                  //       size: 22,
                  //       color: Theme.of(context).focusColor,
                  //     ),
                  //     title: Text(AppLocalizations.of(context).trans('feedback'),
                  //       style: Theme.of(context).textTheme.subtitle1,
                  //     ),
                  //     trailing: Icon(Icons.arrow_forward_ios)),

                ],
              ),
            ),
            SizedBox(height: 120,),

            InkWell(
              onTap: () async {
                LocalStorageService.instance.user = null;
                await FirebaseAuth.instance.signOut();
                Application.restartApp(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                Icon(
                    Icons.exit_to_app_sharp,
                    color: Theme.of(context).accentColor,
                  size: 25,
                  //  color: Theme.of(context).focusColor.withOpacity(1),
                ),
                SizedBox(width: 10,),
                Text(AppLocalizations.of(context).trans('logout'),
                    style: TextStyle(color: Theme.of(context).accentColor,fontSize: 18)
                ),
              ],
              ),
            ),
            SizedBox(height:  MediaQuery.of(context).size.height - 710,),
            InkWell(
                onTap: (){
                //  launch("https://www.facebook.com/vinforitsolution?mibextid=LQQJ4d");
                },
                child: Text('Powered by Vin Agency',style: TextStyle(fontSize: 12),))
          ],
        ),
      ),
    );
  }
}
