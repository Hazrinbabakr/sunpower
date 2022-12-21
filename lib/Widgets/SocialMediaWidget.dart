import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaWidget extends StatelessWidget {
  const SocialMediaWidget({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 225,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [


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
              launch("https://wa.link/1eanyc");
            },
            child: Image.asset('images/category/snap.png',width: 30,)),
    //
    // InkWell(
    // onTap: (){
    //   launch("tel:0${7501440058}");
    // },
    // child: Icon(Icons.phone_outlined)),
        ],),
    );
  }
}
