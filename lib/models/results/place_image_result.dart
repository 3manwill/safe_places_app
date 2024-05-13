class PlaceImageResult {
  String id;
  String fileName;
  String contentType;
  String storageId;
  String url;

//<editor-fold desc="Data Methods">
  PlaceImageResult({
    required this.id,
    required this.fileName,
    required this.contentType,
    required this.storageId,
    required this.url,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaceImageResult &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          fileName == other.fileName &&
          contentType == other.contentType &&
          storageId == other.storageId &&
          url == other.url);

  @override
  int get hashCode =>
      id.hashCode ^
      fileName.hashCode ^
      contentType.hashCode ^
      storageId.hashCode ^
      url.hashCode;

  @override
  String toString() {
    return 'PlaceImageResult{ id: $id, fileName: $fileName, contentType: $contentType, storageId: $storageId, url: $url,}';
  }

  PlaceImageResult copyWith({
    String? id,
    String? fileName,
    String? contentType,
    String? storageId,
    String? url,
  }) {
    return PlaceImageResult(
      id: id ?? this.id,
      fileName: fileName ?? this.fileName,
      contentType: contentType ?? this.contentType,
      storageId: storageId ?? this.storageId,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fileName': fileName,
      'contentType': contentType,
      'storageId': storageId,
      'url': url,
    };
  }

  factory PlaceImageResult.fromMap(Map<String, dynamic> map) {
    return PlaceImageResult(
      id: map['id'] as String,
      fileName: map['fileName'] as String,
      contentType: map['contentType'] as String,
      storageId: map['storageId'] as String,
      url: map['url'] as String,
    );
  }

//</editor-fold>
}
