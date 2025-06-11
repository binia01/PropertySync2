// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'property_response.freezed.dart';
part 'property_response.g.dart';

@freezed
class PropertyResponse with _$PropertyResponse {
  const factory PropertyResponse({
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
  }) = _PropertyResponse;

  factory PropertyResponse.fromJson(Map<String, dynamic> json) =>
      _$PropertyResponseFromJson(json);
}
