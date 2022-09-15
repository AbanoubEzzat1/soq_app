// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/recources/language_manger.dart';

const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
String userToken = "userToken";
const String PREFS_KEY_ON_BOARDING_SCREEN_VIEWED =
    "PREFS_KEY_ON_BOARDING_SCREEN_VIEWED";
const String PREFS_KEY_IS_USER_LOGGED_IN = "PREFS_KEY_IS_USER_LOGGED_IN";

class AppPreferences {
  final SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(PREFS_KEY_LANG);

    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.ENGLISG.getValue();
    }
  }

  Future<void> changeAppLanguage() async {
    String currentLang = await getAppLanguage();

    if (currentLang == LanguageType.ARABIC.getValue()) {
      // set english
      _sharedPreferences.setString(
          PREFS_KEY_LANG, LanguageType.ENGLISG.getValue());
    } else {
      // set arabic
      _sharedPreferences.setString(
          PREFS_KEY_LANG, LanguageType.ARABIC.getValue());
    }
  }

  Future<Locale> getLocal() async {
    String currentLang = await getAppLanguage();

    if (currentLang == LanguageType.ARABIC.getValue()) {
      return ARABIC_LOCAL;
    } else {
      return ENGLISH_LOCAL;
    }
  }

  Future<bool> setUserToken(String value) async {
    return await _sharedPreferences.setString(userToken, value);
  }

  Future<String> getUserToken() async {
    return _sharedPreferences.getString(userToken) ?? "";
  }

  Future<bool> removeToken() async {
    return await _sharedPreferences.remove(userToken).catchError((error) {
      if (kDebugMode) {
        print("Remove Token Error");
        print(error);
      }
      return error;
    });
  }

  //onBoardingScreen
  Future<void> setOnBoardingScreenViewed() async {
    _sharedPreferences.setBool(PREFS_KEY_ON_BOARDING_SCREEN_VIEWED, true);
  }

  Future<bool> isOnBoardingScreenViewed() async {
    return _sharedPreferences.getBool(PREFS_KEY_ON_BOARDING_SCREEN_VIEWED) ??
        false;
  }

  //Login
  Future<void> setUserLoggedIn() async {
    _sharedPreferences.setBool(PREFS_KEY_IS_USER_LOGGED_IN, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(PREFS_KEY_IS_USER_LOGGED_IN) ?? false;
  }

  Future<void> removeUserLoggedIn() async {
    _sharedPreferences.remove(PREFS_KEY_IS_USER_LOGGED_IN);
  }
}
