import 'package:flutter/material.dart';
import 'package:iparkmobileapplication/common/widgets/app_bar.dart';

class Vehichles extends StatelessWidget {

  const Vehichles({super.key});

    static const nameRoute = "vehichles_screen";

 @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as Map;

    return  Scaffold(
      appBar: ApplicationBar.appbar(args["title"], Icon(Icons.arrow_back), ()=>Navigator.pop(context)),
    );
  }
}