import 'package:dio/dio.dart';

abstract class MainScreenHelper {

  
  static Future<List<dynamic>> fetchApiData(String url) async {
    Dio dio = Dio();

    try {
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        // Assuming the response body is a list
        print(response.data);
        return response.data;
      } else {
        throw Exception('Failed to load data: HTTP ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load data');
    }
  }

  static Future<List> recieveStations(
      String url, Map<dynamic, dynamic> latlong) async {
    Dio dio = Dio();
    try {
      final response = await dio.post(
        url,
        data: latlong,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception('Dio error with response: ${e.response.toString()}');
      } else {
        throw Exception('Dio error without response: ${e.message}');
      }
    }
  }

  static Future<List<dynamic>> fetchStations(String query) async {
    Dio dio = Dio();

    try {
      final response = await dio.get('http://10.0.2.2:3000/api/stations/search',
          queryParameters: {'q': query});
      return response.data;
    } catch (e) {
      return [];
    }
  }
}
