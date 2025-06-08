// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment_model.freezed.dart';

@freezed
class AppointmentModel with _$AppointmentModel {
  const factory AppointmentModel({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "createdAt") DateTime? createdAt,
    @JsonKey(name: "updatedAt") DateTime? updatedAt,
    @JsonKey(name: "startTime") DateTime? startTime,
    @JsonKey(name: "Date") DateTime? date, // fixed key
    @JsonKey(name: "propertyId") int? propertyId,
    @JsonKey(name: "buyerId") int? buyerId,
    @JsonKey(name: "sellerId") int? sellerId,
    @JsonKey(name: "status") String? status,
  }) = _AppointmentModel;
}
