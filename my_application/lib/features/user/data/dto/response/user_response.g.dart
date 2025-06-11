// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserResponseImpl _$$UserResponseImplFromJson(Map<String, dynamic> json) =>
    _$UserResponseImpl(
      id: (json['id'] as num?)?.toInt(),
      email: json['email'] as String?,
      name: json['name'] as String?,
      role: json['role'] as String?,
      properties: json['properties'] as List<dynamic>?,
      bookedAppointments: json['bookedAppointments'] as List<dynamic>?,
      sellingAppointments: json['sellingAppointments'] as List<dynamic>?,
    );

Map<String, dynamic> _$$UserResponseImplToJson(_$UserResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'role': instance.role,
      'properties': instance.properties,
      'bookedAppointments': instance.bookedAppointments,
      'sellingAppointments': instance.sellingAppointments,
    };
