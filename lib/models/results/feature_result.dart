class FeatureResult {
  final String id;
  final String title;
  final String value;

//<editor-fold desc="Data Methods">
  const FeatureResult({
    required this.id,
    required this.title,
    required this.value,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeatureResult &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          value == other.value);

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ value.hashCode;

  @override
  String toString() {
    return 'FeatureResult{ id: $id, title: $title, value: $value,}';
  }

  FeatureResult copyWith({
    String? id,
    String? title,
    String? value,
  }) {
    return FeatureResult(
      id: id ?? this.id,
      title: title ?? this.title,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'value': value,
    };
  }

  factory FeatureResult.fromMap(Map<String, dynamic> map) {
    return FeatureResult(
      id: map['id'] as String,
      title: map['title'] as String,
      value: map['value'] as String,
    );
  }

//</editor-fold>
}
