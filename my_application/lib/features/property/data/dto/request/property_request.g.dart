// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PropertyRequestImpl _$$PropertyRequestImplFromJson(
  Map<String, dynamic> json,
) => _$PropertyRequestImpl(
  title: json['title'] as String?,
  description: json['description'] as String?,
  price: (json['price'] as num?)?.toInt(),
  location: json['location'] as String?,
  beds: (json['beds'] as num?)?.toInt(),
  baths: (json['baths'] as num?)?.toInt(),
  area: (json['area'] as num?)?.toInt(),
);

Map<String, dynamic> _$$PropertyRequestImplToJson(
  _$PropertyRequestImpl instance,
) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'price': instance.price,
  'location': instance.location,
  'beds': instance.beds,
  'baths': instance.baths,
  'area': instance.area,
};
