import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iparkmobileapplication/features/station/views/available_chargers.dart';
import 'package:iparkmobileapplication/features/station/views/station_screen.dart';
import 'package:iparkmobileapplication/features/charging_session/providers/charger_provider.dart';
import 'package:iparkmobileapplication/features/charging_session/views/charger_screen.dart';
import 'package:iparkmobileapplication/features/main_screen/views/main_screen.dart';
import 'package:iparkmobileapplication/features/onboarding_screen/views/onborading_screen.dart';
import 'package:iparkmobileapplication/features/wallet/provider/payment_card_provider.dart';
import 'package:iparkmobileapplication/features/wallet/views/wallet_screen.dart';
import 'package:iparkmobileapplication/features/payment_history/views/payment_history_screen.dart';
import 'package:iparkmobileapplication/features/profile_details/providers/image_picker_provider.dart';
import 'package:iparkmobileapplication/features/profile_details/views/profile_details_screen.dart';
import 'package:iparkmobileapplication/features/user_area/views/user_area_screen.dart';
import 'package:iparkmobileapplication/features/qr_scanner/qr_scanner_view.dart';
import 'package:iparkmobileapplication/features/settings/views/settings_screen.dart';
import 'package:iparkmobileapplication/features/auth/views/sign_in_screen.dart';
import 'package:iparkmobileapplication/features/auth/views/sign_up_screen.dart';
import 'package:iparkmobileapplication/features/vehicle/views/vehichle_card.dart';
import 'package:iparkmobileapplication/features/vehicle/views/vehichle_screen.dart';
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
        child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) => GetMaterialApp(
            title: 'Ipark EV',
            locale: const Locale('en'),
            debugShowCheckedModeBanner: false,
            translations: AppTranslations(),
            theme: AvailableThemes.lightTheme,
            darkTheme: AvailableThemes.darkTheme,
            themeMode: ThemeMode.light,
            home: isLoggedin ? const MainScreenView() : const OnBoardingScreen(),
            routes: {
              StationScreen.routeName: (context) => const StationScreen(),
              QRCodeScannerScreen.nameRoute: (context) => QRCodeScannerScreen(),
              SignUpScren.nameRoute: (context) => const SignUpScren(),
              SignInScreen.nameRoute: (context) => const SignInScreen(),
              OnBoardingScreen.nameRoute: (context) => const OnBoardingScreen(),
              MainScreenView.routeName: (context) => const MainScreenView(),
              ChargerScreen.nameRoute: (context) => const ChargerScreen(),
              ProfileScreen.nameRoute: (context) => const ProfileScreen(),
              PaymentCardsScreen.nameRoute: (context) =>
                  const PaymentCardsScreen(),
              PaymentHistoryScreen.nameRoute: (context) =>
                  const PaymentHistoryScreen(),
              VehichleScreen.nameRoute: (context) => const VehichleScreen(),
              ProfileDetailsScreen.nameRoute: (context) =>
                  const ProfileDetailsScreen(),
              SettingsScreen.nameRoute: (context) => const SettingsScreen()
            },
          ),
        ));
  }
}
