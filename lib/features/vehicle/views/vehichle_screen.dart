import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iparkmobileapplication/features/vehicle/views/vehichle_card.dart';

class VehichleScreen extends StatelessWidget {
  const VehichleScreen({super.key});

    static const nameRoute = "vehichles_screen";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: VehichleCard(),
    );
  }
}