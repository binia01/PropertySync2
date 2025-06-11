// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_response_with_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PropertyWithMessageResponseImpl _$$PropertyWithMessageResponseImplFromJson(
  Map<String, dynamic> json,
) => _$PropertyWithMessageResponseImpl(
  message: json['message'] as String?,
  property:
      json['property'] == null
          ? null
          : PropertyResponse.fromJson(json['property'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$PropertyWithMessageResponseImplToJson(
  _$PropertyWithMessageResponseImpl instance,
) => <String, dynamic>{
  'message': instance.message,
  'property': instance.property,
};
