import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaWidget extends StatelessWidget {
  const SocialMediaWidget({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
                onTap: (){
                  launch("https://maps.app.goo.gl/Q9hEqy6aKtUsJKsh8");
                },
                child: Image.asset('images/category/location.png',width: 27,)),

          InkWell(
              onTap: (){
                launch("https://autotruckstore.com");
              },
              child: Image.asset('images/category/web.png',width: 30,)),

          InkWell(
              onTap: (){
                launch("https://www.facebook.com/profile.php?id=61566192984414&mibextid=ZbWKwL");
              },
              child: Image.asset('images/category/fb.png',width: 30,)),
            InkWell(
              onTap: (){
                launch("https://www.instagram.com/autotruckstore?igsh=MXBseWk4dWdwaHB4Mg==");
              },
              child: Image.asset('images/category/insta.png',width: 30,)),
            InkWell(
                onTap: (){
                  launch("https://youtube.com/@autotruckstore?si=36CAN1bARrlI1ohN");
                },
                child: Image.asset('images/category/youtube.png',width: 30,)),

            InkWell(
                onTap: (){
                  launch("https://www.tiktok.com/@autotruckstore");
                },
                child: Image.asset('images/category/tiktik.png',width: 30,)),

            InkWell(
                onTap: (){
                  launch("https://www.snapchat.com/add/autotruckstore?share_id=fiUgj91anQY&locale=en-GB");
                },
                child: Image.asset('images/category/snap.png',width: 30,)),
          ],),
      ),
    );
  }
}
