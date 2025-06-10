import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/features/appointment/data/dto/request/appointment_request.dart';
import 'package:my_application/features/appointment/presentation/controller/appointment_controller.dart';
import 'package:my_application/features/property/domain/model/property_model.dart';

final selectedDateProvider = StateProvider<String>((ref) {
  return DateFormat('yyyy-MM-dd').format(DateTime.now());
});

final selectedTimeProvider = StateProvider<String>((ref) {
  final now = TimeOfDay.now();
  return "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
});

class PropertyDetailsScreen extends ConsumerWidget {
  final PropertyModel property;

  const PropertyDetailsScreen({super.key, required this.property});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final selectedTime = ref.watch(selectedTimeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Property Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/demohouse.jpg',
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        property.title ?? 'No Title',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.location_on),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(property.location ?? 'No Location'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Description",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Text(property.description ?? 'No Description'),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _IconText(Icons.bed, "${property.beds ?? 0} Beds"),
                          _IconText(
                            Icons.bathtub,
                            "${property.baths ?? 0} Baths",
                          ),
                          _IconText(
                            Icons.square_foot,
                            "${property.area ?? 0} sqft",
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            property.price != null
                                ? '\$${property.price}'
                                : 'No Price',
                            style: Theme.of(
                              context,
                            ).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            child: Text(
                              property.status ?? 'Unknown',
                              style: const TextStyle(color: Colors.green),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 32),
                      const Text(
                        "Schedule Appointment for",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today),
                          const SizedBox(width: 6),
                          TextButton(
                            onPressed: () async {
                              final pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                              );
                              if (pickedDate != null) {
                                ref.read(selectedDateProvider.notifier).state =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                              }
                            },
                            child: Text(
                              "Date: $selectedDate",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.access_time),
                          const SizedBox(width: 6),
                          TextButton(
                            onPressed: () async {
                              final pickedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (pickedTime != null) {
                                ref
                                    .read(selectedTimeProvider.notifier)
                                    .state = pickedTime.format(context);
                              }
                            },
                            child: Text(
                              "Time: $selectedTime",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
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
                              propertyId: property.id,
                              date: combinedDateTime.toUtc().toIso8601String(),
                              startTime:
                                  combinedDateTime.toUtc().toIso8601String(),
                            );

                            bool success = false;
                            await ref
                                .watch(appointmentControllerProvider.notifier)
                                .createAppointment(request);
                            success = true;
                            if (success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Appointment scheduled!'),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            "Schedule",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String text;

  const _IconText(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Icon(icon, size: 20), const SizedBox(width: 4), Text(text)],
    );
  }
}
