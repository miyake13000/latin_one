import 'package:latlong2/latlong.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'store.freezed.dart';
part 'store.g.dart';

@freezed
class Store with _$Store {
  const factory Store({
    required int id,
    required String name,
    @GeoPointLatLngConverter() required LatLng location,
    required String address,
    required String phoneNumber,
    required String email,
    required String openingHours,
    required String holiday
  }) = _Store;

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);
}

class GeoPointLatLngConverter implements JsonConverter<LatLng, GeoPoint> {
  const GeoPointLatLngConverter();

  @override
  LatLng fromJson(GeoPoint json) {
    return LatLng(json.latitude, json.longitude);
  }

  @override
  GeoPoint toJson(LatLng l) {
    return GeoPoint(l.latitude, l.longitude);
  }
}
