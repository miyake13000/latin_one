import 'package:latlong2/latlong.dart';

class Store {
  final int    id;
  final String name;
  final LatLng location;
  final String address;
  final String phoneNumber;
  final String email;
  final String openingHours;
  final String holiday;

  const Store({
    required this. id,
    required this.name,
    required this.location,
    required this.address,
    required this.phoneNumber,
    required this.email,
    required this.openingHours,
    required this.holiday
  });

  Store.fromMap(Map<String, dynamic> map)
      : this(
              id           : map['id'],
              name         : map['name'],
              location     : LatLng(map['location'].latitude, map['location'].longitude),
              address      : map['address'],
              phoneNumber  : map['phoneNumber'],
              email        : map['email'],
              openingHours : map['openingHours'],
              holiday      : map['holiday'],
            );

  static String collectionPath() {
    return '/stores';
  }
}
