// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum LanguageType { ENGLISG, ARABIC }

const String ENGLISH = "en";
const String ARABIC = "ar";

const String ASSET_PATH_LOCALISATIONS = "assets/translations";

const Locale ARABIC_LOCAL = Locale("ar", "SA");
const Locale ENGLISH_LOCAL = Locale("en", "US");

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.ENGLISG:
        return ENGLISH;
      case LanguageType.ARABIC:
        return ARABIC;
    }
  }
}