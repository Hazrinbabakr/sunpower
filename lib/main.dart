// ignore_for_file: prefer_const_constructors
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sunpower/app/Application.dart';
import 'package:sunpower/localization/AppLocal.dart';
import 'package:sunpower/screen/suplashScreen.dart';
import 'package:provider/provider.dart';

import 'localization/kurdish_material_localization.dart';
import 'services/local_storage_service.dart';
import 'services/notification_helper.dart';
import 'services/settings_service_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await LocalStorageService.instance.init();
  notificationHelper.firebaseCloudMessagingListeners();
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
                  accentColor: Colors.red[900],
                  fontFamily: 'NRT',
              ),
              home: SplashScreen(),//SignUpMainPage(),
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


