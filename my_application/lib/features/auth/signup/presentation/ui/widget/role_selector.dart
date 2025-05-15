import 'package:flutter/material.dart';

class RoleSelector extends StatelessWidget {
  final String? selectedRole;
  final Function(String) onRoleSelected;

  const RoleSelector({
    super.key,
    required this.selectedRole,
    required this.onRoleSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('I am a:'),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildRoleButton(context, 'BUYER'),
            const SizedBox(width: 8),
            _buildRoleButton(context, 'SELLER'),
          ],
        ),
      ],
    );
  }

  Widget _buildRoleButton(BuildContext context, String role) {
    final isSelected = selectedRole == role;

    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.blue : Colors.grey[200],
          foregroundColor: isSelected ? Colors.white : Colors.black,
        ),
        onPressed: () => onRoleSelected(role),
        child: Text(role),
      ),
    );
  }
}
