import 'dart:convert';

import 'package:sunpower/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LocalStorageService {
  static const String AccessToken = "access_token";
  static const String AppLanguageKey = "app_lang";
  static const String UserKey = "User";
//  static const

  static LocalStorageService _instance = LocalStorageService._internal();
  static late SharedPreferences _preferences;

  static LocalStorageService get instance => _instance;

  LocalStorageService._internal();

  factory LocalStorageService() {
    return _instance;
  }
  init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Language Code
  String? _languageCode;
  String? get languageCode => _languageCode ?? _getFromDisk(AppLanguageKey);

  set languageCode(String? value) {
    _languageCode = value;
    _saveToDisk(AppLanguageKey, value);
  }

  AppUser? _user;
  AppUser? get user {
    if (_user != null) return _user;
    String? res = _getFromDisk(UserKey);
    if (res == null) return null;
    return AppUser.fromJson(json.decode(res));
  }

  set user(AppUser? value) {
    _user = value;
    _saveToDisk(UserKey, value == null ? null : json.encode(value.toJson()));
  }


  dynamic _getFromDisk(String key) {
    var value = _preferences.get(key);
    if (value is String)
      return value == "" ? null : value;
    else
      return value;
  }

  void _saveToDisk<T>(String key, content) {
    if (content == null) _preferences.remove(key);
    if (content is String) {
      _preferences.setString(key, content);
    }
    if (content is bool) {
      _preferences.setBool(key, content);
    }
    if (content is int) {
      _preferences.setInt(key, content);
    }
    if (content is double) {
      _preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences.setStringList(key, content);
    }
  }


}
