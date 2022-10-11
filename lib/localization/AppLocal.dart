import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Lang {
  static const String ENGLISH = "en";
  static const String KURDISH = "ku";
  static const String ARABIC = "ar";

  static const List<String> values = [KURDISH ,ARABIC, ENGLISH];
}


class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  Map<String, String> _sentences;

  Future<bool> load() async {
    String data = await rootBundle
        .loadString('assets/lang/${this.locale.languageCode}.json');
    Map<String, dynamic> _result = json.decode(data);

    this._sentences = new Map();
    _result.forEach((String key, dynamic value) {
      this._sentences[key] = value.toString();
    });
    return true;
  }

  String trans(String key) {
    return this._sentences[key] ?? '$key';
  }

  get textDirection{
    if(locale.languageCode == "en" || locale.languageCode == "tr" ) return TextDirection.ltr;
    return TextDirection.rtl;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['ar', 'en','ku'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();

    if(kDebugMode) {
      print("Load ${locale.languageCode}");
    }
    return localizations;
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
