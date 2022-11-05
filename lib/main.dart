// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:onlineshopping/app/Application.dart';
import 'package:onlineshopping/localization/AppLocal.dart';
import 'package:onlineshopping/screen/auth/signup_normal_user/sign_up_main_page.dart';
import 'package:onlineshopping/screen/homepage.dart';
import 'package:onlineshopping/screen/suplashScreen.dart';
import 'package:provider/provider.dart';

import 'localization/kurdish_material_localization.dart';
import 'screen/auth/normal_user_login/login_main_page.dart';
import 'services/local_storage_service.dart';
import 'services/settings_service_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await LocalStorageService.instance.init();
  var res = FirebaseMessaging();
  res.getToken().then((value) {
    print("value ${value}");
  });
  if(LocalStorageService.instance.languageCode == null){
    LocalStorageService.instance.languageCode = "en";
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ListenableProvider(
      create: (BuildContext context) {
        return SettingsServiceProvider();
      },
      child: Application(
        child: Consumer<SettingsServiceProvider>(
          builder: (context,settings,child){
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  primaryColor: Colors.white,
                  accentColor: Colors.red[900]
              ),
              home: FirebaseAuth.instance.currentUser != null ?
                  HomePage():
              MainLoginPage(),//SignUpMainPage(),
              builder: (context, child) {
                if (AppLocalizations.of(context).locale.languageCode ==
                    "ku") {
                  child = Directionality(
                      textDirection: TextDirection.rtl, child: child);
                }
                return child;
              },
              localizationsDelegates: [
                const AppLocalizationsDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate,
                KurdishMaterialLocalizations.delegate,
                KurdishCupertinoLocalization.delegate
              ],
              supportedLocales: Lang.values.map((e) => Locale(e)).toList(),
              locale: Locale(LocalStorageService.instance.languageCode),
              //Test()
            );
          },
        ),
      ),
    );
  }
}


