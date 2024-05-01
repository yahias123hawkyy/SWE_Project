import 'package:iparkmobileapplication/features/station/models/offer_model.dart';

class Charger {
  final String stationId;
  final String id;
  final int connectionTypeID;
  final int?
      statusTypeID; // Making it nullable since it's not marked as required
  final int levelID;
  final double powerKW;
  final int? currentTypeID; // Nullable for the same reason
  final int quantity;
  final double price;
  final List<Offer> offers; // Assuming Offers is an array of Offer objects
  final String chargerStatus;

  Charger({
    required this.chargerStatus,
    required this.stationId,
    required this.id,
    required this.connectionTypeID,
    this.statusTypeID,
    required this.levelID,
    required this.powerKW,
    this.currentTypeID,
    required this.quantity,
    required this.price,
    required this.offers,
  });
  factory Charger.fromJson(Map<String, dynamic> json) {
    return Charger(
      stationId: json['stationId'],
      id: json['ID'],
      chargerStatus: json['chargerStatus'],
      connectionTypeID: json['ConnectionTypeID'],
      statusTypeID: json['StatusTypeID'],
      levelID: json['LevelID'],
      powerKW: json['PowerKW'].toDouble(),
      currentTypeID: json['CurrentTypeID'],
      quantity: json['Quantity'],
      price: json['Price'].toDouble(),
      offers: List<Offer>.from(json['Offers'].map((x) => Offer.fromJson(x))),
    );
  }
}
