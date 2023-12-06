class PaymentCardModel {
  final int cardNumber;
  final String expirtDate;
  final int ccv;
  final String fullName;

  PaymentCardModel(
      {required this.cardNumber,
      required this.ccv,
      required this.expirtDate,
      required this.fullName});
}

abstract class DummyCards {
  static List<PaymentCardModel> cards = [
    PaymentCardModel(
        fullName: "Yahia Ahmed",
        cardNumber: 12345678978465465,
        ccv: 123,
        expirtDate: "12/25"),
    PaymentCardModel(
        fullName: "Yahia Ahmed",
        cardNumber: 12345678978465465,
        ccv: 123,
        expirtDate: "12/25"),
    PaymentCardModel(
        fullName: "Yahia Ahmed",
        cardNumber: 12345678978465465,
        ccv: 123,
        expirtDate: "12/25")
  ];
}
