// import 'package:flutter/material.dart';
// import 'package:iparkmobileapplication/common/widgets/app_bar.dart';
// import 'package:iparkmobileapplication/features/station/models/station_model.dart';
// import 'package:iparkmobileapplication/features/station/views/charger_card.dart';
// import 'package:iparkmobileapplication/utils/themes/app_colors.dart';
// import 'package:iparkmobileapplication/utils/themes/common_text_styles.dart';

// class AvailableChargers extends StatelessWidget {
//   const AvailableChargers({super.key});

//   static String routeName = "available_chargers";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: ApplicationBar.appbar("Available Chargers",
//           Icon(Icons.arrow_back_ios_new), () => Navigator.pop(context)),
//       body: ListView.builder(
//           itemCount: DummyCharger.dummyChargers.length,
//           itemBuilder: (context, int index) {
//             return ChargerCard(
//               textStyle:DummyCharger.dummyChargers[index].available ==false? CommonTextStyles.textStyle.copyWith(color: MainColors.mainLightThemeColor) :CommonTextStyles.textStyle,
//               flashColor:DummyCharger.dummyChargers[index].available ==false? MainColors.mainLightThemeColor:Colors.white
//               ,cardColor:DummyCharger.dummyChargers[index].available==false? Colors.white :MainColors.mainLightThemeColor,
//               id: DummyCharger.dummyChargers[index].id,
//               chargerName: DummyCharger.dummyChargers[index].chargerName,
//               status:  DummyCharger.dummyChargers[index].available ==false? "Unavailbe":"Available",
//               costPerUnit: DummyCharger.dummyChargers[index].costPerUnit.toString(),
//             );
//           }),
//     );
//   }
// }
