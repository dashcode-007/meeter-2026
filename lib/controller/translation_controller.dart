import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeLanguageController {
  static void changeLanguage(var languageCode, var countryCode) {
    var locale = Locale(languageCode, countryCode);
    Get.updateLocale(locale);
  }
}
