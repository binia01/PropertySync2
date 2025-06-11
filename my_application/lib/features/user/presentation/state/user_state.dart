import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_application/features/user/domain/model/user_model.dart';

part 'user_state.freezed.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.initial() = _Initial;
  const factory UserState.loading() = _Loading;
  const factory UserState.loaded(UserModel user) = _Loaded;
  const factory UserState.loggedOut() = _LoggedOut;
  const factory UserState.deleted() = _Deleted;
  const factory UserState.error(String message) = _Error;
}
