import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iparkmobileapplication/features/station/providers/api_helper.dart';
import 'package:iparkmobileapplication/features/charging_session/views/charger_screen.dart';
import 'package:iparkmobileapplication/features/station/providers/handlers.dart';
import 'package:iparkmobileapplication/utils/themes/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StationScreen extends StatefulWidget {
  const StationScreen({super.key});

  static String routeName = "test_available_chargers";

  @override
  State<StationScreen> createState() => _StationScreenState();
}

class _StationScreenState extends State<StationScreen> {
  bool isFavourite = false;

  String? stationName;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    ApiHelper.getChargers(args["ID"]);
    ApiHelper.getStationData(args["ID"]);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            child: FutureBuilder<List>(
              future: ApiHelper.getStationData(
                  args["ID"]), // Your actual future function
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show a loading indicator while waiting for the future to complete
                  return const Center(child: Text(""));
                } else if (snapshot.hasError) {
                  // Handle any errors that occur during the future execution
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else {
                  // Once the future completes, build the UI with the data
                  stationName = snapshot.data![0].title;
                  return Container(
                    padding: EdgeInsets.all(10.w),
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    isFavourite = !isFavourite;
                                  });
                                },
                                icon: isFavourite
                                    ? const Icon(Icons.favorite,
                                        color: Colors.red)
                                    : const Icon(
                                        Icons.favorite_border_rounded,
                                      )),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(snapshot.data![0].title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                  Text(snapshot.data![0].addressLine1,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(Icons.cancel_outlined)),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(Icons.timelapse),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Always Open",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.map),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                          "${SationScreenHandler.calculateDistance(double.parse(snapshot.data![0].locationLat), double.parse(snapshot.data![0].locationLong), args["Lat"], args["Long"]).toString().substring(0, 3)} Km",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    child: ElevatedButton.icon(
                                        onPressed: () =>
                                            ApiHelper.openGoogleMaps(
                                                double.parse(snapshot
                                                    .data![0].locationLat),
                                                double.parse(snapshot
                                                    .data![0].locationLong)),
                                        icon: const FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Icon(
                                            Icons.directions,
                                            color: Colors.white,
                                          ),
                                        ),
                                        label: const FittedBox(
                                          fit: BoxFit.cover,
                                          child: Text(
                                            "Get Directions",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                              const Row(
                                children: [
                                  Icon(Icons.build),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Public Access",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
          Expanded(
            child: Container(
              color: MainColors.backgroundColor,
              child: FutureBuilder<List>(
                future: ApiHelper.getChargers(args["ID"]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "Our exciting offers !",
                            style: TextStyle(
                                color: MainColors.mainLightThemeColor,
                                fontSize: 17.w,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10.w,
                        ),
                        Container(
                          color: MainColors.backgroundColor,
                          height: 100.h,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data![0].offers.length,
                              itemBuilder: (context, i) {
                                Random random = Random();
                                int j = random.nextInt(1);
                                return SizedBox(
                                  width: 200.w,
                                  child: Card(
                                    child: ListTile(
                                      title: Text(
                                        snapshot.data![j].offers[i].name,
                                        style: TextStyle(
                                            color:
                                                MainColors.mainLightThemeColor),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Until: " +
                                                snapshot.data![j].offers[i]
                                                    .deadline,
                                            style: TextStyle(
                                                color: MainColors
                                                    .mainLightThemeColor,
                                                fontSize: 14.w),
                                          ),
                                          Text(
                                              "Charger ID: " +
                                                  snapshot.data![j].id,
                                              style:
                                                  TextStyle(
                                                      color: MainColors
                                                          .mainLightThemeColor,
                                                      fontSize: 14.w))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.05,
                                vertical:
                                    MediaQuery.of(context).size.width * 0.04),
                            child: Text("Available Charging Points",
                                style: TextStyle(
                                    fontSize: 17.w,
                                    color: MainColors.mainLightThemeColor,
                                    fontWeight: FontWeight.bold))),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.05),
                            child: Text("Pick one to start charging",
                                style: TextStyle(
                                    color: MainColors.mainLightThemeColor))),
                        Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                margin: EdgeInsets.all(
                                    MediaQuery.of(context).size.width * 0.05),
                                child: Container(
                                  margin: EdgeInsets.all(
                                      MediaQuery.of(context).size.width * 0.05),
                                  child: ExpansionTile(
                                    enabled:
                                        snapshot.data![index].chargerStatus ==
                                                "Available"
                                            ? true
                                            : false,
                                    shape: const RoundedRectangleBorder(
                                        side: BorderSide.none),
                                    leading: const Icon(Icons.power),
                                    title: Text(snapshot.data![index].id,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    subtitle: Text(
                                        snapshot.data![index].chargerStatus,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: snapshot.data![index]
                                                        .chargerStatus ==
                                                    "Available"
                                                ? Colors.green
                                                : Colors.red)),
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(
                                            MediaQuery.of(context).size.width *
                                                0.01),
                                        alignment: Alignment.center,
                                        decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(.6))),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const Text(
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                                'Per kWh'),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.05),
                                            Text(
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                                "${snapshot.data![index].price.toString().substring(0, 5)}\$ / kw")
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 10),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: MainColors
                                                          .mainLightThemeColor),
                                                  'All prices include VAT.'),
                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10), // Adjust the borderRadius to control the roundness
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    SharedPreferences prefs =
                                                        await SharedPreferences
                                                            .getInstance();

                                                    if (double.parse(
                                                            prefs.getString(
                                                                "money")!) >
                                                        8) {
                                                      Navigator.pushNamed(
                                                          context,
                                                          ChargerScreen
                                                              .nameRoute,
                                                          arguments: {
                                                            "args": {
                                                              "stationName":
                                                                  stationName ??
                                                                      "enel",
                                                              "ID": snapshot
                                                                  .data![index]
                                                                  .id,
                                                              "Price": snapshot
                                                                  .data![index]
                                                                  .price
                                                            }
                                                          });
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        // ignore: prefer_const_constructors
                                                        SnackBar(
                                                            content: const Text(
                                                                'Your balance is less than 8 Euros, please recharge and try again later')),
                                                      );
                                                    }
                                                  },
                                                  child: const Text(
                                                    "Start ",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
