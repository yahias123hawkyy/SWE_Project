import 'package:flutter/material.dart';
import 'package:iparkmobileapplication/common/widgets/app_bar.dart';
import 'package:iparkmobileapplication/features/profile_details_screens/models/my_profile.dart';
import 'package:iparkmobileapplication/utils/themes/app_colors.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});


    static const  list=["first name","Last Name","Email","username"];


    static const String nameRoute= "profile_details_screen";


   @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as Map;
    Size mediaQuery = MediaQuery.of(context).size;

    return  Scaffold(
      appBar: ApplicationBar.appbar(args["title"], Icon(Icons.arrow_back), ()=> Navigator.pop(context)),


      body: Column(
        children: [
        Container(alignment: Alignment.center,child: Image.asset("assets/images/user.png",width:mediaQuery.width*0.5 )),



          Expanded(
            child: ListView.builder(itemCount: DummyMYprofile.list.length,itemBuilder: (context,index){
             return Container(margin: EdgeInsets.all(mediaQuery.width*0.05),decoration: BoxDecoration(
              border: Border.all(width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(12))
             ),child: ListTile(leading: Text(list[index],style: textStyle,),title:  Text(DummyMYprofile.list[index].email,style: textStyle, )));
            }),
          ),
        ],
      ),
    );
  }
}

TextStyle textStyle =
    TextStyle(fontSize: 18, color: MainColors.mainLightThemeColor);