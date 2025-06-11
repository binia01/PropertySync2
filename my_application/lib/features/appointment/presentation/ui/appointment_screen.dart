import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/core/widgets/header.dart';
import 'package:my_application/features/appointment/presentation/controller/appointment_controller.dart';
import 'package:my_application/features/appointment/presentation/state/appointment_state.dart';
import 'package:my_application/features/appointment/presentation/ui/widgets/appointment_card.dart';
import 'package:my_application/features/property/application/property_service.dart';

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
    ref.listen<AppointmentState>(appointmentControllerProvider, (
      AppointmentState? previous,
      AppointmentState next,
    ) {
      next.whenOrNull(
        created: (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Appointment created successfully!')),
          );

          ref
              .read(appointmentControllerProvider.notifier)
              .getUserAppointments();
        },
        updated: (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Appointment updated successfully!')),
          );
          ref
              .read(appointmentControllerProvider.notifier)
              .getUserAppointments();
        },
        deleted: (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Appointment deleted successfully!')),
          );
          ref
              .read(appointmentControllerProvider.notifier)
              .getUserAppointments();
        },
        error: (message) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: $message')));
        },
      );
    });
    final state = ref.watch(appointmentControllerProvider);

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Header(title: "Appointments"),
      ),
      body: state.when(
        initial: () => const Center(child: Text("Initializing...")),
        loading: () => const Center(child: CircularProgressIndicator()),
        loaded:
            (appointment) => Center(child: Text('Single: ${appointment.id}')),
        allLoaded: (appointments) {
          if (appointments.isEmpty) {
            return const Center(child: Text('No Appointments Found.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appointment = appointments[index];
              return FutureBuilder(
                future: ref
                    .watch(propertyServiceProvider)
                    .getPropertyById(appointment.propertyId!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox.shrink();
                  } else if (snapshot.hasError) {
                    return ListTile(
                      title: const Text('Error loading property'),
                      subtitle: Text(snapshot.error.toString()),
                    );
                  } else if (!snapshot.hasData) {
                    return const ListTile(title: Text('Property not found'));
                  }
                  return AppointmentCard(
                    appointment: appointment,
                    property: snapshot.data!,
                  );
                },
              );
            },
          );
        },
        error:
            (msg) => Center(
              child: Text(
                'Error: $msg',
                style: const TextStyle(color: Colors.red),
              ),
            ),
        created: (_) => const SizedBox.shrink(),
        updated: (_) => const SizedBox.shrink(),
        deleted: (_) => const SizedBox.shrink(),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   final state = ref.watch(appointmentControllerProvider);

  //   return Scaffold(
  //     appBar: const PreferredSize(
  //       preferredSize: Size.fromHeight(60),
  //       child: Header(title: "Appointments"),
  //     ),
  //     body: state.when(
  //       initial: () => const Center(child: Text("No Appointments")),
  //       loading: () => const Center(child: CircularProgressIndicator()),
  //       loaded:
  //           (appointment) => Center(child: Text('Single: ${appointment.id}')),
  //       allLoaded: (appointments) {
  //         if (appointments.isEmpty) {
  //           return const Center(child: Text('No Appointments Found.'));
  //         }
  //         return ListView.builder(
  //           padding: const EdgeInsets.all(12),
  //           itemCount: appointments.length,
  //           itemBuilder: (context, index) {
  //             final appointment = appointments[index];
  //             return FutureBuilder(
  //               future: ref
  //                   .watch(propertyServiceProvider)
  //                   .getPropertyById(appointment.propertyId!),
  //               builder: (context, snapshot) {
  //                 if (snapshot.connectionState == ConnectionState.waiting) {
  //                   return const Center(child: CircularProgressIndicator());
  //                 } else if (snapshot.hasError) {
  //                   return ListTile(
  //                     title: Text('Error loading property'),
  //                     subtitle: Text(snapshot.error.toString()),
  //                   );
  //                 } else if (!snapshot.hasData) {
  //                   return const ListTile(title: Text('Property not found'));
  //                 }
  //                 return AppointmentCard(
  //                   appointment: appointment,
  //                   property: snapshot.data!,
  //                 );
  //               },
  //             );
  //           },
  //         );
  //       },
  //       error:
  //           (msg) => Center(
  //             child: Text(
  //               'Error: $msg',
  //               style: const TextStyle(color: Colors.red),
  //             ),
  //           ),
  //       created: (_) => const Center(child: Text('Appointment created')),
  //       updated: (_) => const Center(child: Text('Appointment updated')),
  //       deleted: (_) {
  //         Future.microtask(
  //           () =>
  //               ref
  //                   .read(appointmentControllerProvider.notifier)
  //                   .getUserAppointments(),
  //         );
  //         return const Center(child: Text('Appointment deleted'));
  //       },
  //     ),
  //   );
  // }
}
