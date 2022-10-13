import 'package:flutter/material.dart';
import 'package:onlineshopping/models/user.dart';
import 'package:provider/provider.dart';

import 'local_storage_service.dart';

class SettingsServiceProvider extends ChangeNotifier {


  static SettingsServiceProvider of(BuildContext context, {bool listen = false}) =>
      Provider.of<SettingsServiceProvider>(context, listen: listen);


  String locale;

  setLocale(String lang){
    locale = lang;
    LocalStorageService.instance.languageCode = lang;
    notifyListeners();
  }
}