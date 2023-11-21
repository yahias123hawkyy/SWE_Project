import 'package:flutter/material.dart';
import 'package:iparkmobileapplication/common/widgets/app_bar.dart';
import 'package:iparkmobileapplication/features/payment_history_screen/views/payment_card.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});


  static const String nameRoute= "payment_history_screen";
  
   @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: ApplicationBar.appbar(args["title"], Icon(Icons.arrow_back), ()=>Navigator.pop(context)),
      body: ListView(children: [
        PaymentCard(cost: 30, datatime: DateTime.now(), placeTitle: "USA" ),
        PaymentCard(cost: 30, datatime: DateTime.now(), placeTitle: "USA" ),
        PaymentCard(cost: 30, datatime: DateTime.now(), placeTitle: "USA" ),
      ]),
        
    );
  }
}