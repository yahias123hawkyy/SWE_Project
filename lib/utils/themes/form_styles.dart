import 'package:flutter/material.dart';
import 'package:iparkmobileapplication/utils/themes/app_colors.dart';





abstract class FormStyles{


 
static InputDecoration formStyle=InputDecoration(
                          labelText: "Email",
                          labelStyle:
                              TextStyle(color: MainColors.mainLightThemeColor),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: MainColors.mainLightThemeColor)),
                        );

static InputDecoration formStylePassword=InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: MainColors.mainLightThemeColor)),
                          suffix: GestureDetector(
                            onTap: () => null,
                            child: Text("Forgot password? "),
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(color: MainColors.mainLightThemeColor),
                        );


}

 