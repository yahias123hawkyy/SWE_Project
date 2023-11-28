import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iparkmobileapplication/common/widgets/app_bar.dart';
import 'package:iparkmobileapplication/features/available_chargers/views/available_charger.dart';
import 'package:iparkmobileapplication/features/charger_screen/views/charger_screen.dart';
import 'package:iparkmobileapplication/features/main_screen/views/main_screen.dart';
import 'package:iparkmobileapplication/features/main_screen/views/notifications_page.dart';
import 'package:iparkmobileapplication/features/onboarding_screen/views/onborading_screen.dart';
import 'package:iparkmobileapplication/features/payment_cards_screen/views/payment_cards_screen.dart';
import 'package:iparkmobileapplication/features/payment_history_screen/views/payment_history_screen.dart';
import 'package:iparkmobileapplication/features/profile_details_screens/views/profile_details_screen.dart';
import 'package:iparkmobileapplication/features/profile_tab_screen/views/profile_screen.dart';
import 'package:iparkmobileapplication/features/settings_screen/views/settings_screen.dart';
import 'package:iparkmobileapplication/features/sign_in/sign_in_screen.dart';
import 'package:iparkmobileapplication/features/vehichles_screen/views/vehichles.dart';
import 'package:iparkmobileapplication/localisations/translations/app_translation.dart';
import 'package:iparkmobileapplication/testttt.dart';
import 'package:iparkmobileapplication/utils/themes/app_colors.dart';
import 'package:iparkmobileapplication/utils/themes/themes.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ipark EV',
      locale: Locale('fi', 'FI'),
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      theme: AvailableThemes.lightTheme,
      darkTheme: AvailableThemes.darkTheme,
      themeMode: ThemeMode.light,
      home: const SignInScreen(),
      routes: {
        SignInScreen.nameRoute:(context) => const SignInScreen(),
        OnBoardingScreen.nameRoute:(context) => const OnBoardingScreen(),
        MainScreenView.routeName: (context) => const MainScreenView(),
        NotificationScreen.routeName: (context) => const NotificationScreen(),
        AvailableChargers.routeName: (context) => const AvailableChargers(),
        ChargerScreen.nameRoute: (context) => const ChargerScreen(),
        ProfileScreen.nameRoute: (context) => const ProfileScreen(),
        PaymentCardsScreen.nameRoute: (context) => const PaymentCardsScreen(),
        PaymentHistoryScreen.nameRoute: (context) =>
            const PaymentHistoryScreen(),
        Vehichles.nameRoute: (context) => const Vehichles(),
        ProfileDetailsScreen.nameRoute: (context) =>
            const ProfileDetailsScreen(),
        SettingsScreen.nameRoute: (context) => const SettingsScreen()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationBar.appbar(
          "yahia",
          Icon(
            color: MainColors.mainLightThemeColor,
            Icons.arrow_back,
          ),
          () => print("")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            SvgPicture.asset(
              "assets/images/adjust-svgrepo-com.svg",
              height: 200,
              width: 200,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, MainScreenView.routeName),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
