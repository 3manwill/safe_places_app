class CommentParams {
  String placeId;
  String content;

//<editor-fold desc="Data Methods">
  CommentParams({
    required this.placeId,
    required this.content,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CommentParams &&
          runtimeType == other.runtimeType &&
          placeId == other.placeId &&
          content == other.content);

  @override
  int get hashCode => placeId.hashCode ^ content.hashCode;

  @override
  String toString() {
    return 'CommentParams{ placeId: $placeId, content: $content,}';
  }

  CommentParams copyWith({
    String? placeId,
    String? content,
  }) {
    return CommentParams(
      placeId: placeId ?? this.placeId,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'placeId': placeId,
      'content': content,
    };
  }

  factory CommentParams.fromMap(Map<String, dynamic> map) {
    return CommentParams(
      placeId: map['placeId'] as String,
      content: map['content'] as String,
    );
  }

//</editor-fold>
}