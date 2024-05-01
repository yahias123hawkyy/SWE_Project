import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iparkmobileapplication/utils/themes/app_colors.dart';

class PaymentCard extends StatelessWidget {
  final int amount;
  final String date;
  final String? userId;
  final String stationName;
  final int chargerId;

  const PaymentCard(
      {super.key,
      required this.amount,
      required this.date,
       this.userId,
      required this.chargerId,
      required this.stationName});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
        child: Card(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.w),
              width: 10.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/images/done.png"),
                  SizedBox(
                    width: 20.w,
                  ),
                   Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                    Text(stationName,
                        style:  TextStyle(fontSize: 11.w,color: Colors.black,fontWeight: FontWeight.bold)),
                    Text(date.substring(0,10), style: TextStyle(color: Colors.black)),
                    Text(amount.toString()+ " EUR", style: TextStyle(color: Colors.black)),
                    Text("Charger Id : "+chargerId.toString(), style: TextStyle(color: Colors.black)),
                  ])
                ],
              ),
            )));
  }
}

TextStyle textStyle =
    TextStyle(fontSize: 18, color: MainColors.mainLightThemeColor);
