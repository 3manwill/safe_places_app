import 'package:safe_places_app/models/results/user_auth_result.dart';

enum ResponseStatus {
  ok,
  unauthorized,
  notFound,
  badRequest
}


class IdentityResult {
  final dynamic error;
  final UserAuthResult? userData;
  final ResponseStatus status;

//<editor-fold desc="Data Methods">
  const IdentityResult({
    this.error,
    this.userData,
    required this.status,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IdentityResult &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          userData == other.userData &&
          status == other.status);

  @override
  int get hashCode => error.hashCode ^ userData.hashCode ^ status.hashCode;

  @override
  String toString() {
    return 'IdentityResult{ error: $error, userData: $userData, status: $status,}';
  }

  IdentityResult copyWith({
    dynamic? error,
    UserAuthResult? userData,
    ResponseStatus? status,
  }) {
    return IdentityResult(
      error: error ?? this.error,
      userData: userData ?? this.userData,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'error': error,
      'userData': userData,
      'status': status,
    };
  }

  factory IdentityResult.fromMap(Map<String, dynamic> map) {
    return IdentityResult(
      error: map['error'] as dynamic,
      userData: map['userData'] as UserAuthResult,
      status: map['status'] as ResponseStatus,
    );
  }

//</editor-fold>
}