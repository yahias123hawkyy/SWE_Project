import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalizationService extends GetxService {
  final _locale = 'en'.obs;
  bool _onOfButton =false;

  String get locale => _locale.value;
  bool get onofbuttonGetter =>_onOfButton;

  Future<bool> setLocale(String newLocale,bool onOFButton) async {
    final box = GetStorage();
    await box.write('locale', newLocale);
    await box.write('onOfButton',onOFButton);
    _onOfButton = onOFButton;
    _locale.value = newLocale;
    
    Get.updateLocale(Locale(newLocale));
    return _onOfButton;
  }

  Future<bool> initLocale() async {
    final box = GetStorage();
    if (box.hasData('locale') && box.hasData('onOfButton')) {
      _locale.value = await box.read('locale');
      _onOfButton= await box.read("onOfButton");
      Get.updateLocale(Locale(_locale.value));
    }
    return _onOfButton;
  }
}