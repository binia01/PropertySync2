// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppointmentRequestImpl _$$AppointmentRequestImplFromJson(
  Map<String, dynamic> json,
) => _$AppointmentRequestImpl(
  propertyId: (json['propertyId'] as num?)?.toInt(),
  date: json['Date'] == null ? null : DateTime.parse(json['Date'] as String),
  startTime:
      json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
);

Map<String, dynamic> _$$AppointmentRequestImplToJson(
  _$AppointmentRequestImpl instance,
) => <String, dynamic>{
  'propertyId': instance.propertyId,
  'Date': instance.date?.toIso8601String(),
  'startTime': instance.startTime?.toIso8601String(),
};
