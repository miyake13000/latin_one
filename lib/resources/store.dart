import 'package:latlong2/latlong.dart';

class Store {
  final int    id;
  final String name;
  final LatLng location;
  final String address;
  final String phoneNumber;
  final String openingHours;
  final String holiday;

  const Store(
    this. id,
    this.name,
    this.location,
    this.address,
    this.phoneNumber,
    this.openingHours,
    this.holiday
  );
}
