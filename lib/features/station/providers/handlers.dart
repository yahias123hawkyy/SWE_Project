import 'dart:math';

abstract class SationScreenHandler{


  static double _toRadians(double degree) {
  return degree * pi / 180;
}
static double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  var earthRadius = 6371; // Radius of the Earth in kilometers
  var dLat = _toRadians(lat2 - lat1);
  var dLon = _toRadians(lon2 - lon1);
  var a = 
    sin(dLat/2) * sin(dLat/2) +
    cos(_toRadians(lat1)) * cos(_toRadians(lat2)) * 
    sin(dLon/2) * sin(dLon/2);
  var c = 2 * atan2(sqrt(a), sqrt(1-a));
  var distance = earthRadius * c; 
  return distance;
}

}