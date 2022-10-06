import 'package:flutter/material.dart';

import 'homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (crl) =>HomePage()));
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
                  )
                ],
              )),
        ),
      ),
    );
  }
}
