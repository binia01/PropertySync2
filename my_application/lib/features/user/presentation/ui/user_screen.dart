import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_application/core/widgets/header.dart';
import 'package:my_application/features/user/presentation/controller/user_controller.dart';
import 'package:my_application/features/user/presentation/ui/edit_profile_page.dart';
import 'package:my_application/features/user/presentation/ui/widgets/user_widget.dart';

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
            (user) => ListView(
              padding: const EdgeInsets.all(16),
              children: [
                UserInfoCard(user.name!, user.email!, user.role!.toLowerCase()),

                const SizedBox(height: 24),

                // Appointment Cards
                ProfileAppointmentsCards(1, 4),
                const SizedBox(height: 24),

                // Settings title
                Text(
                  "Account Settings",
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                const SizedBox(height: 16),

                // Settings options
                SettingsRow(
                  title: "Update Profile",
                  icon: Icons.edit_outlined,
                  onClick: () async {
                    final result = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditProfilePage(),
                      ),
                    );
                    if (result == true) {
                      ref.read(userControllerProvider.notifier).getUser();
                    }
                  },
                  hasRightArrow: true,
                ),
                SettingsRow(
                  title: "Delete Account",
                  icon: Icons.delete_outline,
                  onClick: () async {
                    await ref
                        .read(userControllerProvider.notifier)
                        .deleteUser();
                    if (context.mounted) {
                      context.go('/signup');
                    }
                  },
                  iconTint: Colors.red,
                  textColor: Colors.red,
                ),
                SettingsRow(
                  title: "Logout",
                  icon: Icons.logout_outlined,
                  onClick: () async {
                    if (!mounted) return;
                    await ref.read(userControllerProvider.notifier).logout();
                    if (context.mounted) {
                      context.go('/login');
                    }
                  },
                ),
              ],
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
