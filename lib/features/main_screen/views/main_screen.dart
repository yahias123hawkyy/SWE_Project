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
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    final Size _page_size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: MainColors.backgroundColor,
        // appBar: SafeArea(),
        body: Stack(
          children: [
             GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
            
            SafeArea(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              color:Colors.white ,
              ),
              margin: EdgeInsets.all(_page_size.height * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: _page_size.width * 0.7,
                    child: TextFormField(
                      decoration:  InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.search),
                        border: UnderlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(60))),
                        labelText: "search".tr
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
          ),]
        ),
        bottomNavigationBar: BottomNavBar()
        );
  }
}
