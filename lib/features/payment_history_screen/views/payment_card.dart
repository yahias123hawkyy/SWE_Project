import 'package:flutter/material.dart';
import 'package:iparkmobileapplication/utils/themes/app_colors.dart';

class PaymentCard extends StatelessWidget {
  final String placeTitle;
  final int cost;
  final DateTime datatime;

  const PaymentCard(
      {required this.placeTitle,
      required this.cost,
      required this.datatime,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
        decoration: BoxDecoration(
            border: Border.all(width: 0.5),
            borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          title: Text(
            placeTitle,
            style: textStyle,
          ),
          leading: Text(cost.toString(), style: textStyle),
          trailing: Text("21/20/12", style: textStyle),
        ));
  }
}

TextStyle textStyle =
    TextStyle(fontSize: 18, color: MainColors.mainLightThemeColor);
