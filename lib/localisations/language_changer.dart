import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChangeLanguageProvider extends ChangeNotifier {
  final _box = GetStorage();

  void changeLanguage() {
    if (Get.locale?.languageCode == 'en') {
      _updateLocale(Locale('fi', 'FI'));
    } else {
      _updateLocale(Locale('en', 'US'));
    }
  }

  void _updateLocale(Locale newLocale) {
    Get.updateLocale(newLocale);
    _box.write('locale', newLocale.toLanguageTag());
    notifyListeners();
  }

  String translate(String key) {
    return key.tr;
  }
}