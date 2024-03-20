import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iparkmobileapplication/common/widgets/app_bar.dart';
import 'package:iparkmobileapplication/features/available_chargers/views/available_charger.dart';
import 'package:iparkmobileapplication/features/available_chargers/views/test_available_chargers.dart';
import 'package:iparkmobileapplication/features/charger_screen/views/charger_screen.dart';
import 'package:iparkmobileapplication/features/main_screen/views/main_screen.dart';
import 'package:iparkmobileapplication/features/main_screen/views/notifications_page.dart';
import 'package:iparkmobileapplication/features/onboarding_screen/views/onborading_screen.dart';
import 'package:iparkmobileapplication/features/payment_cards_screen/provider/payment_card_provider.dart';
import 'package:iparkmobileapplication/features/payment_cards_screen/views/payment_cards_screen.dart';
import 'package:iparkmobileapplication/features/payment_history_screen/views/payment_history_screen.dart';
import 'package:iparkmobileapplication/features/profile_details_screens/providers/image_picker_provider.dart';
import 'package:iparkmobileapplication/features/profile_details_screens/views/profile_details_screen.dart';
import 'package:iparkmobileapplication/features/profile_tab_screen/views/profile_screen.dart';
import 'package:iparkmobileapplication/features/qr_scanner/qr_scanner_view.dart';
import 'package:iparkmobileapplication/localisations/localizationservice.dart';
import 'package:iparkmobileapplication/features/settings_screen/views/settings_screen.dart';
import 'package:iparkmobileapplication/features/sign_in/sign_in_screen.dart';
import 'package:iparkmobileapplication/features/sign_in/sign_up_screen.dart';
import 'package:iparkmobileapplication/features/vehichles_screen/views/vehichles.dart';
import 'package:iparkmobileapplication/localisations/translations/app_translation.dart';
import 'package:iparkmobileapplication/utils/themes/app_colors.dart';
import 'package:iparkmobileapplication/utils/themes/themes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

 
    await GetStorage.init();


    final localizationService = await Get.putAsync(() async {
    final service = LocalizationService();
    await service.initLocale();
    return service;
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => PaymentCardsProvider()),
          ChangeNotifierProvider(create: (_) =>ImagePickerProvider())
        ],
        child: GetMaterialApp(
          title: 'Ipark EV',
          locale: Locale('en'),
          debugShowCheckedModeBanner: false,
          translations: AppTranslations(),
          theme: AvailableThemes.lightTheme,
          darkTheme: AvailableThemes.darkTheme,
          themeMode: ThemeMode.light,
          home: const MainScreenView(),
          routes: {
            TestAvailableChargers.routeName:  (context) => TestAvailableChargers(),
            QRCodeScannerScreen.nameRoute: (context) => QRCodeScannerScreen(),
            SignUpScren.nameRoute: (context) => const SignUpScren(),
            SignInScreen.nameRoute: (context) => const SignInScreen(),
            OnBoardingScreen.nameRoute: (context) => const OnBoardingScreen(),
            MainScreenView.routeName: (context) => const MainScreenView(),
            NotificationScreen.routeName: (context) =>
                const NotificationScreen(),
            AvailableChargers.routeName: (context) => const AvailableChargers(),
            ChargerScreen.nameRoute: (context) => const ChargerScreen(),
            ProfileScreen.nameRoute: (context) => const ProfileScreen(),
            PaymentCardsScreen.nameRoute: (context) =>
                const PaymentCardsScreen(),
            PaymentHistoryScreen.nameRoute: (context) =>
                const PaymentHistoryScreen(),
            Vehichles.nameRoute: (context) => const Vehichles(),
            ProfileDetailsScreen.nameRoute: (context) =>
                const ProfileDetailsScreen(),
            SettingsScreen.nameRoute: (context) => const SettingsScreen()
          },
        ));
  }
}
