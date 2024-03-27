import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iparkmobileapplication/features/station_screen/views/available_chargers.dart';
import 'package:iparkmobileapplication/features/station_screen/views/station_screen.dart';
import 'package:iparkmobileapplication/features/charger_screen/providers/charger_provider.dart';
import 'package:iparkmobileapplication/features/charger_screen/views/charger_screen.dart';
import 'package:iparkmobileapplication/features/main_screen/views/main_screen.dart';
import 'package:iparkmobileapplication/features/onboarding_screen/views/onborading_screen.dart';
import 'package:iparkmobileapplication/features/payment_cards_screen/provider/payment_card_provider.dart';
import 'package:iparkmobileapplication/features/payment_cards_screen/views/payment_cards_screen.dart';
import 'package:iparkmobileapplication/features/payment_history_screen/views/payment_history_screen.dart';
import 'package:iparkmobileapplication/features/profile_details_screens/providers/image_picker_provider.dart';
import 'package:iparkmobileapplication/features/profile_details_screens/views/profile_details_screen.dart';
import 'package:iparkmobileapplication/features/profile_tab_screen/views/profile_screen.dart';
import 'package:iparkmobileapplication/features/qr_scanner/qr_scanner_view.dart';
import 'package:iparkmobileapplication/features/settings_screen/views/settings_screen.dart';
import 'package:iparkmobileapplication/features/sign_in/sign_in_screen.dart';
import 'package:iparkmobileapplication/features/sign_in/sign_up_screen.dart';
import 'package:iparkmobileapplication/features/vehichles_screen/views/vehichles.dart';
import 'package:iparkmobileapplication/localisations/localizationservice.dart';
import 'package:iparkmobileapplication/localisations/translations/app_translation.dart';
import 'package:iparkmobileapplication/utils/themes/themes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  Future<bool> checkLoginState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool('isLoggedin') ?? false; // Returns false if not set
  }

  final localizationService = await Get.putAsync(() async {
    final service = LocalizationService();
    await service.initLocale();
    return service;
  });

  final isLoggedIn = await checkLoginState();

  runApp(MyApp(isLoggedin: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final isLoggedin;

  MyApp({required this.isLoggedin});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ChargerProvider()),
          ChangeNotifierProvider(create: (_) => PaymentCardsProvider()),
          ChangeNotifierProvider(create: (_) => ImagePickerProvider())
        ],
        child: GetMaterialApp(
          title: 'Ipark EV',
          locale: const Locale('en'),
          debugShowCheckedModeBanner: false,
          translations: AppTranslations(),
          theme: AvailableThemes.lightTheme,
          darkTheme: AvailableThemes.darkTheme,
          themeMode: ThemeMode.light,
          home: isLoggedin ? const MainScreenView() : const SignUpScren(),
          routes: {
            StationScreen.routeName: (context) => const StationScreen(),
            QRCodeScannerScreen.nameRoute: (context) => QRCodeScannerScreen(),
            SignUpScren.nameRoute: (context) => const SignUpScren(),
            SignInScreen.nameRoute: (context) => const SignInScreen(),
            OnBoardingScreen.nameRoute: (context) => const OnBoardingScreen(),
            MainScreenView.routeName: (context) => const MainScreenView(),
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
