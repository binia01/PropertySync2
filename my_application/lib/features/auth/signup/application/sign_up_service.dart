import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_application/features/auth/signup/application/isign_up_service.dart';
import 'package:my_application/features/auth/signup/data/dto/request/sign_up_request.dart';
import 'package:my_application/features/auth/signup/data/dto/response/sign_up_response.dart';
import 'package:my_application/features/auth/signup/data/repository/isign_up_repository.dart';
import 'package:my_application/features/auth/signup/data/repository/sign_up_repository.dart';
import 'package:my_application/features/auth/signup/domain/mapper/isign_up_model_mapper.dart';
import 'package:my_application/features/auth/signup/domain/model/sign_up_model.dart';

final signUpServiceProvider = Provider<IsignUpService>((ref) {
  final signUpRepository = ref.watch(signUpRepositoryProvider);
  return SignUpService(signUpRepository);
});

final class SignUpService implements IsignUpService, ISignUpModelMapper {
  final IsignUpRepository _signUpRepository;

  SignUpService(this._signUpRepository);
  @override
  Future<SignUpModel> signUp(SignUpRequest data) async {
    try {
      final response = await _signUpRepository.signUp(data);
      final model = mapToSignUpModel(response);
      return model;
    } catch (e) {
      rethrow;
    }
  }

  @override
  SignUpModel mapToSignUpModel(SignUpResponse response) {
    return SignUpModel(
      accessToken: response.accessToken,
      isSignUpSuccess: true,
    );
  }
}
