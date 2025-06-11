import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/core/data/remote/network_service.dart';
import 'package:my_application/core/data/remote/token/itoken_service.dart';
import 'package:my_application/core/data/remote/token/token_service.dart';

final userRoleProvider = AsyncNotifierProvider<UserRoleNotifier, String?>(
  () => UserRoleNotifier(),
);

class UserRoleNotifier extends AsyncNotifier<String?> {
  late final ITokenService _tokenService;

  @override
  Future<String?> build() async {
    _tokenService = ref.read(
      tokenServiceProvider(ref.read(networkServiceProvider)),
    );
    final storedRole = await _tokenService.getRole();
    if (storedRole == null || storedRole.isEmpty) {
      return null;
    }
    return storedRole;
  }

  Future<void> updateRole(String role) async {
    await _tokenService.saveRole(role);
  }

  Future<void> clearRole() async {
    await _tokenService.clearRole();
  }
}
