

 import 'package:iparkmobileapplication/features/onboarding_screen/views/eachonboardingScreen.dart';


 abstract class onBoardingPageModel{
    static List<OnboardingPage> pages = [
  OnboardingPage(
    title: 'Welcome to Ipark',
    description: 'This is a sample onboarding screen for Flutter.',
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
 