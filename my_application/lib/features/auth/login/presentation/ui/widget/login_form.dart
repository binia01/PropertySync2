import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart'; // Keep this import, context.pop() still uses it
import 'package:my_application/features/auth/login/presentation/controller/login_controller.dart';
import 'package:my_application/features/auth/login/presentation/ui/widget/login_button.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formkey = GlobalKey<FormState>();

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _listener();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formkey,
        child: ListView(
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email address',
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                prefixIcon: const Icon(Icons.email),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                prefixIcon: const Icon(Icons.lock),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                } else if (value.length < 8) {
                  return 'Password must be at least 8 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            LoginButton(onPressed: _onSubmit),
          ],
        ),
      ),
    );
  }

  void _listener() {
    ref.listen(loginControllerProvider.select((value) => value.errorMessage), (
        _,
        next,
        ) {
      if (next != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 5),
            backgroundColor: Colors.red,
            content: Text(next.toString()),
          ),
        );
      }
    });
    ref.listen(loginControllerProvider.select((value) => value.isLoginSuccess), (
        _,
        next,
        ) {
      if (next != null && next) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: const Text('Login Successful'),
              content: const Text(
                'Please check your email for verification and verify your account',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    context.pop();
                    _clearForm();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  void _clearForm() {
    _emailController.clear();
    _passwordController.clear();
  }

  // dont use this
  // void _navigateToLogin() {
  //   context.go('/property');
  // }

  void _onSubmit() {
    final isValid = _formkey.currentState?.validate() ?? false;

    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields including selecting a role'),
        ),
      );
      return;
    }

    final formData = {
      'email': _emailController.text,
      'password': _passwordController.text,
    };

    ref.read(loginControllerProvider.notifier).setFormData(formData);
    ref.read(loginControllerProvider.notifier).login();
  }
}