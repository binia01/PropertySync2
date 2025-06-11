import 'package:flutter/material.dart';

class UserInfoCard extends StatelessWidget {
  final String name;
  final String email;
  final String role;

  const UserInfoCard(this.name, this.email, this.role, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundColor: Color(0xFFDBEAFE),
          child: Icon(
            Icons.person_outlined,
            color: Colors.blueAccent,
            size: 30,
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: Theme.of(context).textTheme.titleMedium),
            Text(email),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Property $role',
                style: const TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ProfileAppointmentsCards extends StatelessWidget {
  final int pending;
  final int confirmed;

  const ProfileAppointmentsCards(this.pending, this.confirmed, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _StatusCard(
          label: 'Pending Appointments',
          count: pending,
          icon: Icons.calendar_today,
          iconColor: Colors.blue,
          linkText: 'View all appointments',
        ),
        const SizedBox(height: 12),
        _StatusCard(
          label: 'Confirmed Appointments',
          count: confirmed,
          icon: Icons.check_box,
          iconColor: Colors.green,
          linkText: 'View confirmed appointments',
        ),
      ],
    );
  }
}

class _StatusCard extends StatelessWidget {
  final String label;
  final int count;
  final IconData icon;
  final Color iconColor;
  final String linkText;

  const _StatusCard({
    required this.label,
    required this.count,
    required this.icon,
    required this.iconColor,
    required this.linkText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(icon, color: iconColor, size: 40),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 2),
                    Text(
                      count.toString(),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(linkText, style: const TextStyle(color: Colors.blue)),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsRow extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onClick;
  final bool hasRightArrow;
  final Color iconTint;
  final Color textColor;

  const SettingsRow({
    super.key,
    required this.title,
    required this.icon,
    required this.onClick,
    this.hasRightArrow = false,
    this.iconTint = Colors.black,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: onClick,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, size: 20, color: iconTint),
                    const SizedBox(width: 16),
                    Text(title, style: TextStyle(color: textColor)),
                  ],
                ),
                if (hasRightArrow)
                  Icon(Icons.arrow_forward_ios, size: 16, color: textColor),
              ],
            ),
          ),
        ),
        const Divider(height: 1, color: Color(0xFFE0E0E0)),
        const SizedBox(height: 8),
      ],
    );
  }
}
