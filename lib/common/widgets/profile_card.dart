import 'package:flutter/material.dart';
import 'package:iparkmobileapplication/utils/themes/app_colors.dart';

class ProfileCard extends StatelessWidget {


  final String title;
  final Icon trailingicon;
  final Icon leadingicon;
  final   onTap;

  const ProfileCard({super.key, this.onTap,required this.leadingicon, required this.title ,required this.trailingicon});

  @override
  Widget build(BuildContext context) {
          Size mediaQuery= MediaQuery.of(context).size;


    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.black,width: 0.5),
      ),
      padding: EdgeInsets.all(3),
      margin: EdgeInsets.all(mediaQuery.width*0.05),
      child: ListTile( 
        onTap: onTap,
        title: Container(margin: EdgeInsets.symmetric(horizontal: mediaQuery.width *0.07),child: Text(title,style: profilecardTextStyle,)),
        trailing: trailingicon,
        leading: leadingicon,
      ),
    );
  }
}

TextStyle profilecardTextStyle=TextStyle(
  color: MainColors.mainLightThemeColor,
  fontSize: 16,
  fontWeight: FontWeight.bold
);