class PaymentCardModel {
  final String cardNumber;
  final String expirationDate;
  final String cardholderName;
  final String cvv;
  final String userId;

  PaymentCardModel({
    required this.cardNumber,
    required this.expirationDate,
    required this.cardholderName,
    required this.cvv,
    required this.userId,
  });

  factory PaymentCardModel.fromJson(Map<String, dynamic> json) {
    return PaymentCardModel(
      cardNumber: json['cardNumber'],
      expirationDate: json['expirationDate'],
      cardholderName: json['cardholderName'],
      cvv: json['cvv'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cardNumber': cardNumber,
      'expirationDate': expirationDate,
      'cardholderName': cardholderName,
      'cvv': cvv,
      'userId': userId,
    };
  }
}
