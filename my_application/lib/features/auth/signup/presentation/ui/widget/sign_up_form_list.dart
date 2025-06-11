// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:my_application/features/auth/signup/presentation/controller/sign_up_controller.dart';
// import 'package:my_application/features/auth/signup/presentation/ui/widget/already_have_account.dart';
// import 'package:my_application/features/auth/signup/presentation/ui/widget/role_selector.dart';
// import 'package:my_application/features/auth/signup/presentation/ui/widget/sign_up_button.dart';
//
// class SignUpFormList extends ConsumerStatefulWidget {
//   const SignUpFormList({super.key});
//
//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _SignUpFormListState();
// }
//
// class _SignUpFormListState extends ConsumerState<SignUpFormList> {
//   final _formKey = GlobalKey<FormState>();
//
//   late TextEditingController _nameController;
//   late TextEditingController _emailController;
//   late TextEditingController _passwordController;
//
//   String? _selectedRole;
//
//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController();
//     _emailController = TextEditingController();
//     _passwordController = TextEditingController();
//   }
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     _listener();
//
//     return Container(
//       padding: const EdgeInsets.all(32.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withAlpha((0.08 * 255).toInt()),
//             blurRadius: 16,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Form(
//         key: _formKey,
//         child: ListView(
//           children: [
//             Text(
//               "PROPERTY SYNC",
//               style: Theme.of(
//                 context,
//               ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 8),
//             Text(
//               "CREATE AN ACCOUNT",
//               style: Theme.of(
//                 context,
//               ).textTheme.titleMedium?.copyWith(color: Colors.grey[700]),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 24),
//             TextFormField(
//               controller: _nameController,
//               keyboardType: TextInputType.name,
//               decoration: InputDecoration(
//                 labelText: 'Full name',
//                 border: const OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(8.0)),
//                 ),
//                 prefix: const Icon(Icons.person),
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter your name';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 16),
//             TextFormField(
//               controller: _emailController,
//               keyboardType: TextInputType.emailAddress,
//               decoration: InputDecoration(
//                 labelText: 'Email address',
//                 border: const OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(8.0)),
//                 ),
//                 prefix: const Icon(Icons.email),
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter your email';
//                 } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                   return 'Please enter a valid email';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 16),
//             TextFormField(
//               controller: _passwordController,
//               obscureText: true,
//               decoration: InputDecoration(
//                 labelText: 'Password',
//                 border: const OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(8.0)),
//                 ),
//                 prefix: const Icon(Icons.lock),
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter your password';
//                 } else if (value.length < 8) {
//                   return 'Password must be at least 8 characters';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 16),
//
//             // Role Selector
//             RoleSelector(
//               selectedRole: _selectedRole,
//               onRoleSelected: (role) {
//                 setState(() {
//                   _selectedRole = role;
//                 });
//               },
//             ),
//
//             SizedBox(height: 16),
//             SignUpButton(onPressed: _onSubmit),
//             const SizedBox(height: 16),
//             AlreadyHaveAccount(onPressed: () => context.go('/login')),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _listener() {
//     ref.listen(signUpControllerProvider.select((value) => value.errorMessage), (
//       _,
//       next,
//     ) {
//       if (next != null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             duration: const Duration(seconds: 5),
//             backgroundColor: Colors.red,
//             content: Text(next.toString()),
//           ),
//         );
//       }
//     });
//
//     ref.listen(
//       signUpControllerProvider.select((value) => value.isSignUpSuccess),
//       (_, next) {
//         if (next != null && next) {
//           showDialog(
//             context: context,
//             barrierDismissible: false,
//             builder: (context) {
//               return AlertDialog(
//                 title: Text('Sign Up Successful'),
//                 content: Text(
//                   'Please check your email for verification and verify your account',
//                 ),
//                 actions: [
//                   TextButton(
//                     onPressed: () {
//                       context.pop();
//                       _clearForm();
//                       _navigateToHome();
//                     },
//                     child: Text('OK'),
//                   ),
//                 ],
//               );
//             },
//           );
//         }
//       },
//     );
//   }
//
//   void _clearForm() {
//     _nameController.clear();
//     _emailController.clear();
//     _passwordController.clear();
//     setState(() {
//       _selectedRole = null;
//     });
//   }
//
//   void _navigate() {
//     context.go('/property');
//   }
//
//   void _navigateToHome(){
//     context.go('/home');
//   }
//
//   void _onSubmit() {
//     final isValid = _formKey.currentState?.validate() ?? false;
//
//     if (!isValid || _selectedRole == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Please fill all fields including selecting a role'),
//         ),
//       );
//       return;
//     }
//
//     final formData = {
//       'firstname': _nameController.text,
//       'email': _emailController.text,
//       'password': _passwordController.text,
//       'role': _selectedRole!,
//     };
//
//     ref.read(signUpControllerProvider.notifier).setFormData(formData);
//     ref.read(signUpControllerProvider.notifier).signUp();
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_application/features/auth/signup/presentation/controller/sign_up_controller.dart';


