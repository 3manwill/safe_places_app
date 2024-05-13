class Coords {
  final double lat;
  final double lng;

//<editor-fold desc="Data Methods">
  const Coords({
    required this.lat,
    required this.lng,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Coords &&
          runtimeType == other.runtimeType &&
          lat == other.lat &&
          lng == other.lng);

  @override
  int get hashCode => lat.hashCode ^ lng.hashCode;

  @override
  String toString() {
    return 'Coords{ lat: $lat, lng: $lng,}';
  }

  Coords copyWith({
    double? lat,
    double? lng,
  }) {
    return Coords(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }

  factory Coords.fromMap(Map<String, dynamic> map) {
    return Coords(
      lat: map['lat'] as double,
      lng: map['lng'] as double,
    );
  }

//</editor-fold>
}