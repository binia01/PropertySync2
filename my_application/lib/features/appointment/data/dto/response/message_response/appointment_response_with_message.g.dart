// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_response_with_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppointmentWithMessageResponseImpl
_$$AppointmentWithMessageResponseImplFromJson(Map<String, dynamic> json) =>
    _$AppointmentWithMessageResponseImpl(
      message: json['message'] as String?,
      appointment:
          json['appointment'] == null
              ? null
              : AppointmentResponse.fromJson(
                json['appointment'] as Map<String, dynamic>,
              ),
    );

Map<String, dynamic> _$$AppointmentWithMessageResponseImplToJson(
  _$AppointmentWithMessageResponseImpl instance,
) => <String, dynamic>{
  'message': instance.message,
  'appointment': instance.appointment,
};
