// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoreImpl _$$StoreImplFromJson(Map<String, dynamic> json) => _$StoreImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      location: const GeoPointLatLngConverter()
          .fromJson(json['location'] as GeoPoint),
      address: json['address'] as String,
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
      openingHours: json['openingHours'] as String,
      holiday: json['holiday'] as String,
    );

Map<String, dynamic> _$$StoreImplToJson(_$StoreImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'location': const GeoPointLatLngConverter().toJson(instance.location),
      'address': instance.address,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'openingHours': instance.openingHours,
      'holiday': instance.holiday,
    };
