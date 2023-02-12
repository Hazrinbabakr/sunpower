import 'package:flutter/material.dart';
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
                  launch("https://maps.google.com?q=Sun%20Power%20Company,%20North%20Industrial%20Area%20G33,%20Erbil%2044001&ftid=0x400721bde5c36167:0x3da92b465a7893c&hl=en-US&gl=us&entry=gps&coh=166245&lucs=47057720&g_st=ic");
                },
                child: Image.asset('images/category/location.png',width: 27,)),

          InkWell(
              onTap: (){

              },
              child: Image.asset('images/category/web.png',width: 30,)),

          InkWell(
              onTap: (){
                //   print('whatsapp');
                 launch("https://m.facebook.com/SunPowerCompany/?refsrc=deprecated&_rdr");

              },
              child: Image.asset('images/category/fb.png',width: 30,)),
          InkWell(
              onTap: (){
launch("https://instagram.com/sunpower_iraq?igshid=MWI4MTIyMDE=");
              },
              child: Image.asset('images/category/insta.png',width: 30,)),



            InkWell(
                onTap: (){
                  launch("https://youtube.com/@sunpowercompany");
                },
                child: Image.asset('images/category/youtube.png',width: 30,)),

            InkWell(
                onTap: (){
                  launch("https://www.tiktok.com/@sunpowercompany");
                },
                child: Image.asset('images/category/tiktik.png',width: 30,)),

            InkWell(
                onTap: (){
                  launch("https://t.snapchat.com/uZ5Cxe5q");
                },
                child: Image.asset('images/category/snap.png',width: 30,)),
      //
      // InkWell(
      // onTap: (){
      //   launch("tel:0${7501440058}");
      // },
      // child: Icon(Icons.phone_outlined)),
          ],),
      ),
    );
  }
}
