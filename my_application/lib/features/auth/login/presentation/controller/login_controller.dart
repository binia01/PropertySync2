import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/features/auth/login/application/login_service.dart';
import 'package:my_application/features/auth/login/data/dto/request/login_request.dart';
import 'package:my_application/features/auth/login/presentation/state/login_state.dart';

final loginControllerProvider =
    AutoDisposeNotifierProvider<LoginController, LoginState>(
      LoginController.new,
    );

class LoginController extends AutoDisposeNotifier<LoginState> {
  @override
  LoginState build() {
    return LoginState();
  }

  Future<void> login() async {
    try {
      state = state.copyWith(
        isLoading: true,
        isLoginSuccess: null,
        errorMessage: null,
      );
      final formData = LoginRequest(
        email: state.loginform['email'],
        password: state.loginform['password'],
      );
      final result = await ref.read(loginServiceProvider).login(formData);
      state = state.copyWith(
        isLoading: false,
        isLoginSuccess: result.isLoginSuccess,
        loginModel: result,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isLoginSuccess: null,
        errorMessage: e.toString(),
      );
    }
  }

  void setFormData(Map<String, dynamic> formData) {
    state = state.copyWith(loginform: formData);
  }
}
