import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sunpower/Widgets/CustomAppButton.dart';
import 'package:sunpower/localization/AppLocal.dart';
import 'package:sunpower/models/user.dart';
import 'package:sunpower/services/brands_service.dart';
import 'package:sunpower/services/local_storage_service.dart';
import 'homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool activeConnection = true;
  String text = '';
  // ignore: non_constant_identifier_names
  Future CheckUserConnection() async {
      final result = await InternetAddress.lookup('8.8.8.8');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if(FirebaseAuth.instance.currentUser != null){
          var res = await FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get();
          if(res.exists){
            LocalStorageService.instance.user = AppUser.fromJson(res.data() as Map<String,dynamic>);
          } else {
            FirebaseAuth.instance.signOut();
          }
        }

        
        Navigator.push(context, MaterialPageRoute(builder: (crl) =>
        //FirebaseAuth.instance.currentUser != null ?
        HomePage()
            //:
        //MainLoginPage()
        ));
      }
      else {
        activeConnection = false;
        if(mounted)
        setState(() {

        });
      }

  }

  @override
  void initState() {
    super.initState();
    BrandsService.init();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(seconds: 2),(){
        CheckUserConnection();
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
    //  backgroundColor:Color(0xff399642),
      body: SafeArea(
        child: Container(
          height: height,
          decoration: BoxDecoration(
            // image: DecorationImage(
            //   //  alignment: Alignment.topCenter,
            //     fit: BoxFit.cover,
            //     image: AssetImage("assets/logo.png"))
          ),
          child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height / 3,
                  ),
                  Center(
                    child: Container(
                      child: Image.asset(
                        'images/category/logo.png',
                        width: width * 0.7,
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  CircularProgressIndicator(
                    //backgroundColor: Colors.red[800],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                  ),
                  SizedBox(height: 150,),
                  Text(text),
                  if(activeConnection == false)
                    CustomAppButton(
                      onTap: (){
                        CheckUserConnection();
                      },
                      color: Theme.of(context).colorScheme.primary,
                      elevation: 0,
                      borderRadius: 5,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8
                      ),
                      child: Text(AppLocalizations.of(context).trans("tryAgain"),style: TextStyle(color: Colors.white,fontSize: 16),),
                    )
                ],
              )),
        ),
      ),
    );
  }
}
