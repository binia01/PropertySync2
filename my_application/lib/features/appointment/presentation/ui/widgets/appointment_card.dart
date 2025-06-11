import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:my_application/core/data/remote/network_service.dart';
import 'package:my_application/core/data/remote/token/token_service.dart';
import 'package:my_application/features/appointment/data/dto/request/appointment_request.dart';
import 'package:my_application/features/appointment/domain/model/appointment_model.dart';
import 'package:my_application/features/appointment/presentation/controller/appointment_controller.dart';
import 'package:my_application/features/property/domain/model/property_model.dart';

final selectedDateProvider = StateProvider<String>((ref) {
  return DateFormat('yyyy-MM-dd').format(DateTime.now());
});

final selectedTimeProvider = StateProvider<String>((ref) {
  final now = TimeOfDay.now();
  return "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
});

class AppointmentCard extends ConsumerStatefulWidget {
  final AppointmentModel appointment;
  final PropertyModel property;

  const AppointmentCard({
    super.key,
    required this.appointment,
    required this.property,
  });

  @override
  ConsumerState<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends ConsumerState<AppointmentCard> {
  bool isEditMode = false;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    final tokenService = ref.watch(
      tokenServiceProvider(ref.watch(networkServiceProvider)),
    );
    final selectedDate = ref.watch(selectedDateProvider);
    final selectedTime = ref.watch(selectedTimeProvider);

    return FutureBuilder<String?>(
      future: tokenService.getRole(),
      builder: (context, snapshot) {
        final role = snapshot.data?.toUpperCase();
        final isBuyer = role == "BUYER";
        final isSeller = role == "SELLER";

        final appointment = widget.appointment;
        final property = widget.property;

        return Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 6,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title and Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        property.title ?? 'No Title',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: getStatusColor(
                          appointment.status,
                        ).withAlpha((0.1 * 255).toInt()),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        appointment.status ?? '',
                        style: Theme.of(
                          context,
                        ).textTheme.labelMedium?.copyWith(
                          color: getStatusColor(appointment.status),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                if (isEditMode &&
                    isBuyer &&
                    appointment.status == "PENDING") ...[
                  /// Date Picker
                  Row(
                    children: [
                      const Icon(Icons.calendar_today),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            ref.read(selectedDateProvider.notifier).state =
                                DateFormat('yyyy-MM-dd').format(picked);
                          }
                        },
                        child: Text("Date: $selectedDate"),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  /// Time Picker
                  Row(
                    children: [
                      const Icon(Icons.access_time),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () async {
                          final picked = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (picked != null) {
                            ref
                                .read(selectedTimeProvider.notifier)
                                .state = picked.format(context);
                          }
                        },
                        child: Text("At: $selectedTime"),
                      ),
                    ],
                  ),

                  const Divider(height: 32),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () async {
                          // onEditBuyer
                          final date = ref.read(selectedDateProvider);
                          final time = ref.read(selectedTimeProvider);
                          final timeFormatter = DateFormat.Hm();
                          final parsedTime = timeFormatter.parse(time);
                          final parsedDate = DateTime.parse(date);

                          final combinedDateTime = DateTime(
                            parsedDate.year,
                            parsedDate.month,
                            parsedDate.day,
                            parsedTime.hour,
                            parsedTime.minute,
                          );

                          final request = AppointmentRequest(
                            date: combinedDateTime.toUtc().toIso8601String(),
                            startTime:
                                combinedDateTime.toUtc().toIso8601String(),
                          );
                          ref
                              .watch(appointmentControllerProvider.notifier)
                              .editAppointment(request, appointment.id!);
                          // ref
                          //     .watch(appointmentControllerProvider.notifier)
                          //     .getUserAppointments();
                        },
                        child: const Text("Save"),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton(
                        onPressed: () {
                          setState(() => isEditMode = false);
                        },
                        child: const Text("Cancel"),
                      ),
                    ],
                  ),
                ] else ...[
                  /// Display Details
                  Row(
                    children: [
                      const Icon(Icons.calendar_today),
                      const SizedBox(width: 8),
                      Text(
                        "Date: ${appointment.date != null ? DateFormat('yyyy-MM-dd').format(DateTime.parse(appointment.date!).toLocal()) : 'N/A'}",
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.access_time),
                      const SizedBox(width: 8),
                      Text(
                        "Time: ${appointment.startTime != null ? DateFormat('hh:mm a').format(DateTime.parse(appointment.startTime!).toLocal()) : 'N/A'}",
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on),
                      const SizedBox(width: 8),
                      Text(widget.property.location ?? 'No location'),
                    ],
                  ),

                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (appointment.status == "PENDING" && isSeller) ...[
                        ElevatedButton(
                          onPressed: () {
                            ref
                                .watch(appointmentControllerProvider.notifier)
                                .updateAppointmentStatus(
                                  AppointmentRequest(status: "CONFIRMED"),
                                  appointment.id!,
                                );
                            // ref
                            //     .watch(appointmentControllerProvider.notifier)
                            //     .getUserAppointments();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          child: const Text("Confirm"),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            ref
                                .watch(appointmentControllerProvider.notifier)
                                .updateAppointmentStatus(
                                  AppointmentRequest(status: "CANCELED"),
                                  appointment.id!,
                                );
                            // ref
                            //     .watch(appointmentControllerProvider.notifier)
                            //     .getUserAppointments();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text("Cancel"),
                        ),
                      ] else if (appointment.status == "PENDING" &&
                          isBuyer) ...[
                        ElevatedButton(
                          onPressed: () {
                            setState(() => isEditMode = true);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                          ),
                          child: const Text("Edit"),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            ref
                                .read(appointmentControllerProvider.notifier)
                                .deleteAppointment(appointment.id!);
                            // ref
                            //     .read(appointmentControllerProvider.notifier)
                            //     .getUserAppointments();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text("Delete"),
                        ),
                      ],
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Color getStatusColor(String? status) {
    switch (status?.toUpperCase()) {
      case 'PENDING':
        return Colors.orange;
      case 'CONFIRMED':
        return Colors.green;
      case 'CANCELLED':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
