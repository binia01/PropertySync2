import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/core/data/remote/network_service.dart';
import 'package:my_application/features/auth/signup/data/dto/request/sign_up_request.dart';
import 'package:my_application/features/auth/signup/data/dto/response/sign_up_response.dart';
import 'package:retrofit/retrofit.dart';

part 'signup_api.g.dart';

final signUpApiProvider = Provider<SignUpApi>((ref) {
  final dio = ref.watch(networkServiceProvider);
  return SignUpApi(dio);
});

@RestApi()
abstract class SignUpApi {
  factory SignUpApi(Dio dio) => _SignUpApi(dio);

  @POST('/auth/signup')
  Future<SignUpResponse> signUp(@Body() SignUpRequest data);
}
