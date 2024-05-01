import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iparkmobileapplication/features/charging_session/models/chargingSession_model.dart';
import 'package:iparkmobileapplication/features/charging_session/views/charger_screen.dart';

class ChargerCard extends StatelessWidget {


  final String chargerName;
  final status;
  final costPerUnit;
  final id;


  final Color flashColor;
  final Color cardColor;
  final TextStyle textStyle;

  const ChargerCard(
      {super.key,
      required this.id,
      required this.chargerName,
      required this.costPerUnit,
      required this.status, required this.flashColor, required this.cardColor, required this.textStyle});

  

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;

    return GestureDetector(
      // onTap: ()=> handler(id,context,chargerName),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.16,
        margin: EdgeInsets.symmetric(
            horizontal: mediaQuery.width * 0.05, vertical: 20),
        decoration: BoxDecoration(
          border: Border.all(width: 0.2),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: cardColor),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: mediaQuery.height*0.15,
                  width: mediaQuery.width*0.25,
                  child: SvgPicture.asset(
                    "assets/images/electricity-svgrepo-com.svg",
                    colorFilter: ColorFilter.mode( 
                       flashColor, BlendMode.srcIn),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Status:", style: textStyle),
                            SizedBox(
                              width: mediaQuery.width * 0.09,
                            ),
                            Text(status, style: textStyle)
                          ],
                        ),
                        Row(
                          children: [
                            Text("Name:", style: textStyle),
                            SizedBox(
                              width: mediaQuery.width * 0.1,
                            ),
                            Text(chargerName, style: textStyle)
                          ],
                        ),
                        Row(
                          children: [
                            Text("Cost/Unit:", style: textStyle),
                            SizedBox(
                              width: mediaQuery.width * 0.02,
                            ),
                            Text(costPerUnit+ " cnt/kwt", style: textStyle)
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}





// handler(int id,context,String chagerName){

//  dynamic filteredList;

//   filteredList= Dummychargerinfo.dummychargerinfo.where((element) => element.id == id).toList();
   
//    Navigator.pushNamed(context, ChargerScreen.nameRoute,arguments: {"list":filteredList,
//    "charger_name": chagerName});
   
// }