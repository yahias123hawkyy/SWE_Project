import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iparkmobileapplication/features/charger_screen/models/charger.dart';
import 'package:iparkmobileapplication/features/charger_screen/views/charger_screen.dart';
import 'package:iparkmobileapplication/utils/themes/app_colors.dart';

class ChargerCard extends StatelessWidget {


  final chargerName;
  final status;
  final costPerUnit;
  final id;

  const ChargerCard(
      {super.key,
      required this.id,
      required this.chargerName,
      required this.costPerUnit,
      required this.status});

  

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: ()=> handler(id,context,chargerName),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.16,
        margin: EdgeInsets.symmetric(
            horizontal: mediaQuery.width * 0.05, vertical: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: MainColors.mainLightThemeColor),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: SvgPicture.asset(
                  "assets/images/electricity-svgrepo-com.svg",
                  colorFilter: ColorFilter.mode(
                      MainColors.backgroundColor, BlendMode.srcIn),
                ),
                height: mediaQuery.height*0.15,
                width: mediaQuery.width*0.25,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Status:", style: chargerCardtextStyle),
                        SizedBox(
                          width: mediaQuery.width * 0.09,
                        ),
                        Text(status, style: chargerCardtextStyle)
                      ],
                    ),
                    Row(
                      children: [
                        Text("Name:", style: chargerCardtextStyle),
                        SizedBox(
                          width: mediaQuery.width * 0.1,
                        ),
                        Text(chargerName, style: chargerCardtextStyle)
                      ],
                    ),
                    Row(
                      children: [
                        Text("Cost/Unit:", style: chargerCardtextStyle),
                        SizedBox(
                          width: mediaQuery.width * 0.02,
                        ),
                        Text(costPerUnit+ " cnt/kwt", style: chargerCardtextStyle)
                      ],
                    )
                  ],
                ),
              )
            ]),
      ),
    );
  }
}

TextStyle chargerCardtextStyle = TextStyle(
    color: MainColors.chargerCardTextColor,
    fontSize: 18,
    fontWeight: FontWeight.bold);


handler(int id,context,String chagerName){

 dynamic filteredList;

  filteredList= Dummychargerinfo.dummychargerinfo.where((element) => element.id == id).toList();
   
   Navigator.pushNamed(context, ChargerScreen.nameRoute,arguments: {"list":filteredList,
   "charger_name": chagerName});
   
}