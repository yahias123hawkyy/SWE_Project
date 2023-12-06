import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iparkmobileapplication/common/widgets/app_bar.dart';
import 'package:iparkmobileapplication/features/payment_cards_screen/models/paymet_card_model.dart';
import 'package:iparkmobileapplication/features/payment_cards_screen/provider/payment_card_provider.dart';
import 'package:iparkmobileapplication/features/payment_cards_screen/views/payment_card_wedget.dart';
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
          "", Icon(Icons.arrow_back), () => Navigator.pop(context)),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.06),
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: Color(0xff9F69B2),
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
                          padding: EdgeInsets.only(left: 12),
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
                                  Icon(
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
            Expanded(child: PaymentCardWidget())
          ],
        ),
      ),
    );
  }
}

TextStyle commonTextStyleforwallettext = TextStyle(
    color: Colors.white,
    // fontWeight: FontWeight.bold,
    fontSize: 16);

TextStyle commonTextstyleforotherelemnets =
    TextStyle(color: MainColors.mainLightThemeColor, fontSize: 16);

void _showBottomSheet(BuildContext context) {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  int _ccv = 0;
  int _cardNUmber = 0;
  String _expiryDate = "";

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Consumer<PaymentCardsProvider>(
        builder: (context, provider, child) {
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Fill out the form',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  // Your form fields go here
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name'),
                    onChanged: (value) => _name = value
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Card Number'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => _cardNUmber = int.parse(value)
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'CCV'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => _ccv = int.parse(value)
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Expiry Date'),
                    keyboardType: TextInputType.datetime,
                    onChanged: (value) => _expiryDate = value
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Close the bottom sheet
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Validate the form before submitting
                          if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                            // Perform your card submission logic here
                            provider.addCard(PaymentCardModel(cardNumber: _cardNUmber, ccv: _ccv, expirtDate: _expiryDate, fullName: _name));
                            // Close the bottom sheet
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text(
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
