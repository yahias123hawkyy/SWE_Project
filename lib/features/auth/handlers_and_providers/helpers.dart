import 'package:flutter/widgets.dart';
import 'package:iparkmobileapplication/features/main_screen/views/main_screen.dart';
import 'package:dio/dio.dart';
import 'package:iparkmobileapplication/features/auth/views/sign_in_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

abstract class Helper {
  static bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  static dynamic returnMessage(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    } else if (!isValidEmail(value)) {
      return 'Please enter a valid email address';
    }
    return;
  }

  static validatePassword(value) {
    {
      if (value == null || value.isEmpty || value.length < 8) {
        return 'Please enter a valid password';
      }
      return null;
    }
  }

  static validateOnClick(
    GlobalKey<FormState> formKey,
    BuildContext context,
  ) {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      Navigator.pushNamed(context, MainScreenView.routeName);
    }
  }
}

class AuthenticationService {
  bool isLoggedin = false;
  Dio dio = Dio();
  final baseUrl =
      'http://10.0.2.2:3000/api/auth'; // Update with your actual API URL

  Future<bool> signUp(
      {required String username,
      required String password,
      required String firstName,
      required String lastName}) async {
    try {
      final response = await dio.post(
        '$baseUrl/signup',
        data: {
          'username': username,
          'password': password,
          'firstName': firstName,
          "lastName": lastName
        },
      );
      if (response.statusCode == 201) {
        final token = response.data['token'];
        final userId = response.data['userId'];

        SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.setString("user-token", token);
        prefs.setBool("isLoggedin", true);
        prefs.setString("userId", userId);

        return true;
      }
      return false;
    } on DioException {
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> signIn(String username, String password) async {
    try {
      final response = await dio.post(
        '$baseUrl/signin',
        data: {'username': username, 'password': password},
      );
      if (response.statusCode == 200) {
        final token = response.data['token'];
        final userId= response.data['userId'];

        SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.setBool("isLoggedin", true);
        await prefs.setString("userId",userId);

        return true;
      }
      return false;
    } on DioException {
      return false;
    }
  }

  Future<void> logout(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove("user-token");
    await prefs.setBool("isLoggedin", false);
    await prefs.remove("userId");

    Navigator.pushNamed(context, SignInScreen.nameRoute);
  }

  Future<bool> isTokenActive(String token) async {
    return false;
  }

  Future<Map> fetchUserData(String userId) async {
    Dio dio = Dio();

    try {
      final response = await dio.get('http://10.0.2.2:3000/api/auth/$userId');
      if (response.statusCode == 200) {
        // Assuming the server returns the user data directly
        return response.data;
      } else {
        // Handle non-200 responses
        throw Exception('Failed to load user data');
      }
    } on DioException catch (e) {
      // Handle Dio errors (e.g., network issues, timeouts)
      print(e.toString());
      throw Exception('Failed to load user data due to DioError');
    }
  }
}
