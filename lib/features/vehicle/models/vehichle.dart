class VehichleModel{
  final String carType;
  final String model;
  final int year;
  final String userId; // Assuming the userId is passed around as a string

  VehichleModel({
    required this.carType,
    required this.model,
    required this.year,
    required this.userId,
  });

  factory VehichleModel.fromJson(Map<String, dynamic> json) {
    return VehichleModel(
      carType: json['carType'],
      model: json['model'],
      year: json['year'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'carType': carType,
      'model': model,
      'year': year,
      'userId': userId,
    };
  }
}