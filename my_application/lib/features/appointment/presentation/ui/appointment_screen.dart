import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:my_application/core/widgets/header.dart';
import 'package:my_application/features/appointment/presentation/controller/appointment_controller.dart';

class AppointmentListScreen extends ConsumerStatefulWidget {
  const AppointmentListScreen({super.key});

  @override
  ConsumerState<AppointmentListScreen> createState() =>
      _AppointmentListScreenState();
}

class _AppointmentListScreenState extends ConsumerState<AppointmentListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(appointmentControllerProvider.notifier).getUserAppointments();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(appointmentControllerProvider);

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Header(title: "Appointments"),
      ),
      body: state.when(
        initial: () => const Center(child: Text("No Appointments")),
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (msg) => Center(
              child: Text(
                'Error: $msg',
                style: const TextStyle(color: Colors.red),
              ),
            ),
        created: (_) => const Center(child: Text('Appointment created')),
        updated: (_) => const Center(child: Text('Appointment updated')),
        deleted: (_) => const Center(child: Text('Appointment deleted')),
        loaded:
            (appointment) => Center(child: Text('Single: ${appointment.id}')),
        allLoaded: (appointments) {
          if (appointments.isEmpty) {
            return const Center(child: Text('No Appointments Found.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: appointments.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final appointment = appointments[index];
              final dateStr =
                  appointment.date != null
                      ? DateFormat.yMMMd().format(appointment.date!)
                      : 'Unknown Date';
              final timeStr =
                  appointment.startTime != null
                      ? DateFormat.Hm().format(appointment.startTime!)
                      : 'Unknown Time';

              return ListTile(
                title: Text('Appointment #${appointment.id ?? '-'}'),
                subtitle: Text('$dateStr at $timeStr'),
                trailing: Text(
                  appointment.status ?? 'Pending',
                  style: TextStyle(
                    color:
                        appointment.status == 'confirmed'
                            ? Colors.green
                            : Colors.orange,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
