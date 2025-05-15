import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_application/features/auth/signup/presentation/controller/sign_up_controller.dart';
import 'package:my_application/features/auth/signup/presentation/ui/widget/already_have_account.dart';
import 'package:my_application/features/auth/signup/presentation/ui/widget/role_selector.dart';
import 'package:my_application/features/auth/signup/presentation/ui/widget/sign_up_button.dart';

class SignUpFormList extends ConsumerStatefulWidget {
  const SignUpFormList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpFormListState();
}

class _SignUpFormListState extends ConsumerState<SignUpFormList> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  String? _selectedRole;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
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
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'Full name',
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                prefix: const Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email address',
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                prefix: const Icon(Icons.email),
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
                prefix: const Icon(Icons.lock),
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

            // Role Selector
            RoleSelector(
              selectedRole: _selectedRole,
              onRoleSelected: (role) {
                setState(() {
                  _selectedRole = role;
                });
              },
            ),

            SizedBox(height: 16),
            SignUpButton(onPressed: _onSubmit),
            const SizedBox(height: 16),
            AlreadyHaveAccount(onPressed: _navigateToLogin),
          ],
        ),
      ),
    );
  }

  void _listener() {
    ref.listen(signUpControllerProvider.select((value) => value.errorMessage), (
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

    ref.listen(
      signUpControllerProvider.select((value) => value.isSignUpSuccess),
      (_, next) {
        if (next != null && next) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text('Sign Up Successful'),
                content: Text(
                  'Please check your email for verification and verify your account',
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      context.pop();
                      _clearForm();
                      _navigateToLogin();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }

  void _clearForm() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    setState(() {
      _selectedRole = null;
    });
  }

  void _navigateToLogin() {
    context.go('/login');
  }

  void _onSubmit() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid || _selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all fields including selecting a role'),
        ),
      );
      return;
    }

    final formData = {
      'name': _nameController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
      'role': _selectedRole!,
    };

    ref.read(signUpControllerProvider.notifier).setFormData(formData);
    ref.read(signUpControllerProvider.notifier).signUp();
  }
}
