import 'package:flutter/material.dart';
import 'package:iparkmobileapplication/common/widgets/app_bar.dart';
import 'package:iparkmobileapplication/features/payment_cards_screen/models/paymet_card_model.dart';
import 'package:iparkmobileapplication/features/payment_cards_screen/provider/payment_card_provider.dart';
import 'package:iparkmobileapplication/features/payment_cards_screen/views/payment_card_widget.dart';
import 'package:iparkmobileapplication/utils/themes/app_colors.dart';
import 'package:provider/provider.dart';

class PaymentCardsScreen extends StatelessWidget {
  const PaymentCardsScreen({super.key});

  static const nameRoute = "payment_cards_screen";

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: ApplicationBar.appbar(
          "", const Icon(Icons.arrow_back), () => Navigator.pop(context)),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(12),
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.06),
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: const Color(0xff9F69B2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Balance", style: commonTextStyleforwallettext),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(
                            "70\$",
                            style: commonTextStyleforwallettext,
                          )),
                      GestureDetector(
                          onTap: () => null,
                          child: TextButton(
                              onPressed: () => null,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.add,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.01,
                                  ),
                                  Text(
                                    "Add balance",
                                    style: commonTextStyleforwallettext,
                                  ),
                                ],
                              )))
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.07),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Your cards :",
                    style: TextStyle(
                        color: MainColors.mainLightThemeColor, fontSize: 16),
                  ),
                  GestureDetector(
                      onTap: () => null,
                      child: TextButton(
                          onPressed: () => _showBottomSheet(context),
                          child: Row(
                            children: [
                              Icon(Icons.add,
                                  size: 16,
                                  color: MainColors.mainLightThemeColor),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.01,
                              ),
                              Text(
                                "Add a new card",
                                style: TextStyle(
                                    color: MainColors.mainLightThemeColor,
                                    fontSize: 16),
                              ),
                            ],
                          )))
                ],
              ),
            ),
            const Expanded(child: PaymentCardWidget())
          ],
        ),
      ),
    );
  }
}

TextStyle commonTextStyleforwallettext = const TextStyle(
    color: Colors.white,
    // fontWeight: FontWeight.bold,
    fontSize: 16);

TextStyle commonTextstyleforotherelemnets =
    TextStyle(color: MainColors.mainLightThemeColor, fontSize: 16);

void _showBottomSheet(BuildContext context) {
  final formKey = GlobalKey<FormState>();

  String name = '';
  int ccv = 0;
  int cardNUmber = 0;
  String expiryDate = "";

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Consumer<PaymentCardsProvider>(
        builder: (context, provider, child) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Fill out the form',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // Your form fields go here
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Name'),
                    onChanged: (value) => name = value
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Card Number'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => cardNUmber = int.parse(value)
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'CCV'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => ccv = int.parse(value)
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Expiry Date'),
                    keyboardType: TextInputType.datetime,
                    onChanged: (value) => expiryDate = value
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Close the bottom sheet
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Validate the form before submitting
                          if (formKey.currentState != null && formKey.currentState!.validate()) {
                            // Perform your card submission logic here
                            provider.addCard(PaymentCardModel(cardNumber: cardNUmber, ccv: ccv, expirtDate: expiryDate, fullName: name));
                            // Close the bottom sheet
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );

}
