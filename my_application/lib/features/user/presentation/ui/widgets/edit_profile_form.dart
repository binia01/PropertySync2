import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/features/user/presentation/controller/user_controller.dart';

class UserEditForm extends ConsumerWidget {
  const UserEditForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(userFormProvider);
    final formController = ref.read(userFormProvider.notifier);
    final controller = ref.read(userControllerProvider.notifier);

    return Form(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Icon(
                      Icons.person_outlined,
                      color: Colors.blueAccent,
                      size: 60,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      initialValue: form.firstname ?? '',
                      onChanged: formController.updateFirstName,
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      initialValue: form.lastname ?? '',
                      onChanged: formController.updateLastName,
                      decoration: const InputDecoration(
                        labelText: 'Last Name',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      initialValue: form.email ?? '',
                      onChanged: formController.updateEmail,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        bool success = false;
                        if ((form.firstname?.isNotEmpty ?? false) &&
                            (form.lastname?.isNotEmpty ?? false) &&
                            (form.email?.isNotEmpty ?? false)) {
                          await controller.editUser(form);
                          success = true;
                        }
                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("User updated successfully"),
                            ),
                          );
                          Navigator.pop(context, true);
                        }
                      },
                      child: const Text("Update Profile"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
