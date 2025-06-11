// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppointmentRequestImpl _$$AppointmentRequestImplFromJson(
  Map<String, dynamic> json,
) => _$AppointmentRequestImpl(
  propertyId: (json['propertyId'] as num?)?.toInt(),
  date: json['Date'] as String?,
  startTime: json['startTime'] as String?,
  status: json['status'] as String?,
);

Map<String, dynamic> _$$AppointmentRequestImplToJson(
  _$AppointmentRequestImpl instance,
) => <String, dynamic>{
  'propertyId': instance.propertyId,
  'Date': instance.date,
  'startTime': instance.startTime,
  'status': instance.status,
};
