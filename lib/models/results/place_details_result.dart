import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:safe_places_app/models/results/comment_result.dart';
import 'package:safe_places_app/models/results/feature_result.dart';
import 'package:safe_places_app/models/results/place_image_result.dart';
import 'package:safe_places_app/models/results/rating_result.dart';

enum UserExistsStatus { notExists, pending, accepted, rejected }

class PlaceDetailsResult {
  final String id;
  final String title;
  final String description;
  final double latitude;
  final double longitude;
  final int rating;
  final bool expired;
  final int size;
  final String creatorId;
  final String creatorName;
  UserExistsStatus existsStatus;
  final int availableSize;
  final RatingResult userRating;
  final List<PlaceImageResult> images;
  final List<CommentResult> comments;
  final List<FeatureResult> features;

  factory PlaceDetailsResult.fromJson(String json) =>
      PlaceDetailsResult.fromMap(jsonDecode(json));

//<editor-fold desc="Data Methods">
  PlaceDetailsResult({
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
    required this.existsStatus,
    required this.availableSize,
    required this.userRating,
    required this.images,
    required this.comments,
    required this.features,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaceDetailsResult &&
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
          creatorName == other.creatorName &&
          existsStatus == other.existsStatus &&
          availableSize == other.availableSize &&
          userRating == other.userRating &&
          images == other.images &&
          comments == other.comments &&
          features == other.features);

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
      creatorName.hashCode ^
      existsStatus.hashCode ^
      availableSize.hashCode ^
      userRating.hashCode ^
      images.hashCode ^
      comments.hashCode ^
      features.hashCode;

  @override
  String toString() {
    return 'PlaceDetailsResult{ id: $id, title: $title, description: $description, latitude: $latitude, longitude: $longitude, rating: $rating, expired: $expired, size: $size, creatorId: $creatorId, creatorName: $creatorName, existsStatus: $existsStatus, availableSize: $availableSize, userRating: $userRating, images: $images, comments: $comments, features: $features,}';
  }

  PlaceDetailsResult copyWith({
    String? id,
    String? title,
    String? description,
    double? latitude,
    double? longitude,
    int? rating,
    bool? expired,
    int? size,
    String? creatorId,
    String? creatorName,
    UserExistsStatus? existsStatus,
    int? availableSize,
    RatingResult? userRating,
    List<PlaceImageResult>? images,
    List<CommentResult>? comments,
    List<FeatureResult>? features,
  }) {
    return PlaceDetailsResult(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      rating: rating ?? this.rating,
      expired: expired ?? this.expired,
      size: size ?? this.size,
      creatorId: creatorId ?? this.creatorId,
      creatorName: creatorName ?? this.creatorName,
      existsStatus: existsStatus ?? this.existsStatus,
      availableSize: availableSize ?? this.availableSize,
      userRating: userRating ?? this.userRating,
      images: images ?? this.images,
      comments: comments ?? this.comments,
      features: features ?? this.features,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'rating': rating,
      'expired': expired,
      'size': size,
      'creatorId': creatorId,
      'creatorName': creatorName,
      'existsStatus': existsStatus,
      'availableSize': availableSize,
      'userRating': userRating,
      'images': images,
      'comments': comments,
      'features': features,
    };
  }

  factory PlaceDetailsResult.fromMap(Map<String, dynamic> map) {
    return PlaceDetailsResult(
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
      existsStatus:UserExistsStatus.values[map['existsStatus'] as int],
      availableSize: map['availableSize'] as int,
      userRating: RatingResult.fromMap(map['userRating']),
      images: (map['images'] as List).map((imgMap) => PlaceImageResult.fromMap(imgMap)).toList(),
      comments: (map['comments'] as List).map((commentMap) => CommentResult.fromMap(commentMap)).toList(),
      features: (map['features'] as List).map((fMap) => FeatureResult.fromMap(fMap)).toList(),
    );
  }

//</editor-fold>
}
