import 'package:dio/dio.dart';

class MainScreenHelper{


  Future<List<dynamic>> fetchApiData(String url) async {
  Dio dio = Dio();
  try {
    Response response = await dio.get(url);
    if (response.statusCode == 200) {
      // Assuming the response body is a list
      print(response.data);
      return response.data;
    } else {
      // Handle non-200 responses
      throw Exception('Failed to load data: HTTP ${response.statusCode}');
    }
  } catch (e) {
    print(e);
    throw Exception('Failed to load data');
  }
}
}