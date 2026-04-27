// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_parts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndonesiaGeoAddress _$IndonesiaGeoAddressFromJson(Map<String, dynamic> json) =>
    IndonesiaGeoAddress(
      provinsi: json['provinsi'] as String,
      kabupaten: json['kabupaten'] as String,
      kecamatan: json['kecamatan'] as String,
      kelurahan: json['kelurahan'] as String,
    );

Map<String, dynamic> _$IndonesiaGeoAddressToJson(
  IndonesiaGeoAddress instance,
) => <String, dynamic>{
  'provinsi': instance.provinsi,
  'kabupaten': instance.kabupaten,
  'kecamatan': instance.kecamatan,
  'kelurahan': instance.kelurahan,
};

GlobalGeoAddress _$GlobalGeoAddressFromJson(Map<String, dynamic> json) =>
    GlobalGeoAddress(
      l1: json['l1'] as String,
      l2: json['l2'] as String,
      l3: json['l3'] as String,
    );

Map<String, dynamic> _$GlobalGeoAddressToJson(GlobalGeoAddress instance) =>
    <String, dynamic>{'l1': instance.l1, 'l2': instance.l2, 'l3': instance.l3};

LocationParts _$LocationPartsFromJson(Map<String, dynamic> json) =>
    LocationParts(
      countryCode: json['countryCode'] as String,
      idAddress: json['idAddress'] == null
          ? null
          : IndonesiaGeoAddress.fromJson(
              json['idAddress'] as Map<String, dynamic>,
            ),
      globalAddress: json['globalAddress'] == null
          ? null
          : GlobalGeoAddress.fromJson(
              json['globalAddress'] as Map<String, dynamic>,
            ),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      geoHash: json['geoHash'] as String,
    );

Map<String, dynamic> _$LocationPartsToJson(LocationParts instance) =>
    <String, dynamic>{
      'countryCode': instance.countryCode,
      'idAddress': instance.idAddress?.toJson(),
      'globalAddress': instance.globalAddress?.toJson(),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'geoHash': instance.geoHash,
    };
