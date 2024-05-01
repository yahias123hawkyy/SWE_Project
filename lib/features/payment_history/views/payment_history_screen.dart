import 'package:flutter/material.dart';
import 'package:iparkmobileapplication/common/widgets/app_bar.dart';
import 'package:iparkmobileapplication/features/main_screen/views/main_screen.dart';
import 'package:iparkmobileapplication/features/payment_history/models/payment_model.dart';
import 'package:iparkmobileapplication/features/payment_history/providers/api_payments.dart';
import 'package:iparkmobileapplication/features/payment_history/views/payment_card.dart';
import 'package:iparkmobileapplication/utils/themes/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({super.key});

  static const String nameRoute = "payment_history_screen";

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {


 Future<List<PaymentModel>>? future;

  @override
  void initState() {
    super.initState();
     future = wrapper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationBar.appbar(
          "Payment History",
          const Icon(Icons.arrow_back_ios_new_outlined),
          () => Navigator.pushNamed(context,MainScreenView.routeName)),
      body:  FutureBuilder<List<PaymentModel>>(
          future: future,
          builder: (context, snapshot) {
            // print(snapshot.data!);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(
                color: MainColors.mainLightThemeColor,
              );
            } else if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  "You still have no any payments!",
                  style: TextStyle(color: Colors.black),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.length ,
                  itemBuilder: (context, index) => 
                 PaymentCard(
                    amount: snapshot.data![index].amount,
                    date: snapshot.data![index].date!,
                    userId: snapshot.data![index].userId,
                    chargerId: snapshot.data![index].chargerId,
                    stationName: snapshot.data![index].stationName),
              );
            }
          },
        ),
      );
  }

  Future<List<PaymentModel>> wrapper() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<PaymentModel> payments =
        await PaymentsApiManager.fetchPaymentsByUserId(
            prefs.getString("userId")!);

    return payments;
  }
}
