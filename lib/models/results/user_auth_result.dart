import 'dart:convert';

class UserAuthResult {
  String id;
  String userName;
  String email;
  String? photoUrl;
  List<String> roles;
  String token;

//<editor-fold desc="Data Methods">
  UserAuthResult({
    required this.id,
    required this.userName,
    required this.email,
    this.photoUrl,
    required this.roles,
    required this.token,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserAuthResult &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userName == other.userName &&
          email == other.email &&
          photoUrl == other.photoUrl &&
          roles == other.roles &&
          token == other.token);

  @override
  int get hashCode =>
      id.hashCode ^
      userName.hashCode ^
      email.hashCode ^
      photoUrl.hashCode ^
      roles.hashCode ^
      token.hashCode;

  @override
  String toString() {
    return 'UserAuthResult{ id: $id, userName: $userName, email: $email, photoUrl: $photoUrl, roles: $roles, token: $token,}';
  }

  UserAuthResult copyWith({
    String? id,
    String? userName,
    String? email,
    String? photoUrl,
    List<String>? roles,
    String? token,
  }) {
    return UserAuthResult(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      roles: roles ?? this.roles,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userName': userName,
      'email': email,
      'photoUrl': photoUrl,
      'roles': roles,
      'token': token,
    };
  }

  factory UserAuthResult.fromMap(Map<String, dynamic> map) {
    return UserAuthResult(
      id: map['id'] as String,
      userName: map['userName'] as String,
      email: map['email'] as String,
      photoUrl: map['photoUrl'] as String?,
      roles: map['roles'] as List<String>,
      token: map['token'] as String,
    );
  }



  factory UserAuthResult.fromJson(String json){
    Map<String, dynamic> map = jsonDecode(json);



    return UserAuthResult(
      id: map['id'] as String,
      userName: map['userName'] as String,
      email: map['email'] as String,
      photoUrl: map['photoUrl'] as String?,
      roles: [],
      token: map['token'] as String,
    );
  }

//</editor-fold>
}