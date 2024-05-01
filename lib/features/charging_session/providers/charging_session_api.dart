import 'package:dio/dio.dart';
import 'package:iparkmobileapplication/features/charging_session/models/chargingSession_model.dart';
import 'dart:convert';

abstract class ChargingSessionApi {
  static const String baseUrl = 'http://10.0.2.2:3000/api'; 
  static final Dio _dio = Dio();

  static Future<String> createSession(Map<String, dynamic> sessionData) async {
    try {
      final response = await _dio.post('$baseUrl/chargingSessions/create', data: jsonEncode(sessionData));
      // print(response.data);
      if (response.statusCode == 201) {
        return response.data["sessionId"];
      } else {
        throw Exception('Failed to create session: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('DioError: ${e.message}');
    }
  }

  static Future<ChargingSession> simulateConnection(Map<String, dynamic> sessionId) async {
    try {
       final json = await _dio.post('$baseUrl/chargingSessions/simulateConnection',data: jsonEncode(sessionId));

       ChargingSession chargingSession = ChargingSession.fromJson(json.data);

       print(chargingSession);

       return chargingSession;
    } on DioException catch (e) {

      throw Exception('DioError: ${e.message}');

    }
  }

  static Future<ChargingSession> startChargingSession(Map<String, dynamic> sessionId) async {
    try {
      final response = await _dio.post('$baseUrl/chargingSessions/start',data: sessionId);
      if (response.statusCode == 200) {

        print(response.data);
        return ChargingSession.fromJson(response.data);
      } else {
        throw Exception('Failed to start session: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('DioError: ${e.message}');
    }
  }

  static Future<ChargingSession> getSession(String sessionId) async {
    try {
      final response = await _dio.get('$baseUrl/chargingSessions/$sessionId');
      if (response.statusCode == 200) {

        // print(ChargingSession.fromJson(response.data));
        return ChargingSession.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch session: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('DioError: ${e.message}');
    }
  }

  static Future<ChargingSession> stopChargingSession(Map<String, dynamic> sessionId) async {
    try {
      final response = await _dio.post('$baseUrl/chargingSessions/stop',data: sessionId);
      if (response.statusCode == 200) {
        return ChargingSession.fromJson(response.data);
      } else {
        throw Exception('Failed to stop session: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('DioError: ${e.message}');
    }
  }
}
