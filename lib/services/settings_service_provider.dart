import 'package:flutter/material.dart';
import 'package:onlineshopping/models/user.dart';
import 'package:provider/provider.dart';

class SettingsServiceProvider extends ChangeNotifier {


  static SettingsServiceProvider of(BuildContext context, {bool listen = false}) =>
      Provider.of<SettingsServiceProvider>(context, listen: listen);


  String locale;

  setLocale(String lang){
    locale = lang;
    notifyListeners();
  }
}