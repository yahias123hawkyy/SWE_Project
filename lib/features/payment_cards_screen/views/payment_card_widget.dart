import 'package:flutter/material.dart';
import 'package:iparkmobileapplication/features/payment_cards_screen/models/paymet_card_model.dart';
import 'package:iparkmobileapplication/features/payment_cards_screen/provider/payment_card_provider.dart';
import 'package:provider/provider.dart';

class PaymentCardWidget extends StatelessWidget {
  const PaymentCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentCardsProvider>(
      builder: (context, cardProvider, child) {
        return ListView.builder(
            itemCount: DummyCards.cards.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.1),
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: Text(DummyCards.cards[index].fullName),
                  title: Text(DummyCards.cards[index].cardNumber.toString()),
                ),
              );
            });
      },
    );
  }
}
