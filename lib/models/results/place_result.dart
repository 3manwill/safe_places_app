import 'dart:convert';

import 'package:flutter/foundation.dart';

class PlaceResult {
  final String id;
  String title;
  String description;
  final double latitude;
  final double longitude;
  final int rating;
  final bool expired;
  final int size;
  final String creatorId;
  String creatorName;

//<editor-fold desc="Data Methods">
  PlaceResult({
    required this.id,
    required this.title,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.rating,
    required this.expired,
    required this.size,
    required this.creatorId,
    required this.creatorName,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaceResult &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description &&
          latitude == other.latitude &&
          longitude == other.longitude &&
          rating == other.rating &&
          expired == other.expired &&
          size == other.size &&
          creatorId == other.creatorId &&
          creatorName == other.creatorName);

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      rating.hashCode ^
      expired.hashCode ^
      size.hashCode ^
      creatorId.hashCode ^
      creatorName.hashCode;

  @override
  String toString() {
    return 'PlaceResult{ id: $id, title: $title, description: $description, latitude: $latitude, longitude: $longitude, rating: $rating, expired: $expired, size: $size, creatorId: $creatorId, creatorName: $creatorName,}';
  }

  factory PlaceResult.fromMap(Map<String, dynamic> map) {

    return PlaceResult(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      rating: map['rating'] as int,
      expired: map['expired'] as bool,
      size: map['size'] as int,
      creatorId: map['creatorId'] as String,
      creatorName: map['creatorName'] as String,
    );
  }

//</editor-fold>
}