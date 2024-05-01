import 'package:dio/dio.dart';
import 'package:iparkmobileapplication/features/vehicle/models/vehichle.dart';

abstract class CarsApi {
  static Future<void> addCar({
    required String carType,
    required String model,
    required int year,
    required String userId,
  }) async {
    Dio dio = Dio(); 
    const url =
        'http://10.0.2.2:3000/api/cars'; 

    try {
      final response = await dio.post(
        url,
        data: {
          'carType': carType,
          'model': model,
          'year': year,
          'userId': userId,
        },
      );
      if (response.statusCode == 201) {
        print('Car added successfully');
        print(response.data);
      } else { 
      }
    } on DioException catch (e) {
      print('DioError caught: ${e.message}');
    }
  }


  static Future<List<VehichleModel>> fetchCarsByUserId(String userId) async {
  var dio = Dio();
  const String baseUrl = "http://10.0.2.2:3000"; // Replace with your actual base URL
  final String endpoint = "/api/cars/$userId";

  try {
    Response response = await dio.get("$baseUrl$endpoint");
    if (response.statusCode == 200) {
      print(response.data);
      List json =response.data;
    List<VehichleModel> vehichles = json.map((model) => VehichleModel.fromJson(model)).toList();

      return vehichles;
    } else {
      print('Failed to fetch cars. Status code: ${response.statusCode}');
      return [];
    }
  } on DioException catch (e) {
    print('DioError caught: ${e.message}');
    return [];
  } catch (e) {
    print('Error caught: $e');
    return [];
  }
}
}
