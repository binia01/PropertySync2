// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppointmentResponseImpl _$$AppointmentResponseImplFromJson(
  Map<String, dynamic> json,
) => _$AppointmentResponseImpl(
  id: (json['id'] as num?)?.toInt(),
  createdAt:
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
  updatedAt:
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
  startTime: json['startTime'] as String?,
  date: json['Date'] as String?,
  propertyId: (json['propertyId'] as num?)?.toInt(),
  buyerId: (json['buyerId'] as num?)?.toInt(),
  sellerId: (json['sellerId'] as num?)?.toInt(),
  status: json['status'] as String?,
);

Map<String, dynamic> _$$AppointmentResponseImplToJson(
  _$AppointmentResponseImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'startTime': instance.startTime,
  'Date': instance.date,
  'propertyId': instance.propertyId,
  'buyerId': instance.buyerId,
  'sellerId': instance.sellerId,
  'status': instance.status,
};
