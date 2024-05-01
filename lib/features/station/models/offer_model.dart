class Offer {
  final String deadline;
  final String name;
  final double newPrice;

  Offer({
    required this.deadline,
    required this.name,
    required this.newPrice,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      deadline: json['Deadline'],
      name: json['Name'],
      newPrice: (json['newPrice'] as num).toDouble(), // Ensures compatibility with int and double types from JSON
    );
  }
}