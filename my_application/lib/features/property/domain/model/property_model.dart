// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'property_model.freezed.dart';

@freezed
class PropertyModel with _$PropertyModel {
  const factory PropertyModel({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "createdAt") DateTime? createdAt,
    @JsonKey(name: "updatedAt") DateTime? updatedAt,
    @JsonKey(name: "title") String? title,
    @JsonKey(name: "description") String? description,
    @JsonKey(name: "price") int? price,
    @JsonKey(name: "location") String? location,
    @JsonKey(name: "beds") int? beds,
    @JsonKey(name: "baths") int? baths,
    @JsonKey(name: "area") int? area,
    @JsonKey(name: "status") String? status,
    @JsonKey(name: "sellerId") int? sellerId,
  }) = _PropertyModel;
}
