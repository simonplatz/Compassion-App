import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;

class Location {
  final String name;
  final String url;
  final maps.LatLng latLng;

  Location({
    required this.name,
    required this.url,
    required this.latLng,
  });
}

class LocationNames {
  static const String sduPsykologiskRadgivning = 'SDU Psykologisk Rådgivning';
  static const String ventilenOdense = 'Ventilen Odense';
  static const String livslinien = 'Livslinien';
  static const String psykologteametOdense = 'Psykologteamet v. Odense Kommune';
  static const String odenseSocialkompas = 'Odense Socialkompas';
}

final List<Location> locations = [
  Location(
    name: LocationNames.sduPsykologiskRadgivning,
    url: 'https://www.sdu.dk/en/uddannelse',
    latLng: maps.LatLng(55.3680, 10.4289),
  ),
  Location(
    name: LocationNames.ventilenOdense,
    url: 'https://ventilen.dk/ventil',
    latLng: maps.LatLng(55.4034, 10.3986),
  ),
  Location(
    name: LocationNames.livslinien,
    url: 'https://livslinien.dk/',
    latLng: maps.LatLng(55.6761, 12.5683),
  ),
  Location(
    name: LocationNames.psykologteametOdense,
    url: 'https://www.odense.dk/borger/familie-boern-og-unge/psykologteamet',
    latLng: maps.LatLng(55.4038, 10.4024),
  ),
  Location(
    name: LocationNames.odenseSocialkompas,
    url: 'https://socialkompas.dk/',
    latLng: maps.LatLng(55.4038, 10.4024),
  ),
];
