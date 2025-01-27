import 'package:latlong2/latlong.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'store.freezed.dart';
part 'store.g.dart';

@freezed
class Store with _$Store {
  const factory Store({
    required int id,
    required String name,
    required LatLng location,
    required String address,
    required String phoneNumber,
    required String email,
    required String openingHours,
    required String holiday
  }) = _Store;

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);
}
