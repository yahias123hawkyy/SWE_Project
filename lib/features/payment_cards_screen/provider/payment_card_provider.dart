import 'package:flutter/material.dart';
import 'package:iparkmobileapplication/features/payment_cards_screen/models/paymet_card_model.dart';
import 'package:provider/provider.dart';

class PaymentCardsProvider extends ChangeNotifier {

  
  void addCard(PaymentCardModel card) {

    DummyCards.cards.add(card);

    notifyListeners();
  }
}
