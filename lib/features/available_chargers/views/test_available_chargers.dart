import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iparkmobileapplication/common/widgets/app_bar.dart';
import 'package:iparkmobileapplication/features/charger_screen/views/charger_screen.dart';
import 'package:iparkmobileapplication/features/main_screen/views/helper.dart';
import 'package:iparkmobileapplication/utils/themes/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class TestAvailableChargers extends StatefulWidget {
  const TestAvailableChargers({super.key});

  static String routeName = "test_available_chargers";

  @override
  State<TestAvailableChargers> createState() => _TestAvailableChargersState();
}

class _TestAvailableChargersState extends State<TestAvailableChargers> {
  MainScreenHelper helper = MainScreenHelper();

  List chargers = [];
  List stattions = [];

  @override
  void initState() {
    super.initState();
  }

  Future<List> getChargers(id) async {
    MainScreenHelper helper = MainScreenHelper();
    List<dynamic> stations = await helper
        .fetchApiData("http://10.0.2.2:3000/api/stations/available");

    var station = stations.firstWhere(
      (stationn) => stationn['ID'] == id,
      orElse: () => {'chargers': null},
    );

    return station["chargers"];
  }

//   void openGoogleMaps(double latitude, double longitude) async {
//   String googleMapsUrl = "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

//   if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
//     await LaunchUrl(Uri.parse(googleMapsUrl));
//   } else {
//     throw 'Could not open Google Maps.';
//   }
// }

  Future<List> getStationData(id) async {
    MainScreenHelper helper = MainScreenHelper();
    List<dynamic> stations = await helper
        .fetchApiData("http://10.0.2.2:3000/api/stations/available");

    var station = stations.firstWhere(
      (stationn) => stationn['ID'] == id,
      orElse: () => {'chargers': null},
    );

    return [station];
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    getChargers(args["ID"]);
    getStationData(args["ID"]);

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
            future: getStationData(args["ID"]), // Your actual future function
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Show a loading indicator while waiting for the future to complete
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // Handle any errors that occur during the future execution
                return Center(child: Text("Error: ${snapshot.error}"));
              } else {
                // Once the future completes, build the UI with the data
                return Container(
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(snapshot.data![0]["title"],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              Text(snapshot.data![0]["addressLine1"],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () => null,
                                  icon: const Icon(
                                      Icons.favorite_border_rounded)),
                              IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Icon(Icons.cancel_outlined))
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.map),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                        snapshot.data![0]["chargers"][0]
                                                    ["PowerKW"]
                                                .toString() +
                                            " M",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                ElevatedButton.icon(
                                    onPressed: () => null
                                    //  openGoogleMaps(double.parse(snapshot.data![0]["locationLat"]),double.parse(snapshot.data![0]["locationLong"])),
                                    ,
                                    icon: const Icon(
                                      Icons.directions,
                                      color: Colors.white,
                                    ), // Specify the icon
                                    label: const Text(
                                      "Get Directions",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    )),
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
          )),
          Container(
            height: MediaQuery.of(context).size.height * 0.73,
            color: MainColors.backgroundColor,
            child: FutureBuilder<List>(
              future: getChargers(args["ID"]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return Container(
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
                              shape: const RoundedRectangleBorder(
                                  side: BorderSide.none),
                              leading: const Icon(Icons.power),
                              title: Text(
                                  snapshot.data![index]["ID"].toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              subtitle: const Text("Available",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green)),
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width * 0.01),
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(.6))),
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
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
                                          "${snapshot.data![index]["Price"]}\$ / kw")
                                    ],
                                  ),
                                ),
                                // Align(
                                //   alignment: Alignment.centerLeft,
                                //   child: Text(
                                //     "${snapshot.data![index]["PowerKW"]} KW",
                                //     style: TextStyle(
                                //         color: MainColors.mainLightThemeColor),
                                //   ),
                                // ),
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
                                                fontWeight: FontWeight.bold,
                                                color: MainColors
                                                    .mainLightThemeColor),
                                            'All prices include VAT.'),
                                        ElevatedButton(
              
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.all(0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    10), // Adjust the borderRadius to control the roundness
                                              ),
                                            ),
                                            onPressed: () => Navigator.pushNamed(context,ChargerScreen.nameRoute,arguments: {
                                              "args":{
                                                "ID": snapshot.data![index]["ID"],
                                                "Price":snapshot.data![index]["Price"]
                                              }
                                            }),
                                            child: Text("Start ",style: TextStyle(color: Colors.white),)),
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
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
