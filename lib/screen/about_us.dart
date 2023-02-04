import 'package:flutter/material.dart';
import 'package:onlineshopping/Widgets/BackArrowWidget.dart';
import 'package:onlineshopping/localization/AppLocal.dart';
import 'package:url_launcher/url_launcher.dart';


class AboutUs extends StatefulWidget {
  const AboutUs({key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: new BackArrowWidget(),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60,),
            // Text(
            //   'About',
            //   style: Theme.of(context).textTheme.headline6.merge(TextStyle(
            //       letterSpacing: 0, color: Theme.of(context).accentColor,fontSize: 25,fontWeight: FontWeight.bold)),
            // ),
            // SizedBox(height: 10,),
            Center(
              child: Image.asset(
                'images/category/logo.png',
                height: 50,
                width: 280,
                //width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 30,),
            Text(
              AppLocalizations.of(context).trans("aboutUsTitle"),

              style: Theme.of(context).textTheme.headline6.merge(TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
            ),
           // SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 20),
              child: Text(
                AppLocalizations.of(context).trans("aboutUsBody"),
                style: Theme.of(context).textTheme.headline6.merge(TextStyle(fontSize: 20)),
              ),
            ),
          ],),
      ),
    );
  }
}


