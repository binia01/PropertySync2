import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_application/features/property/domain/model/property_model.dart';

part 'property_state.freezed.dart';

@freezed
class PropertyState with _$PropertyState {
  const factory PropertyState.initial() = _Initial;
  const factory PropertyState.loading() = _Loading;
  const factory PropertyState.created(PropertyModel property) = _Created;
  const factory PropertyState.loaded(PropertyModel property) = _Loaded;
  const factory PropertyState.allLoaded(List<PropertyModel> properties) =
      _AllLoaded;
  const factory PropertyState.updated(PropertyModel property) = _Updated;
  const factory PropertyState.deleted(PropertyModel property) = _Deleted;
  const factory PropertyState.error(String message) = _Error;
}
