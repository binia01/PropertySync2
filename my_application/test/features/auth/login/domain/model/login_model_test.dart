

import 'package:flutter_test/flutter_test.dart';
import 'package:my_application/features/auth/login/domain/model/login_model.dart';

void main (){

  group("Login Model Test SUit", () {
    test("Should create login model", () {
      const accesstoken = 'somejwt';
      const isLoginSuccess = true;
      
      final loginModel = LoginModel(accessToken: accesstoken, isLoginSuccess: isLoginSuccess);

      expect(loginModel.accessToken, accesstoken);
      expect(loginModel.isLoginSuccess, isLoginSuccess);

    });
    test("Should have avlue equality with identical properties", () {
      final lgModel1 = LoginModel(accessToken:" accesstoken", isLoginSuccess:true);
      final lgModel2 = LoginModel(accessToken:" accesstoken", isLoginSuccess:true);

      expect(lgModel1, equals(lgModel2));
      expect(lgModel1.hashCode, equals(lgModel2.hashCode));
    });
    test('should not have value equality when properties differ', () {
      final loginModel1 = LoginModel(
        accessToken: 'token_abc',
        isLoginSuccess: true,
      );
      final loginModel3 = LoginModel(
        accessToken: 'token_xyz',
        isLoginSuccess: true,
      );
      final loginModel4 = LoginModel(
        accessToken: 'token_abc',
        isLoginSuccess: false,
      );

      expect(loginModel1, isNot(equals(loginModel3)));
      expect(loginModel1, isNot(equals(loginModel4)));
    });
  });
}