import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

class ChargerProvider extends ChangeNotifier {
  final Dio dio = Dio();

  bool chargerConnected = false;

  Future<dynamic> startSession() async {
    try {
      final response = await dio.post(
        "https://mobilebackend-qj5f.onrender.com/api/start-charger-connection",
        data: {
          "chargerID": "12dff658",
        },
      );
      print(response.data);

      return response.data["sessionID"];
    } catch (error) {}
  }

  Future<dynamic> connectionStatus(dynamic sessionID) async {
    try {
      final response = await dio.post(
        "https://mobilebackend-qj5f.onrender.com/api/connection-status",
        data: {
          "sessionID": sessionID,
        },
      );
      print(response.data);

      notifyListeners();

      return response.data["isChargerConnected"];
    } catch (error) {
      print(error);
    }
  }

  Future<dynamic> startTheCharging(String? sessionID) async {
    try {
      final response = await dio.post(
        "https://mobilebackend-qj5f.onrender.com/api/start-charging-session",
        data: {
          "sessionID": sessionID,
        },
      );
      print(response.data);

      return response.data;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<dynamic> chargingStatus(String? sessionID) async {
    try {
      final response = await dio.post(
        "https://mobilebackend-qj5f.onrender.com/api/charging-session-status",
        data: {
          "sessionID": sessionID,
        },
      );
      print(response.data);

      return response.data;
    } catch (error) {
      print(error);
    }
  }

  Future<dynamic> stopCharging(sessionID) async {
    try {
      final response = await dio.post(
        "https://mobilebackend-qj5f.onrender.com/api/stop-charging-session",
        data: {
          "sessionID": sessionID,
        },
      );
      print(response.data);

      return response.data;
    } catch (error) {
      print(error);
      return null;
    }
  }
}
