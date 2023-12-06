import 'package:flutter/material.dart';
import 'package:iparkmobileapplication/utils/themes/app_colors.dart';


signInELevatedButtonstyle(context){
return   ElevatedButton.styleFrom(
                            backgroundColor: MainColors.mainLightThemeColor,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.0))),
                            fixedSize: Size.fromWidth(
                                MediaQuery.of(context).size.width * 0.8));
                    
}

