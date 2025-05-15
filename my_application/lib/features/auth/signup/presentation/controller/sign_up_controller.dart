import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_application/features/auth/signup/application/sign_up_service.dart';
import 'package:my_application/features/auth/signup/data/dto/request/sign_up_request.dart';
import 'package:my_application/features/auth/signup/presentation/state/sign_up_state.dart';

final signUpControllerProvider =
    AutoDisposeNotifierProvider<SignUpController, SignUpState>(
      SignUpController.new,
    );

class SignUpController extends AutoDisposeNotifier<SignUpState> {
  @override
  SignUpState build() {
    return SignUpState();
  }

  Future<void> signUp() async {
    try {
      state = state.copyWith(
        isLoading: true,
        isSignUpSuccess: null,
        errorMessage: null,
      );

      final formData = SignUpRequest(
        name: state.signUpform['name'],
        email: state.signUpform['email'],
        password: state.signUpform['password'],
        role: state.signUpform['role'],
      );

      final result = await ref.read(signUpServiceProvider).signUp(formData);
      state = state.copyWith(
        isLoading: false,
        isSignUpSuccess: result.isSignUpSuccess,
        signUpModel: result,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isSignUpSuccess: null,
        errorMessage: e.toString(),
      );
    }
  }

  void setFormData(Map<String, dynamic> formData) {
    state = state.copyWith(signUpform: formData);
  }
}
