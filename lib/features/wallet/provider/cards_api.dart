import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:iparkmobileapplication/features/wallet/models/paymet_card_model.dart';

abstract class PaymentCardsApi{


  static Future<bool> addPaymentCard({
  required String cardNumber,
  required String expirationDate,
  required String cardholderName,
  required String cvv,
  required String userId,
}) async {
  var dio = Dio();
  const String endpoint = "http://10.0.2.2:3000/api/paymentCards"; // Replace with your actual endpoint

  try {
    final response = await dio.post(endpoint, data: {
      'cardNumber': cardNumber,
      'expirationDate': expirationDate,
      'cardholderName': cardholderName,
      'cvv': cvv,
      'userId': userId,
    });

    if (response.statusCode == 201) {
      print('Payment card added successfully.');
      return true;
    } else {
      // Handle other status codes or errors
      print('Failed to add payment card.');
      return false;
    }
  } on DioException catch (e) {
    print('DioError caught: ${e.message}');
    return false;
  } catch (e) {
    print('Error caught: $e');
    return false;
  }
}




static Future<List<PaymentCardModel>> fetchPaymentCardsByUserId(String userId) async {
  var dio = Dio();
  String endpoint = "http://10.0.2.2:3000/api/paymentCards/user/$userId"; // Replace with your actual endpoint

  try {
    final response = await dio.get(endpoint);

    if (response.statusCode == 200) {

      List<dynamic> json =response.data;

      List<PaymentCardModel> cards = json.map((card) => PaymentCardModel.fromJson(card)).toList();
      return cards;
    } else {
      // Handle non-200 responses
      print('Failed to fetch payment cards.');
      return [];
    }
  } on DioException catch (e) {
    // Handle Dio errors
    print('DioError caught: ${e.message}');
    return [];
  } catch (e) {
    // Handle any other errors
    print('Error caught: $e');
    return [];
  }
}


} 