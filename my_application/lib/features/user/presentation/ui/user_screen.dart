import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_application/core/widgets/header.dart';
import 'package:my_application/features/user/presentation/controller/user_controller.dart';

class UserScreen extends ConsumerStatefulWidget {
  const UserScreen({super.key});

  @override
  ConsumerState<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends ConsumerState<UserScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(userControllerProvider.notifier).getUser());
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userControllerProvider);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Header(title: "User Profile"),
      ),
      body: userState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        loaded:
            (user) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ID: ${user.id}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  Text('Email: ${user.email}'),
                  const SizedBox(height: 8),
                  Text('Name: ${user.name}'),
                  const SizedBox(height: 8),
                  Text('Role: ${user.role}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(userControllerProvider.notifier).deleteUser();
                      if (context.mounted) {
                        context.go('/signup');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Delete User'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(userControllerProvider.notifier).logout();
                      if (context.mounted) {
                        context.go('/login');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Log out'),
                  ),
                ],
              ),
            ),
        error:
            (message) => Center(
              child: Text(
                'Error: $message',
                style: const TextStyle(color: Colors.red),
              ),
            ),
        initial: () => const Center(child: Text("Initializing...")),
        loggedOut: () => const Center(child: Text("You have been logged out.")),
        deleted: () => const Center(child: Text("User deleted.")),
      ),
    );
  }
}
