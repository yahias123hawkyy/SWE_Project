import 'package:dio/dio.dart';

class MainScreenHelper{

  Dio dio = Dio();

  Future<List<dynamic>> fetchApiData(String url) async {
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


Future<List<dynamic>> fetchStations(String query) async {
    try {
      final response = await dio.get('http://10.0.2.2:3000/api/stations/search', queryParameters: {'q': query});
      return response.data;
    } catch (e) {
      return [];
    }
  }
}