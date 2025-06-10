import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/core/data/remote/network_service.dart';
import 'package:my_application/core/data/remote/token/itoken_service.dart';
import 'package:my_application/core/data/remote/token/token_service.dart';
import 'package:my_application/features/user/application/iuser_service.dart';
import 'package:my_application/features/user/application/user_service.dart';
import 'package:my_application/features/user/data/dto/request/user_request.dart';
import 'package:my_application/features/user/presentation/state/user_state.dart';

final userControllerProvider = StateNotifierProvider<UserController, UserState>(
  (ref) {
    final userService = ref.watch(userServiceProvider);
    final tokenService = ref.watch(
      tokenServiceProvider(ref.watch(networkServiceProvider)),
    );
    return UserController(userService, tokenService);
  },
);

class UserController extends StateNotifier<UserState> {
  final IuserService _userService;
  final ITokenService _tokenService;

  UserController(this._userService, this._tokenService)
    : super(const UserState.initial());

  Future<void> getUser() async {
    state = const UserState.loading();
    try {
      final dto = await _userService.getUser();
      state = UserState.loaded(dto);
    } catch (e) {
      state = UserState.error(e.toString());
    }
  }

  Future<void> editUser(UserRequest request) async {
    state = const UserState.loading();
    try {
      final dto = await _userService.editUser(request);
      state = UserState.loaded(dto);
    } catch (e) {
      state = UserState.error(e.toString());
    }
  }

  Future<void> deleteUser() async {
    state = UserState.loading();
    try {
      await _userService.deleteUser();
      _tokenService.clearToken();
      state = UserState.deleted();
    } catch (e) {
      state = UserState.error(e.toString());
    }
  }

  void logout() {
    _tokenService.clearToken();
    state = UserState.loggedOut();
  }
}
