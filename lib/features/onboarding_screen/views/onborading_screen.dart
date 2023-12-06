import 'package:flutter/material.dart';
import 'package:iparkmobileapplication/common/widgets/app_bar.dart';
import 'package:iparkmobileapplication/features/main_screen/views/main_screen.dart';
import 'package:iparkmobileapplication/features/onboarding_screen/models/onBorading_model.dart';
import 'package:iparkmobileapplication/features/onboarding_screen/views/eachonboardingScreen.dart';
import 'package:iparkmobileapplication/features/sign_in/sign_in_screen.dart';
import 'package:iparkmobileapplication/features/sign_in/sign_up_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  static const String nameRoute = "onBoarding_screen";

  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationBar.appbar("Welcome", Icon(null), null),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: PageView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return onBoardingPageModel.pages[index];
              },
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, SignUpScren.nameRoute),
            child: Text("Get Stated",
                style: TextStyle(fontFamily: "Inter", color: Colors.white)),
            style: ElevatedButton.styleFrom(
                fixedSize:
                    Size.fromWidth(MediaQuery.of(context).size.width * 0.44),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6.0)))),
          )
        ],
      ),
    );
  }
}
