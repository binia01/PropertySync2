import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScrenState();
}

class _SignUpScrenState extends ConsumerState<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Signup Screen'),
            ElevatedButton(
              onPressed: () {
                // Handle login action
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
