import 'package:flutter/material.dart';

class SocialMediaWidget extends StatelessWidget {
  const SocialMediaWidget({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 225,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        Image.asset('images/category/web.png',width: 30,),
        Image.asset('images/category/fb.png',width: 30,),
        Image.asset('images/category/insta.png',width: 30,),
          Image.asset('images/category/snap.png',width: 30,),



        ],),
    );
  }
}
