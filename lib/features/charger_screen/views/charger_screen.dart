import 'package:flutter/material.dart';
import 'package:iparkmobileapplication/common/widgets/app_bar.dart';
import 'package:iparkmobileapplication/features/charger_screen/models/charger.dart';
import 'package:iparkmobileapplication/utils/themes/app_colors.dart';

class ChargerScreen extends StatelessWidget {
  const ChargerScreen({super.key});


  static String nameRoute= "charger_screen";



  @override
  Widget build(BuildContext context) {


      final args = ModalRoute.of(context)!.settings.arguments as Map;




    return  Scaffold(
      backgroundColor: MainColors.backgroundColor,
      appBar: ApplicationBar.appbar(args["charger_name"], Icon(Icons.arrow_back), ()=> Navigator.pop(context)),
    );
  }
}


