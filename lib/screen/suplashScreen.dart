import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onlineshopping/Widgets/CustomAppButton.dart';
import 'package:onlineshopping/localization/AppLocal.dart';

import 'auth/normal_user_login/login_main_page.dart';
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
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Navigator.push(context, MaterialPageRoute(builder: (crl) =>
        FirebaseAuth.instance.currentUser != null ?
        HomePage():
        MainLoginPage()
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
                    backgroundColor: Colors.red[800],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                  ),
                  SizedBox(height: 150,),
                  Text(text),
                  if(activeConnection == false)
                    CustomAppButton(
                      onTap: (){
                        CheckUserConnection();
                      },
                      color: Theme.of(context).accentColor,
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
