// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserRequestImpl _$$UserRequestImplFromJson(Map<String, dynamic> json) =>
    _$UserRequestImpl(
      email: json['email'] as String?,
      name: json['name'] as String?,
      role: json['role'] as String?,
      bookedAppointments: json['bookedAppointments'] as List<dynamic>?,
      sellingAppointments: json['sellingAppointments'] as List<dynamic>?,
    );

Map<String, dynamic> _$$UserRequestImplToJson(_$UserRequestImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'role': instance.role,
      'bookedAppointments': instance.bookedAppointments,
      'sellingAppointments': instance.sellingAppointments,
    };
