import 'package:get/get.dart';
import 'package:iparkmobileapplication/localisations/translations/en_translation.dart';
import 'package:iparkmobileapplication/localisations/translations/finnish_translation.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': ENGAppTransaltion.englishTranslation,
        'fi_FI': FinnishAppTranslation.finnishAppTranslation
      };
}
