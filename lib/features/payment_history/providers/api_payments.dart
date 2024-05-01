import 'package:dio/dio.dart';
import 'package:iparkmobileapplication/features/payment_history/models/payment_model.dart';

abstract class PaymentsApiManager {




static Future<bool> addPayment(PaymentModel payment) async {
  var dio = Dio();
  const String endpoint = "http://10.0.2.2:3000/api/payments"; // Ensure this is your actual endpoint

  try {
    final response = await dio.post(
      endpoint,
      data: payment.toJson(),
      options: Options( 
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    print("ana hena aho");
    print(response.data);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Payment added successfully.');
      return true;
    } else {
      print('Failed to add payment. Status code: ${response.statusCode}');
      return false;
    }
  } on DioException catch (e) {
    print('DioError caught: ${e.response?.statusCode} - ${e.message}');
    return false;
  } catch (e) {
    print('Error caught: $e');
    return false;
  }



}


static Future<List<PaymentModel>> fetchPaymentsByUserId(String userId) async {
  var dio = Dio();
  String endpoint = "http://10.0.2.2:3000/api/payments/user/$userId"; // Adjust with your actual endpoint

  try {
    final response = await dio.get(endpoint);
    if (response.statusCode == 200 || response.statusCode==201) {
      List<dynamic> data = response.data;
      print(data);
      print(data.map((json) => PaymentModel.fromJson(json)).toList());
      return data.map((json) => PaymentModel.fromJson(json)).toList();
    } else {
      print('Failed to fetch payments. Status code: ${response.statusCode}');
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