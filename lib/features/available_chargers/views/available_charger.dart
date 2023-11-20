import 'package:flutter/material.dart';
import 'package:iparkmobileapplication/common/widgets/app_bar.dart';
import 'package:iparkmobileapplication/features/available_chargers/models/charger_model.dart';
import 'package:iparkmobileapplication/features/available_chargers/views/charger_card.dart';

class AvailableChargers extends StatelessWidget {
  const AvailableChargers({super.key});

  static String routeName = "available_chargers";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationBar.appbar("Available Chargers",
          Icon(Icons.arrow_back_ios_new), () => Navigator.pop(context)),
      body: ListView.builder(
          itemCount: DummyCharger.dummyChargers.length,
          itemBuilder: (context, int index) {
            return ChargerCard(
              id: DummyCharger.dummyChargers[index].id,
              chargerName: DummyCharger.dummyChargers[index].chargerName,
              status:  DummyCharger.dummyChargers[index].available ==false? "Unavailbe":"Available",
              costPerUnit: DummyCharger.dummyChargers[index].costPerUnit.toString(),
            );
          }),
    );
  }
}