enum UserType { buyer, seller }

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

  UserType? _selectedRole = UserType.buyer;

  String? _fullNameError;
  String? _emailError;
  String? _passwordError;

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

    final signUpState = ref.watch(signUpControllerProvider);
    final isLoading = signUpState.isLoading;

    return Padding(
      padding: const EdgeInsets.all(16.0), // Increased padding for better spacing
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            Column(
              // App Logo/Title
              children: [
                Text(
                  "PropertySync",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: const Color(0xFF2196F3),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Create your account",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 24.0),

            // Full name field
            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'Full name',
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                prefixIcon: const Icon(Icons.person),
                errorText: _fullNameError,
              ),
              onChanged: (value) {
                setState(() {
                  _fullNameError = null; // Clear error on change
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Email field
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email address',
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                prefixIcon: const Icon(Icons.email),
                errorText: _emailError,
              ),
              onChanged: (value) {
                setState(() {
                  _emailError = null; // Clear error on change
                });
              },
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

            // Password field
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                prefixIcon: const Icon(Icons.lock),
                errorText: _passwordError,
              ),
              onChanged: (value) {
                setState(() {
                  _passwordError = null; // Clear error on change
                });
              },
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

            // Role selection title
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "I am a:",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 8.0),

            // Buyer/Seller toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ChoiceChipWidget(
                  selected: _selectedRole == UserType.buyer,
                  onClick: () {
                    setState(() {
                      _selectedRole = UserType.buyer;
                    });
                  },
                  label: "Buyer",
                ),
                ChoiceChipWidget(
                  selected: _selectedRole == UserType.seller,
                  onClick: () {
                    setState(() {
                      _selectedRole = UserType.seller;
                    });
                  },
                  label: "Seller",
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Sign Up Button
            SizedBox(
              height: 50.0,
              child: ElevatedButton(
                onPressed: isLoading ? null : _onSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2196F3), // Blue color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                key: const Key('signUpButton'),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                  "Sign up",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Already have an account?
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                TextButton(
                  onPressed: _navigateToLogin,
                  child: const Text("Sign in"),
                ),
              ],
            ),
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
                title: const Text('Sign Up Successful'),
                content: const Text(
                  'Please check your email for verification and verify your account',
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      context.pop();
                      _clearForm();
                      _navigateToHome();
                    },
                    child: const Text('OK'),
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
      _selectedRole = UserType.buyer; // Reset to default
      _fullNameError = null;
      _emailError = null;
      _passwordError = null;
    });
  }

  void _navigateToLogin() {
    context.go('/login');
  }

  void _navigateToHome() {
    context.go('/home');
  }

  void _onSubmit() {
    // Clear previous errors
    setState(() {
      _fullNameError = null;
      _emailError = null;
      _passwordError = null;
    });

    final isValid = _formKey.currentState?.validate() ?? false;
    bool roleSelected = _selectedRole != null;

    if (!isValid || !roleSelected) {
      // Manual validation for individual fields to show specific errors
      if (_nameController.text.isEmpty) {
        setState(() => _fullNameError = 'Full name is required');
      }
      if (_emailController.text.isEmpty) {
        setState(() => _emailError = 'Email is required');
      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(_emailController.text)) {
        setState(() => _emailError = 'Enter a valid email');
      }
      if (_passwordController.text.isEmpty) {
        setState(() => _passwordError = 'Password is required');
      } else if (_passwordController.text.length < 8) {
        setState(() => _passwordError = 'Password must be at least 8 characters');
      }

      if (!roleSelected) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a role (Buyer or Seller)'),
          ),
        );
      }
      return;
    }

    final formData = {
      'name': _nameController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
      'role': _selectedRole!.name.toUpperCase(), // Use .name for enum value
    };

    ref.read(signUpControllerProvider.notifier).setFormData(formData);
    ref.read(signUpControllerProvider.notifier).signUp();
  }
}

class ChoiceChipWidget extends StatelessWidget {
  const ChoiceChipWidget({
    super.key,
    required this.selected,
    required this.onClick,
    required this.label,
  });

  final bool selected;
  final VoidCallback onClick;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF2196F3) : Theme.of(context).colorScheme.outline.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            width: 1.0,
            color: selected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.outline.withOpacity(0.5),
          ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: selected ? Colors.white : Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}