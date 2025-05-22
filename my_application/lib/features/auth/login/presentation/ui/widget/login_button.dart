import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/features/auth/login/presentation/controller/login_controller.dart';

class LoginButton extends ConsumerWidget {
  final VoidCallback onPressed;
  const LoginButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(
      loginControllerProvider.select((state) => state.isLoading),
    );
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        style: FilledButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        label: Text(
          "Login",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        icon:
            isLoading
                ? const CupertinoActivityIndicator(color: Colors.white)
                : const Icon(Icons.arrow_forward),
        onPressed: isLoading ? null : onPressed,
      ),
    );
  }
}
