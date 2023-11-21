import 'package:flutter/material.dart';
import 'package:iparkmobileapplication/common/widgets/app_bar.dart';
import 'package:iparkmobileapplication/common/widgets/profile_card.dart';
import 'package:iparkmobileapplication/utils/themes/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const String nameRoute = "settings_screen";

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
                            backgroundColor: MainColors.mainLightThemeColor),
                        onPressed: () => print(""),
                        child: Text(
                          "EN",
                          style: TextStyle(color: Colors.white),
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
                            backgroundColor: Colors.white),
                        onPressed: () => print(""),
                        child: Text("FI")),
                  ],
                ),
              ),
               SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
              Container(
                width:  MediaQuery.of(context).size.width * 0.5 ,
                child: ElevatedButton( style: ElevatedButton.styleFrom(
    
                   elevation: 0,
                            shape: const RoundedRectangleBorder(
                              side: BorderSide(width: 0.2,color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14.0)),
                            ),
                            backgroundColor: Colors.white),onPressed: ()=>print("object"),child:Text("Sign Out",style: TextStyle(
                  color: MainColors.redColor,
                  fontSize: 18
                ),) ),
              )
            ],
          )),
    );
  }
}
