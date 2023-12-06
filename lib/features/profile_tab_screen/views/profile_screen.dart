import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:iparkmobileapplication/common/widgets/app_bar.dart';
import 'package:iparkmobileapplication/features/payment_cards_screen/views/payment_cards_screen.dart';
import 'package:iparkmobileapplication/features/payment_history_screen/views/payment_history_screen.dart';
import 'package:iparkmobileapplication/features/profile_details_screens/views/profile_details_screen.dart';
import 'package:iparkmobileapplication/common/widgets/profile_card.dart';
import 'package:iparkmobileapplication/features/settings_screen/views/settings_screen.dart';
import 'package:iparkmobileapplication/features/vehichles_screen/views/vehichles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const String nameRoute = "profile_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ApplicationBar.appbar(
            "profile".tr,
            Icon(Icons.arrow_back_ios_new_outlined),
            () => Navigator.pop(context)),
        body: ListView(
          children: [
            ProfileCard(
              onTap:()=>
                  Navigator.pushNamed(context, ProfileDetailsScreen.nameRoute,arguments: {"title":"Profile Details"}),
              trailingicon: Icon(Icons.arrow_forward_ios),
              title: "profile details".tr,
              leadingicon: Icon(Icons.person),
            ),
            ProfileCard(
              onTap: ()=> Navigator.pushNamed(
                  context, PaymentHistoryScreen.nameRoute,arguments: {"title":"Payment History"}),
              trailingicon: Icon(Icons.arrow_forward_ios),
              title: "payment history".tr,
              leadingicon: Icon(Icons.person),
            ),
            ProfileCard(
              onTap:()=>
                  Navigator.pushNamed(context, PaymentCardsScreen.nameRoute,arguments: {"title":"Payments Cards"}),
              trailingicon: Icon(Icons.arrow_forward_ios),
              title: "payment cards".tr,
              leadingicon: Icon(Icons.person),
            ),
            ProfileCard(
              onTap: ()=> Navigator.pushNamed(context, Vehichles.nameRoute,arguments: {"title":"My Vehichles "}),
              trailingicon: Icon(Icons.arrow_forward_ios),
              title: "My Vehichle",
              leadingicon: Icon(Icons.person),
            ),
             ProfileCard(
              onTap: ()=> Navigator.pushNamed(context, SettingsScreen.nameRoute,arguments: {"title":"Settings"}),
              trailingicon: Icon(Icons.arrow_forward_ios),
              title: "settings".tr,
              leadingicon: Icon(Icons.person),
            ),
          ],
        ));
    
  }
}
