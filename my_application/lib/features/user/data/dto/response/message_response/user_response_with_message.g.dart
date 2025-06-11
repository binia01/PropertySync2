// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response_with_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserWithMessageResponseImpl _$$UserWithMessageResponseImplFromJson(
  Map<String, dynamic> json,
) => _$UserWithMessageResponseImpl(
  message: json['message'] as String?,
  user:
      json['user'] == null
          ? null
          : UserResponse.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$UserWithMessageResponseImplToJson(
  _$UserWithMessageResponseImpl instance,
) => <String, dynamic>{'message': instance.message, 'user': instance.user};
