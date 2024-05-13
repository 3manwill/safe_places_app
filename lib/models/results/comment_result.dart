import 'dart:convert';

class CommentResult {
  final String id;
  final String content;
  final String date;
  final String userName;

//<editor-fold desc="Data Methods">
  CommentResult({
    required this.id,
    required this.content,
    required this.date,
    required this.userName,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CommentResult &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          content == other.content &&
          date == other.date &&
          userName == other.userName);

  @override
  int get hashCode =>
      id.hashCode ^ content.hashCode ^ date.hashCode ^ userName.hashCode;

  @override
  String toString() {
    return 'CommentResult{ id: $id, content: $content, date: $date, userName: $userName,}';
  }

  CommentResult copyWith({
    String? id,
    String? content,
    String? date,
    String? userName,
  }) {
    return CommentResult(
      id: id ?? this.id,
      content: content ?? this.content,
      date: date ?? this.date,
      userName: userName ?? this.userName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'date': date,
      'userName': userName,
    };
  }

  factory CommentResult.fromMap(Map<String, dynamic> map) {
    return CommentResult(
      id: map['id'] as String,
      content: map['content'] as String,
      date: map['date'] as String,
      userName: map['userName'] as String,
    );
  }

  factory CommentResult.fromJson(String json) =>
      CommentResult.fromMap(jsonDecode(json));

//</editor-fold>
}
