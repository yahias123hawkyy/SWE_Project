

import 'package:iparkmobileapplication/features/station/models/charger_model.dart';

class Station {
  final String id;
  final String locationLat;
  final String locationLong;
  final String status;
  final List<Charger> chargers; 
  final String title;
  final String addressLine1;
  final String addressLine2;
  final String town;
  

  Station({
    required this.id,
    required this.locationLat,
    required this.locationLong,
    required this.status,
    required this.chargers,
    required this.title,
    required this.addressLine1,
    required this.addressLine2,
    required this.town,
  });

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      id: json['ID'],
      locationLat: json['locationLat'],
      locationLong: json['locationLong'],
      status: json['status'],
      chargers: List<Charger>.from(json['chargers'].map((model) => Charger.fromJson(model))),
      title: json['title'],
      addressLine1: json['addressLine1'],
      addressLine2: json['addressLine2'],
      town: json['town'] ?? '', 
    );
  }
}