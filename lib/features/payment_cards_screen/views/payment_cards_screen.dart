import 'package:flutter/material.dart';
import 'package:iparkmobileapplication/common/widgets/app_bar.dart';

class PaymentCardsScreen extends StatelessWidget {
  const PaymentCardsScreen({super.key});

  static const nameRoute = "payment_cards_screen";

   @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as Map;
    return  Scaffold(
      appBar: ApplicationBar.appbar(args["title"], Icon(Icons.arrow_back), ()=>Navigator.pop(context)),
    );
  }
}