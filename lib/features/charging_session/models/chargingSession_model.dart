import 'dart:ffi';

class ChargingSession {
  final String stationName;
  final String id;
  final String userId;
  final String chargerId;
  DateTime? startTime;
  DateTime? endTime;
  double powerWat;
  double cost;
  double duration;
  String status;
  bool isConnected;

  ChargingSession({
    required this.stationName,
    required this.id,
    required this.userId,
    required this.chargerId,
    this.startTime,
    this.endTime,
    required this.powerWat,
    required this.cost,
    required this.duration,
    required this.status,
    required this.isConnected,
  });

  factory ChargingSession.fromJson(Map<String, dynamic> json) {
    return ChargingSession(
      stationName: json['stationName'] ?? "enel",
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      chargerId: json['chargerId'] ?? '',
      startTime: json['startTime'] != null ? DateTime.parse(json['startTime']) : null,
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
      powerWat: (json['powerWat'] ?? 0).toDouble(),
      cost: (json['cost'] ?? 0).toDouble(),
      duration: (json['duration'] ?? 0).toDouble(),
      status: json['status'] ?? 'initialized',
      isConnected: json['isConnected'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "stationName":stationName,
      '_id': id,
      'userId': userId,
      'chargerId': chargerId,
      'startTime': startTime?.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'powerWat': powerWat,
      'cost': cost,
      'duration': duration,
      'status': status,
      'isConnected': isConnected,
    };
  }
}
