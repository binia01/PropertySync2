// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'property_request.freezed.dart';
part 'property_request.g.dart';

@freezed
class PropertyRequest with _$PropertyRequest {
  const factory PropertyRequest({
    @JsonKey(name: "title") String? title,
    @JsonKey(name: "description") String? description,
    @JsonKey(name: "price") int? price,
    @JsonKey(name: "location") String? location,
    @JsonKey(name: "beds") int? beds,
    @JsonKey(name: "baths") int? baths,
    @JsonKey(name: "area") int? area,
  }) = _PropertyRequest;

  factory PropertyRequest.fromJson(Map<String, dynamic> json) =>
      _$PropertyRequestFromJson(json);
}
