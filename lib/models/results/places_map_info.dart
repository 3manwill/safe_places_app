import 'dart:convert';

import 'package:safe_places_app/models/results/place_result.dart';

class PlacesMapInfo {
  final List<PlaceResult> places;
  final String mapKey;

//<editor-fold desc="Data Methods">
  const PlacesMapInfo({
    required this.places,
    required this.mapKey,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlacesMapInfo &&
          runtimeType == other.runtimeType &&
          places == other.places &&
          mapKey == other.mapKey);

  @override
  int get hashCode => places.hashCode ^ mapKey.hashCode;

  @override
  String toString() {
    return 'PlacesMapInfo{ places: $places, mapKey: $mapKey,}';
  }

  PlacesMapInfo copyWith({
    List<PlaceResult>? places,
    String? mapKey,
  }) {
    return PlacesMapInfo(
      places: places ?? this.places,
      mapKey: mapKey ?? this.mapKey,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'places': places,
      'mapKey': mapKey,
    };
  }

  factory PlacesMapInfo.fromMap(Map<String, dynamic> map) {
    return PlacesMapInfo(
      places: map['places'] as List<PlaceResult>,
      mapKey: map['mapKey'] as String,
    );
  }



  factory PlacesMapInfo.fromJson(String json) =>
      PlacesMapInfo.fromMap(jsonDecode(json) as Map<String, dynamic>);

//</editor-fold>
}