import 'dart:convert';

class RatingResult {
  int value;
  String assigned;

//<editor-fold desc="Data Methods">
  RatingResult({
    required this.value,
    required this.assigned,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RatingResult &&
          runtimeType == other.runtimeType &&
          value == other.value &&
          assigned == other.assigned);

  @override
  int get hashCode => value.hashCode ^ assigned.hashCode;

  @override
  String toString() {
    return 'RatingResult{ value: $value, assigned: $assigned,}';
  }

  RatingResult copyWith({
    int? value,
    String? assigned,
  }) {
    return RatingResult(
      value: value ?? this.value,
      assigned: assigned ?? this.assigned,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'assigned': assigned,
    };
  }

  factory RatingResult.fromMap(Map<String, dynamic> map) {
    return RatingResult(
      value: map['value'] as int,
      assigned: map['assigned'] as String,
    );
  }

  factory RatingResult.fromJson(String json) =>
      RatingResult.fromMap(jsonDecode(json));

//</editor-fold>
}
