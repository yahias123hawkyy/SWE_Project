import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iparkmobileapplication/common/widgets/app_bar.dart';
import 'package:iparkmobileapplication/common/widgets/profile_card.dart';
import 'package:iparkmobileapplication/utils/themes/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:iparkmobileapplication/features/settings_screen/providers/localizationservice.dart';

import '../providers/localizationservice.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static const String nameRoute = "settings_screen";

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool? cosa;

  void initState() {
    super.initState();
    _asyncSetup();
  }

  Future<void> _asyncSetup() async {
      bool newCosa =  await Get.find<LocalizationService>().initLocale();

    setState(()  {
      cosa =newCosa;
      print(cosa);
    });
    
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: ApplicationBar.appbar(
          args["title"], Icon(Icons.arrow_back), () => Navigator.pop(context)),
      body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              ProfileCard(
                  // onTap: ()=> Navigator.pushNamed(context, routeName),
                  leadingicon: Icon(Icons.person_2_outlined),
                  title: "Support",
                  trailingicon: Icon(Icons.arrow_forward_ios)),
              ProfileCard(
                  // onTap: ()=> Navigator.pushNamed(context, routeName),
                  leadingicon: Icon(Icons.person_2_outlined),
                  title: "FAQ",
                  trailingicon: Icon(Icons.arrow_forward_ios)),
              ProfileCard(
                  // onTap: ()=> Navigator.pushNamed(context, routeName),
                  leadingicon: Icon(Icons.person_2_outlined),
                  title: "About App",
                  trailingicon: Icon(Icons.arrow_forward_ios)),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Text(
                "Language",
                style: TextStyle(
                    color: MainColors.mainLightThemeColor, fontSize: 19),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.0)),
                            ),
                            backgroundColor: cosa == false
                                ? MainColors.mainLightThemeColor
                                : Colors.white),
                        onPressed: () async {
                          cosa = await Get.find<LocalizationService>()
                              .setLocale('en', false);
                          ;
                  
                        },
                        child: Text(
                          "EN",
                          style: TextStyle(
                              color: cosa == false
                                  ? Colors.white
                                  : MainColors.mainLightThemeColor),
                        )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.08,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.0)),
                            ),
                            backgroundColor: cosa == true
                                ? MainColors.mainLightThemeColor
                                : Colors.white),
                        onPressed: () async {
                          bool newCosa = await Get.find<LocalizationService>()
                              .setLocale('fi', true);
                          setState(() {
                            cosa = newCosa;
                          });
                        },
                        child: Text(
                          "FI",
                          style: TextStyle(
                              color: cosa == true
                                  ? Colors.white
                                  : MainColors.mainLightThemeColor),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(width: 0.2, color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(14.0)),
                        ),
                        backgroundColor: Colors.white),
                    onPressed: () => print("object"),
                    child: Text(
                      "Sign Out",
                      style:
                          TextStyle(color: MainColors.redColor, fontSize: 18),
                    )),
              )
            ],
          )),
    );
  }
}
