// lib/core/providers/user_auth_data.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_auth_data.freezed.dart';
part 'user_auth_data.g.dart';

@freezed
class UserAuthData with _$UserAuthData {
  const factory UserAuthData({
    String? role,
    String? userId,
  }) = _UserAuthData;

  factory UserAuthData.fromJson(Map<String, dynamic> json) => _$UserAuthDataFromJson(json);
}