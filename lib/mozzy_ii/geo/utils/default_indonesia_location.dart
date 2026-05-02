import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import '../models/location_parts.dart';

/// Jakarta Senayan / Kebayoran Baru / Jakarta Selatan
/// Used as a hard fallback for the Indonesian market in MVP.
LocationParts defaultJakartaSenayanLocation() {
  return LocationParts(
    countryCode: 'ID',
    idAddress: const IndonesiaGeoAddress(
      provinsi: 'DKI Jakarta',
      kabupaten: 'Jakarta Selatan',
      kecamatan: 'Kebayoran Baru',
      kelurahan: 'Senayan',
    ),
    latitude: -6.2275,
    longitude: 106.7996,
    geoHash: GeoFirePoint(
      const GeoPoint(-6.2275, 106.7996),
    ).geohash,
  );
}
