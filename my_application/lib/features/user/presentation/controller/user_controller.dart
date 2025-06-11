import'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/core/data/remote/network_service.dart';
import 'package:my_application/core/data/remote/token/itoken_service.dart';
import 'package:my_application/core/data/remote/token/token_service.dart';
import 'package:my_application/core/providers/user.role.provider.dart';
import 'package:my_application/features/user/application/iuser_service.dart';
import 'package:my_application/features/user/application/user_service.dart';
import 'package:my_application/features/user/data/dto/request/user_request.dart';
import 'package:my_application/features/user/domain/model/user_model.dart';
import 'package:my_application/features/user/presentation/state/user_state.dart';

final userControllerProvider = StateNotifierProvider<UserController, UserState>(
      (ref) {
    final userService = ref.watch(userServiceProvider);
    final tokenService = ref.watch(
      tokenServiceProvider(ref.watch(networkServiceProvider)),
    );
    return UserController(ref, userService, tokenService);
  },
);

class UserController extends StateNotifier<UserState> {
  final Ref _ref;
  final IuserService _userService;
  final ITokenService _tokenService;

  UserController(this._ref, this._userService, this._tokenService)
      : super(const UserState.initial());

  Future<void> getUser() async {
    state = const UserState.loading();
    try {
      final dto = await _userService.getUser();
      await _tokenService.saveRole(dto.role!);
      final roleCheck = await _tokenService.getRole();
      final tokenCheck = await _tokenService.getAccessToken();
      print('After login — Role: $roleCheck, Token: $tokenCheck');
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
      await _tokenService.clearToken();
      await _ref.read(userRoleProvider.notifier).clearRole();
      await _tokenService.clearRole();
      state = UserState.initial();
    } catch (e) {
      state = UserState.error(e.toString());
    }
  }

  Future<void> logout() async {
    print('Clearing token and role...');
    await _tokenService.clearToken();
    await _tokenService.clearRole();
    _ref.invalidate(tokenServiceProvider);
    await _ref.read(userRoleProvider.notifier).clearRole();

    final roleCheck = await _tokenService.getRole();
    final tokenCheck = await _tokenService.getAccessToken();
    print('After logout — Role: $roleCheck, Token: $tokenCheck');
    state = UserState.loggedOut();
  }
}

final userFormProvider =
StateNotifierProvider.autoDispose<UserFormController, UserRequest>(
      (ref) => UserFormController(),
);

class UserFormController extends StateNotifier<UserRequest> {
  UserFormController()
      : super(const UserRequest(firstname: "", lastname: "", email: ""));
  void setFromModel(UserModel model) {
    final fullName = model.name?.trim() ?? '';
    final email = model.email ?? '';

    // If full name is empty, fallback to state defaults
    if (fullName.isEmpty) {
      state = UserRequest(
        firstname: state.firstname,
        lastname: state.lastname,
        email: email,
      );
      return;
    }

    final parts = fullName.split(RegExp(r'\s+')); // splits on any whitespace

    String firstname = parts.first;
    String lastname = parts.length > 1 ? parts.sublist(1).join(' ') : '';

    state = UserRequest(firstname: firstname, lastname: lastname, email: email);
  }

  void updateFirstName(String value) =>
      state = state.copyWith(firstname: value);
  void updateLastName(String value) => state = state.copyWith(lastname: value);
  void updateEmail(String value) => state = state.copyWith(email: value);
}
