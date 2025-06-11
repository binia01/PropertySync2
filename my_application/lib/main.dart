import 'package:flutter/material.dart';
import 'package:my_application/core/data/remote/network_service.dart';
import 'package:my_application/core/data/remote/token/token_service.dart';
import 'package:my_application/core/providers/user.role.provider.dart';
import 'package:my_application/features/user/application/user_service.dart';
import 'package:my_application/main_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer();
  final tokenService = container.read(tokenServiceProvider(container.read(networkServiceProvider)));
  final userRoleNotifier = container.read(userRoleProvider.notifier);
  await tokenService.clearToken();
  await userRoleNotifier.clearRole();
  container.dispose();
  runApp(const ProviderScope(child: MainWidget()));
}
