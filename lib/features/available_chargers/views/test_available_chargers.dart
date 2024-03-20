import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iparkmobileapplication/common/widgets/app_bar.dart';
import 'package:iparkmobileapplication/features/main_screen/views/helper.dart';
import 'package:iparkmobileapplication/utils/themes/app_colors.dart';

class TestAvailableChargers extends StatefulWidget {
  const TestAvailableChargers({super.key});

  static String routeName = "test_available_chargers";

  @override
  State<TestAvailableChargers> createState() => _TestAvailableChargersState();
}

class _TestAvailableChargersState extends State<TestAvailableChargers> {
  MainScreenHelper helper = MainScreenHelper();

  List chargers = [];

  @override
  void initState() {
    super.initState();
  }

  Future<List> mapMarkerToStation(id) async {
    MainScreenHelper helper = MainScreenHelper();
    List<dynamic> stations = await helper
        .fetchApiData("http://10.0.2.2:3000/api/stations/available");

    var station = stations.firstWhere(
      (stationn) => stationn['ID'] == id,
      orElse: () => {'chargers': null},
    );

    return station["chargers"];
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    mapMarkerToStation(args["ID"]);

    return Scaffold(
      appBar: ApplicationBar.appbar("Available Chargers",
          const Icon(Icons.arrow_back_ios_new), () => Navigator.pop(context)),
      body: FutureBuilder<List>(
        future: mapMarkerToStation(args["ID"]),
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
                        shape:
                            const RoundedRectangleBorder(side: BorderSide.none),
                        leading: const Icon(Icons.power),
                        title: Text(snapshot.data![index]["ID"].toString(),
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
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
                                color: Color.fromARGB(255, 156, 208, 235),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(.6))),
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    'Per kWh'),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.05),
                                Text(
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    snapshot.data![index]["Price"].toString() +
                                        "\$ / kw")
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(snapshot.data![index]["PowerKW"].toString() +
                                " KW",style: TextStyle(color: MainColors.mainLightThemeColor),),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: MainColors.mainLightThemeColor),
                                  'All prices include VAT.'),
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
    );
  }
}
