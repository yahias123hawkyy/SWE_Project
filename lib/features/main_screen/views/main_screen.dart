import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iparkmobileapplication/features/main_screen/views/navbar_item.dart';
import 'package:iparkmobileapplication/utils/themes/app_colors.dart';
import 'package:get/get.dart';

class MainScreenView extends StatefulWidget {
  const MainScreenView({super.key});

  static String routeName = "main_screen";

  @override
  State<MainScreenView> createState() => _MainScreenViewState();
}

class _MainScreenViewState extends State<MainScreenView> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(60.192059, 24.945831),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    final Size _page_size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: MainColors.backgroundColor,
        body: Stack(children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          SafeArea(
            child: Container(
              decoration: boxContainerDecorationSearchBar,
              margin: EdgeInsets.all(_page_size.height * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: _page_size.width * 0.7,
                    child: TextFormField(
                        decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            fillColor: Colors.white,
                            prefixIcon: Icon(Icons.search),
                            border: UnderlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(60))),
                            labelText: "search".tr)),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: _page_size.width * 0.02),
                      child: SvgPicture.asset(
                        colorFilter: ColorFilter.mode(
                            MainColors.mainLightThemeColor, BlendMode.srcIn),
                        "assets/images/adjust-svgrepo-com.svg",
                        height: _page_size.width * 0.1,
                        width: 200,
                      ))
                ],
              ),
            ),
          ),
        ]),
        bottomNavigationBar: BottomNavBar());
  }
}

BoxDecoration boxContainerDecorationSearchBar = const BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(25)),
  color: Colors.white,
);

// InputDecoration inputDecorationforSearchBar = InputDecoration(
//     focusedBorder: InputBorder.none,
//     enabledBorder: InputBorder.none,
//     fillColor: Colors.white,
//     prefixIcon: Icon(Icons.search),
//     border: UnderlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(60))),
//     labelText: "hello".tr);
