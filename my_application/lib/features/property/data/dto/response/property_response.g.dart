// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PropertyResponseImpl _$$PropertyResponseImplFromJson(
  Map<String, dynamic> json,
) => _$PropertyResponseImpl(
  id: (json['id'] as num?)?.toInt(),
  createdAt:
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
  updatedAt:
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
  title: json['title'] as String?,
  description: json['description'] as String?,
  price: (json['price'] as num?)?.toInt(),
  location: json['location'] as String?,
  beds: (json['beds'] as num?)?.toInt(),
  baths: (json['baths'] as num?)?.toInt(),
  area: (json['area'] as num?)?.toInt(),
  status: json['status'] as String?,
  sellerId: (json['sellerId'] as num?)?.toInt(),
);

Map<String, dynamic> _$$PropertyResponseImplToJson(
  _$PropertyResponseImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'title': instance.title,
  'description': instance.description,
  'price': instance.price,
  'location': instance.location,
  'beds': instance.beds,
  'baths': instance.baths,
  'area': instance.area,
  'status': instance.status,
  'sellerId': instance.sellerId,
};
