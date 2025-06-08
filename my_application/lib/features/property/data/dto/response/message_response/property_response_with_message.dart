import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_application/features/property/data/dto/response/property_response.dart';

part 'property_response_with_message.freezed.dart';
part 'property_response_with_message.g.dart';

@freezed
class PropertyWithMessageResponse with _$PropertyWithMessageResponse {
  const factory PropertyWithMessageResponse({
    String? message,
    PropertyResponse? property,
  }) = _PropertyWithMessageResponse;

  factory PropertyWithMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$PropertyWithMessageResponseFromJson(json);
}
