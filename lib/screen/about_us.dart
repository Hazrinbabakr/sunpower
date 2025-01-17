import 'package:flutter/material.dart';
import 'package:sunpower/Widgets/BackArrowWidget.dart';
import 'package:sunpower/localization/AppLocal.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart';


class AboutUs extends StatefulWidget {
  const AboutUs({key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  // final UrlLauncherPlatform launcher = UrlLauncherPlatform.instance;
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
            //   style: Theme.of(context).textTheme.titleLarge.merge(TextStyle(
            //       letterSpacing: 0, color: Theme.of(context).colorScheme.secondary,fontSize: 25,fontWeight: FontWeight.bold)),
            // ),
            // SizedBox(height: 10,),
            Center(
              child: Image.asset(
                'images/category/logo.png',
                height: 50,
                width: 280,
                //width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 30,),
            Text(
              AppLocalizations.of(context).trans("aboutUsTitle"),

              style: Theme.of(context).textTheme.titleLarge!.merge(TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
            ),
           // SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 20),
              child: Text(
                AppLocalizations.of(context).trans("aboutUsBody"),
                style: Theme.of(context).textTheme.titleLarge!.merge(TextStyle(fontSize: 20)),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // RichText(
                  //
                  //   text: TextSpan(
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.bold
                  //     ),
                  //     children: [
                  //       TextSpan(
                  //         text: "Contact",
                  //         style: TextStyle(color: Colors.black, fontSize: 22),
                  //       ),
                  //       TextSpan(
                  //         text: "Us",
                  //         style: TextStyle(color: Colors.orange, fontSize: 22),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Text(AppLocalizations.of(context).trans("contact_us"),style:TextStyle(color: Colors.black, fontSize: 22,fontWeight: FontWeight.bold)),
                  Divider(height: 20,thickness: 0.4,),
                  Text(
                    AppLocalizations.of(context).trans("phoneNumbers"),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildColoredPhoneNumber('0772', '277 7000'),
                          _buildColoredPhoneNumber('0775', '577 7000'),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildColoredPhoneNumber('0750', '077 7000'),
                          _buildColoredPhoneNumber('0750', '297 7000'),
                        ],
                      ),
                    ],
                  ),
                  Divider(height: 20,thickness: 0.1,indent: 25,endIndent: 25,),
                  Text(
                    AppLocalizations.of(context).trans("email"),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      _launchEmail("sales@autotruckstore.com");
                    },
                    child: Text(
                      'sales@autotruckstore.com',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Divider(height: 20,thickness: 0.1,indent: 25,endIndent: 25,),
                  Text(
                    AppLocalizations.of(context).trans("website"),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      launch('https://autotruckstore.com');
                    },
                    child: Text(
                      'www.autotruckstore.com',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),

          ],),
      ),
    );
  }


  void _launchPhone(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }
  void _launchEmail(String email) async {
    final Uri emailUri = Uri(
        scheme: 'mailto',
        path: email
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }
  void _launchWebsite(String url) async {
    final Uri websiteUri = Uri.parse(url);
    if (await canLaunchUrl(websiteUri)) {
      await launchUrl(websiteUri);
    }
  }


  // void _launchPhone(String phoneNumber) async {
  //   //final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
  //   final String phoneUrl = "tel:${phoneNumber}";
  //   if (await launcher.canLaunch(phoneUrl)) {
  //     await _launchIOS(phoneUrl);
  //   }
  // }
  // _launchIOS(String url) async {
  //   await launcher.launch(
  //       url,
  //       useSafariVC: false,
  //       useWebView: false,
  //       enableJavaScript: false,
  //       enableDomStorage: false,
  //       universalLinksOnly: false,
  //       headers: {},
  //   );
  // }
  // void _launchEmail(String email) async {
  //   final String emailUrl = "mailto:${email}";
  //   if (await launcher.canLaunch(emailUrl)) {
  //     await _launchIOS(emailUrl);
  //   }
  // }
  // void _launchWebsite(String url) async {
  //   if (await launcher.canLaunch(url)) {
  //     await _launchIOS(url);
  //   }
  // }

  Widget _buildColoredPhoneNumber(String orangePart, String blackPart) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: GestureDetector(
        onTap: (){
          _launchPhone("$orangePart$blackPart".replaceAll(' ', ''));
        },
        child: RichText(
          text: TextSpan(
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
            children: [
              TextSpan(
                text: orangePart,
                style: TextStyle(color: Colors.orange, fontSize: 14),
              ),
              TextSpan(
                text: " $blackPart",
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


