

 import 'package:iparkmobileapplication/features/onboarding_screen/views/eachonboardingScreen.dart';


 abstract class onBoardingPageModel{
    static List<OnboardingPage> pages = [
  OnboardingPage(
    title: 'Welcome to Ipark',
    description: 'the world smartest EV charging application that aim to make a revolution in the EV Charging industry',
    imageUrl: 'assets/images/income_1.png',
  ),
  OnboardingPage(
    title: 'Easy to Use',
    description:
        'Flutter provides a fsimple and intuitive UI develnopment experience.',
    imageUrl: 'assets/images/income_1.png',
  ),
  OnboardingPage(
    title: 'Get Started',
    description:
        'Start building amazing cross-platform apps with Flutter today!',
    imageUrl: 'assets/images/income_1.png',
  ),
];
 }
 