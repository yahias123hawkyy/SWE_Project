import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iparkmobileapplication/features/station_screen/views/station_screen.dart';
import 'package:iparkmobileapplication/features/main_screen/providers/helper.dart';
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
  Completer<GoogleMapController> _controller = Completer();

  late LatLng _userLocation;

  late Future<String> wrapperFuture;

  Set<Marker> _markers = {};
  Timer? _timer;
  int count = 0;

  List stationss = [];

  var readOnly = false;

  Future<void> mapMarkerToStation(Map<String, num> map) async {
    List<dynamic> stations = await MainScreenHelper.recieveStations(
        "http://10.0.2.2:3000/api/stations/stations", map);
    print(stations);
    for (int i = 0; i < stations.length; i++) {
      stationss.add(stations[i]);
      setState(() {
        _markers.add(Marker(
            onTap: () => Navigator.pushNamed(context, StationScreen.routeName,
                arguments: {"ID": stations[i]["ID"]}),
            markerId: MarkerId(stations[i]["ID"]),
            infoWindow: InfoWindow(title: "Station ${stations[i]["title"]}"),
            position: LatLng(double.parse(stations[i]["locationLat"]),
                double.parse(stations[i]["locationLong"]))));
      });
    }
  }

  List<dynamic> _searchResults = [];
  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _userLocation = LatLng(position.latitude, position.longitude);
      //   currentCenter = position;
      //   markers.add(Marker(
      //       point: LatLng(userLocation!.latitude, userLocation!.longitude),
      //       child: Hero(tag: 1, child: Image.asset("assets/images/qq.png")),
      //       width: 200,
      //       height: 200));
    });

    setState(() {
      _markers.add(Marker(
        markerId: MarkerId("a"),
        position: LatLng(
          position.latitude,
          position.longitude,
        ),
      ));
    });

    return position;
  }

  void _onSearchChanged(String query) async {
    if (query.isNotEmpty) {
      final results = await MainScreenHelper.fetchStations(query);
      setState(() {
        _searchResults = results;
      });
    } else {
      setState(() {
        _searchResults = [];
      });
    }
  }

  @override
  void initState() {
    super.initState();

    wrapperFuture = wrapper();
  }

  Future<String> wrapper() async {
    Position position = await _getCurrentLocation();
    Map<String, num> latlong = {
      "lat": position.latitude,
      "long": position.longitude
    };
    print(latlong);

    await mapMarkerToStation(latlong);

    return "true";
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller); // Correct usage
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    var textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size _page_size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: BottomNavBar(),
      backgroundColor: MainColors.backgroundColor,
      body: Stack(children: [
        FutureBuilder<String>(
          future: wrapperFuture,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return GoogleMap(
                mapType: MapType.satellite,
                initialCameraPosition: CameraPosition(
                  target: _userLocation,
                  zoom: 14.0,
                ),
                onMapCreated: _onMapCreated,
                markers: _markers,
              );
            } else if (snapshot.hasError) {
              return const Center(child: const Text('Error fetching map data'));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
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
                        onChanged: _onSearchChanged,
                        controller: textFieldController,
                        readOnly: readOnly,
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
          child: Expanded(
            child: Container(
              child: _searchResults.isNotEmpty
                  ? Container(
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(
                          vertical: 100, horizontal: 20),
                      height: _page_size.height * 0.3,
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: ListView.builder(
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          final station = _searchResults[index][0];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _goToStation(
                                    double.parse(_searchResults[index][1][0]),
                                    double.parse(_searchResults[index][1][1]));
                                textFieldController.text = "";
                                readOnly = true;
                                _searchResults = [];
                              });
                            },
                            child: ListTile(
                              title: Text(_searchResults[index]
                                  [0]), // Adjust based on your data structure
                              // subtitle: Text(station['location']), // Optional
                            ),
                          );
                        },
                      ),
                    )
                  : const Center(
                      child: Text(
                      'No results found',
                      style: TextStyle(color: Colors.transparent),
                    )),
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
    );
  }

  void _goToStation(double latitude, double longitude) async {
    final GoogleMapController? mapController = await _controller.future;
    mapController?.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(latitude, longitude),
        zoom: 20.0, // Adjust zoom level as necessary
      ),
    ));
  }

  double responsiveValue(BuildContext context, double value,
      {Axis axis = Axis.vertical}) {
    final Size screenSize = MediaQuery.of(context).size;
    final double baseHeight = 800.0;
    final double baseWidth = 400.0;

    return value *
        (axis == Axis.vertical
            ? screenSize.height / baseHeight
            : screenSize.width / baseWidth);
  }

  showNearStations(BuildContext ctx) {
    _scaffoldKey.currentState?.showBottomSheet(
      enableDrag: true,
      showDragHandle: true,
      (BuildContext ctx) {
        return FractionallySizedBox(
          heightFactor: 0.5,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: responsiveValue(ctx, 5), // Adjusted
                    horizontal: responsiveValue(ctx, 10), // Adjusted
                  ),
                  child: Text(
                    "Near Stations",
                    style: TextStyle(
                      color: MainColors.mainLightThemeColor,
                      fontSize: responsiveValue(ctx, 18,
                          axis: Axis.horizontal), // Adjusted
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(ctx).size.height *
                      0.37, // Consider adjusting this as well
                  color: MainColors.backgroundColor,
                  child: ListView.builder(
                    itemCount: stationss.length, // Ensure 'stations' is correct
                    itemBuilder: (BuildContext ctx, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(ctx, StationScreen.routeName,
                              arguments: {"ID": stationss[index]["ID"]});
                        },
                        child: Card(
                          margin: EdgeInsets.all(
                            responsiveValue(ctx, 8), // Adjusted
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(
                              responsiveValue(ctx, 8), // Adjusted
                            ),
                            child: ListTile(
                              subtitle: Text(
                                stationss[index]["addressLine1"],
                                style: TextStyle(
                                  fontSize: responsiveValue(ctx, 15,
                                      axis: Axis.horizontal), // Adjusted
                                ),
                              ),
                              trailing: Text(
                                '${(index + 1 * 10.1).toString().substring(0, 2)}m',
                                style: TextStyle(
                                  fontSize: responsiveValue(ctx, 17,
                                      axis: Axis.horizontal), // Adjusted
                                ),
                              ),
                              title: Text(stationss[index]["title"]),
                              leading: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                      color: MainColors.mainLightThemeColor,
                                      Icons.power_outlined,
                                      size: 40),
                                  Text(
                                      "x${stationss[index]["chargers"].length}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                ],
                              ),
                              // onTap: () {},
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
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
