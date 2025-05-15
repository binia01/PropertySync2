import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_application/features/auth/signup/presentation/controller/sign_up_controller.dart';

class SignUpButton extends ConsumerWidget {
  final VoidCallback onPressed;
  const SignUpButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(
      signUpControllerProvider.select((state) => state.isLoading),
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
          "SignUp",
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
