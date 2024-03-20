import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iparkmobileapplication/features/available_chargers/views/test_available_chargers.dart';
import 'package:iparkmobileapplication/features/main_screen/views/helper.dart';
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
  

  GoogleMapController? _controller;

  final LatLng _userLocation = const LatLng(45.592775, 9.294368);
  final LatLng _destinationLocation =
      const LatLng(37.43496133580664, -122.090749655962);
  List<LatLng> _polylinePoints = [];
  Set<Polyline> _polylines = {};
  Set<Marker> _markers = {};
  Timer? _timer;
  int count = 0;

  List stationss = [];

  void mapMarkerToStation() async {
    MainScreenHelper helper = MainScreenHelper();
    List<dynamic> stations = await helper
        .fetchApiData("http://10.0.2.2:3000/api/stations/available");

    for (int i = 0; i < stations.length; i++) {
      stationss.add(stations[i]);
      setState(() {
        _markers.add(Marker(
            markerId: MarkerId(stations[i]["ID"]),
            infoWindow: InfoWindow(title: "Station ${stations[i]["title"]}"),
            position: LatLng(double.parse(stations[i]["locationLat"]),
                double.parse(stations[i]["locationLong"]))));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    mapMarkerToStation();
  }
  // void initState() {
  //   super.initState();
  //   _polylinePoints.add(_initialPosition);
  //   _simulateUserMovement();
  // }

 
  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  void _simulateMovement() {
    const step = 0.0001;
    int steps = 100; 

    LatLng currentPosition = _userLocation;
    Timer.periodic(const Duration(milliseconds: 100), (Timer timer) {
      setState(() {
        double lat = currentPosition.latitude +
            ((_destinationLocation.latitude - _userLocation.latitude) / steps);
        double lng = currentPosition.longitude +
            ((_destinationLocation.longitude - _userLocation.longitude) /
                steps);
        currentPosition = LatLng(lat, lng);

        // Update the marker position
        _markers.removeWhere((m) => m.markerId.value == 'user_location');
        _markers.add(Marker(
          markerId: const MarkerId("user_location"),
          position: currentPosition,
          infoWindow: const InfoWindow(title: "Your Location"),
        ));

        if ((currentPosition.latitude - _destinationLocation.latitude).abs() <
                step &&
            (currentPosition.longitude - _destinationLocation.longitude).abs() <
                step) {
          timer.cancel(); // Stop the timer when the destination is reached
        }
      });
    });
  }

  void _createRoute() {
    setState(() {
      // Clear existing markers and polylines
      _markers.clear();
      _polylines.clear();

      // Add markers for user and destination
      _markers.add(Marker(
        markerId: const MarkerId("user_location"),
        position: _userLocation,
        infoWindow: const InfoWindow(title: "Your Location"),
      ));
      _markers.add(Marker(
        markerId: const MarkerId("destination_location"),
        position: _destinationLocation,
        infoWindow: const InfoWindow(title: "Destination"),
      ));

      // Create a polyline between user and destination
      _polylines.add(Polyline(
        polylineId: const PolylineId("route"),
        points: [_userLocation, _destinationLocation],
        color: Colors.blue,
        width: 5,
      ));

      _simulateMovement();

      // _fitRoute();
    });
  }

  void _fitRoute() {
    LatLngBounds bounds;
    if (_userLocation.latitude > _destinationLocation.latitude &&
        _userLocation.longitude > _destinationLocation.longitude) {
      bounds = LatLngBounds(
          southwest: _destinationLocation, northeast: _userLocation);
    } else {
      bounds = LatLngBounds(
          southwest: _userLocation, northeast: _destinationLocation);
    }

    CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 50);

    _controller?.animateCamera(cameraUpdate);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

 

  @override
  Widget build(BuildContext context) {
    final Size _page_size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: BottomNavBar(),
      backgroundColor: MainColors.backgroundColor,
      body: Stack(children: [
        GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition:
              CameraPosition(target: _userLocation, zoom: 20.0),
          onMapCreated: _onMapCreated,
          markers: _markers,
          // polylines: _polylines,
        ),
        Positioned(
          child: SafeArea(
            child: Container(
              decoration: boxContainerDecorationSearchBar,
              margin: EdgeInsets.all(_page_size.height * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: _page_size.width * 0.7,
                    child: TextField(
                        // controller: _searchController,
                        // onSubmitted: (value) => _searchAndNavigate(),
                        decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(Icons.search),
                            border: const UnderlineInputBorder(
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
                        height: _page_size.height * 0.06,
                        width: _page_size.width * 0.06,
                      ))
                ],
              ),
            ),
          ),
        ),
        Positioned(
            bottom: 10,
            left: MediaQuery.of(context).size.width * 0.35,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10), // Adjust the borderRadius to control the roundness
                  ),
                ),
                onPressed: () => showNearStations(context),
                child: const Text(
                    style: TextStyle(color: Colors.white), "Show List"))),
      ]),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _createRoute,
      //   tooltip: 'Create Route',
      //   child: Icon(Icons.route),
      // ),
    );
  }

  showNearStations(BuildContext ctx) {
    _scaffoldKey.currentState?.showBottomSheet(
      enableDrag: true,
      showDragHandle: true,
      (BuildContext ctx) {
        return FractionallySizedBox(
          heightFactor:
              0.8, // Adjust the height factor as needed, up to 1 for full screen
          child: ListView.builder(
            itemCount:
                stationss.length, // Increase the number of items in the list
            itemBuilder: (BuildContext ctx, int index) {
              return GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, TestAvailableChargers.routeName,arguments:{"ID":stationss[index]["ID"]});
                },
                child: Card(
                  child: ListTile(
                    subtitle: Text(stationss[index]["addressLine1"]),
                    trailing: const Text('60 m'),
                    title: Text(stationss[index]["title"]),
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.power, size: 20),
                        Text('${stationss[index]["chargers"][0]["PowerKW"]} kW'),
                        Text("${stationss[index]["chargers"].length}",
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    // onTap: () {},
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

BoxDecoration boxContainerDecorationSearchBar = const BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(25)),
  color: Colors.white,
);
