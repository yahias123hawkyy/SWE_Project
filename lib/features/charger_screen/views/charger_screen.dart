import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iparkmobileapplication/common/widgets/app_bar.dart';
import 'package:iparkmobileapplication/features/charger_screen/models/charger.dart';
import 'package:iparkmobileapplication/utils/themes/app_colors.dart';

class ChargerScreen extends StatelessWidget {
  const ChargerScreen({super.key});

  static String nameRoute = "charger_screen";

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    Size mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: MainColors.backgroundColor,
      appBar: ApplicationBar.appbar(args["charger_name"],
          Icon(Icons.arrow_back), () => Navigator.pop(context)),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: mediaQuery.width*0.1),
              // alignment: Alignment.center,
              child: SvgPicture.asset(
                "assets/images/electricity-svgrepo-com.svg",
                colorFilter: ColorFilter.mode(
                    MainColors.mainLightThemeColor, BlendMode.srcIn),
              ),
              height: mediaQuery.height * 0.2,
              width: mediaQuery.width * 0.5,
            ),
            Container(
              padding: EdgeInsets.all(mediaQuery.width * 0.04),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              height: mediaQuery.height * 0.3,
              width: mediaQuery.width * 0.7,
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Energy",
                          style: testStyleHandler(context, mediaQuery),
                        ),
                        Text(
                          args["list"][0].energy.toString() +" kwt",
                          style: testStyleHandler(context, mediaQuery),
                        )
                      ]),
                  const Divider(
                    color: Colors.black,
                    height: 20,
                    thickness: 0.6,
                    indent: 5,
                    endIndent: 5,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Time",
                          style: testStyleHandler(context, mediaQuery),
                        ),
                        Text(
                          args["list"][0].time.toString().substring(17, 22),
                          style: testStyleHandler(context, mediaQuery),
                        )
                      ]),
                       const Divider(
                    color: Colors.black,
                    height: 20,
                    thickness: 0.6,
                    indent: 5,
                    endIndent: 5,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: testStyleHandler(context, mediaQuery),
                        ),
                        Text(
                          args["list"][0].costpertime.toString() + "\$",
                          style: testStyleHandler(context, mediaQuery),
                        )
                      ]),
                       const Divider(
                    color: Colors.black,
                    height: 20,
                    thickness: 0.6,
                    indent: 5,
                    endIndent: 5,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Battery",
                          style: testStyleHandler(context, mediaQuery),
                        ),
                        Text(
                          args["list"][0].battery.toString() +"%",
                          style: testStyleHandler(context, mediaQuery),
                        )
                      ]),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

TextStyle testStyleHandler(BuildContext context, Size mediaQuery) {
  TextStyle textStyle = TextStyle(
      fontSize: mediaQuery.width * 0.05, color: MainColors.mainLightThemeColor);

  return textStyle;
}
