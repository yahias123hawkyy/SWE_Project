import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:iparkmobileapplication/common/widgets/app_bar.dart';
import 'package:iparkmobileapplication/features/wallet/views/wallet_screen.dart';
import 'package:iparkmobileapplication/features/payment_history/views/payment_history_screen.dart';
import 'package:iparkmobileapplication/features/profile_details/views/profile_details_screen.dart';
import 'package:iparkmobileapplication/common/widgets/profile_card.dart';
import 'package:iparkmobileapplication/features/settings/views/settings_screen.dart';
import 'package:iparkmobileapplication/features/vehicle/views/vehichle_card.dart';
import 'package:iparkmobileapplication/features/vehicle/views/vehichle_screen.dart';
import 'package:iparkmobileapplication/utils/themes/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const String nameRoute = "profile_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ApplicationBar.appbar(
            "Profile".tr,
            Icon(Icons.arrow_back_ios_new_outlined),
            () => Navigator.pop(context)),
        body: ListView(
          children: [
            ProfileCard(
              onTap:()=>
                  Navigator.pushNamed(context, ProfileDetailsScreen.nameRoute,arguments: {"title":"Profile Details"}),
              trailingicon: Icon(Icons.arrow_forward_ios),
              title: "Profile details".tr,
              leadingicon: Icon(Icons.person,color: MainColors.mainLightThemeColor,),
            ),
            ProfileCard(
              onTap: ()=> Navigator.pushNamed(
                  context, PaymentHistoryScreen.nameRoute,arguments: {"title":"Payment History"}),
              trailingicon: Icon(Icons.arrow_forward_ios),
              title: "Payment history".tr,
              leadingicon: Icon(Icons.payment_sharp,color: MainColors.mainLightThemeColor,),
            ),
            ProfileCard(
              onTap:()=>
                  Navigator.pushNamed(context, PaymentCardsScreen.nameRoute,arguments: {"title":"Payments Cards"}),
              trailingicon: Icon(Icons.arrow_forward_ios),
              title: "Pyment cards".tr,
              leadingicon: Icon(Icons.card_giftcard,color: MainColors.mainLightThemeColor,),
            ),
            ProfileCard(
              onTap: ()=> Navigator.pushNamed(context, VehichleScreen.nameRoute,arguments: {"title":"My Vehichles "}),
              trailingicon: Icon(Icons.arrow_forward_ios),
              title: "Vehichles",
              leadingicon: Icon(Icons.car_rental,color: MainColors.mainLightThemeColor,),
            ),
             ProfileCard(
              onTap: ()=> Navigator.pushNamed(context, SettingsScreen.nameRoute,arguments: {"title":"Settings"}),
              trailingicon: Icon(Icons.arrow_forward_ios),
              title: "Settings".tr,
              leadingicon: Icon(Icons.settings,color: MainColors.mainLightThemeColor,),
            ),
          ],
        ));
    
  }
}
