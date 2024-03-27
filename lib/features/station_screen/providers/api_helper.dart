import 'package:iparkmobileapplication/features/main_screen/providers/helper.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class ApiHelper {
  static Future<List> getChargers(id) async {
    List<dynamic> stations = await MainScreenHelper.fetchApiData(
        "http://10.0.2.2:3000/api/stations/available");

    var station = stations.firstWhere(
      (stationn) => stationn['ID'] == id,
      orElse: () => {'chargers': null},
    );

    return station["chargers"];
  }

  static void openGoogleMaps(double latitude, double longitude) async {
    String googleMapsUrl =
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

    if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
      await launchUrl(Uri.parse(googleMapsUrl));
    } else {
      throw 'Could not open Google Maps.';
    }
  }

  static Future<List> getStationData(id) async {
    List<dynamic> stations = await MainScreenHelper.fetchApiData(
        "http://10.0.2.2:3000/api/stations/available");

    var station = stations.firstWhere(
      (stationn) => stationn['ID'] == id,
      orElse: () => {'chargers': null},
    );

    return [station];
  }
}
