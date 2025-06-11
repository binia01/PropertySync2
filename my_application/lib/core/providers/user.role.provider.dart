import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/core/data/remote/network_service.dart';
import 'package:my_application/core/data/remote/token/itoken_service.dart';
import 'package:my_application/core/data/remote/token/token_service.dart';
import 'package:my_application/core/providers/user_auth_data.dart';

final userRoleProvider = AsyncNotifierProvider<UserRoleNotifier, UserAuthData?>(() {
  return UserRoleNotifier();
});

class UserRoleNotifier extends AsyncNotifier<UserAuthData?> {
  late final ITokenService _tokenService;

  @override
  Future<UserAuthData?> build() async {
    debugPrint("UserRoleNotifier: build method called.");
    _tokenService = ref.watch(tokenServiceProvider(ref.read(networkServiceProvider)));
    try {
      final storedRole = await _tokenService.getRole();
      final storedToken = await _tokenService.getAccessToken();
      final storedUserId = await _tokenService.getUserId();

      debugPrint("UserRoleNotifier: Initial state - Role: $storedRole, UserId: $storedUserId");

      if (storedRole != null && storedRole.isNotEmpty && storedUserId != null && storedUserId.isNotEmpty) {
        return UserAuthData(role: storedRole, userId: storedUserId);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("UserRoleNotifier: Error getting initial auth data: $e");
      return null;
    }
  }

  Future<void> updateAuthData({required String role, required String userId}) async {
    debugPrint("UserRoleNotifier: Attempting to update auth data: Role=$role, UserId=$userId");
    final newAuthData = UserAuthData(role: role, userId: userId);
    state = AsyncValue.data(newAuthData);
    debugPrint("UserRoleNotifier: Auth data state updated to: ${state.value}");
    await _tokenService.saveRole(role);
    await _tokenService.saveUserId(userId);
  }

  Future<void> clearRole() async {
    debugPrint("UserRoleNotifier: Attempting to clear auth data.");
    state = const AsyncValue.data(null);
    debugPrint("UserRoleNotifier: Auth data state cleared.");
    await _tokenService.clearRole();
    await _tokenService.clearUserId();
  }
}