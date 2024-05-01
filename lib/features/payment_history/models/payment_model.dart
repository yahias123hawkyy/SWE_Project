class PaymentModel {
  final int amount;
   String? date;
  final String userId;
  final String stationName;
  final int chargerId;

  PaymentModel({
    required this.amount,
     this.date,
    required this.userId,
    required this.stationName,
    required this.chargerId,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      amount: json['amount'],
      date: json['date'],
      userId: json['userId'],
      stationName: json['stationName'],
      chargerId: json['chargerId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      // 'date': date,
      'userId': userId,
      'stationName': stationName,
      'chargerId': chargerId,
    };
  }
}
