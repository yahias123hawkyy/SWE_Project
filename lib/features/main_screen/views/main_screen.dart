import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iparkmobileapplication/features/main_screen/views/navbar_item.dart';
import 'package:iparkmobileapplication/utils/themes/app_colors.dart';

class MainScreenView extends StatelessWidget {
  const MainScreenView({super.key});

  static String routeName = "main_screen";

  @override
  Widget build(BuildContext context) {
    final Size _page_size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: MainColors.backgroundColor,
        // appBar: SafeArea(),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
            color:Colors.white ,
            ),
            margin: EdgeInsets.all(_page_size.height * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    width: _page_size.width * 0.7,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.search),
                        border: UnderlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(60))),
                        labelText: 'Search',
                      ),
                    ),
                  ),
                ),
                Container(
                   margin: EdgeInsets.symmetric(horizontal:_page_size.width *0.02),
                    child: SvgPicture.asset(
                    colorFilter: ColorFilter.mode(MainColors.mainLightThemeColor, BlendMode.srcIn),
                  "assets/images/adjust-svgrepo-com.svg",
                  height: _page_size.width * 0.1,
                  width: 200,
                ))
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBar());
  }
}
