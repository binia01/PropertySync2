import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/core/data/remote/network_service.dart';
import 'package:my_application/core/data/remote/token/token_service.dart';
import 'package:my_application/features/property/domain/model/property_model.dart';
import 'package:my_application/features/property/presentation/controller/property_controller.dart';
import 'package:my_application/features/property/presentation/ui/edit_property.dart';
import 'package:my_application/features/property/presentation/ui/property_detail_screen.dart';

class PropertyCard extends ConsumerWidget {
  final PropertyModel property;

  const PropertyCard({super.key, required this.property});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokenService = ref.watch(
      tokenServiceProvider(ref.watch(networkServiceProvider)),
    );

    return FutureBuilder<String?>(
      future: tokenService.getRole(),
      builder: (context, snapshot) {
        final role = snapshot.data?.toUpperCase();
        final isBuyer = role == "BUYER";
        final isSeller = role == "SELLER";

        Widget buildInfoRow(IconData icon, String text) => Row(
          children: [
            Icon(icon, size: 18),
            const SizedBox(width: 4),
            Text(text),
          ],
        );

        Widget buildActionButton({
          required String label,
          required Color color,
          required VoidCallback onPressed,
        }) => TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(label, style: const TextStyle(color: Colors.white)),
        );

        final cardContent = Card(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/demohouse.jpg',
                  fit: BoxFit.cover,
                  height: 150,
                  width: double.infinity,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      property.title ?? 'No Title',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${property.price}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                buildInfoRow(Icons.location_on, '${property.location}'),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildInfoRow(Icons.bed_outlined, '${property.beds} Beds'),
                    buildInfoRow(
                      Icons.bathtub_outlined,
                      '${property.baths} Baths',
                    ),
                    buildInfoRow(
                      Icons.square_outlined,
                      '${property.area} sqft',
                    ),
                  ],
                ),
                if (isSeller) ...[
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildActionButton(
                        label: 'Edit',
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                  EditPropertyPage(property: property),
                            ),
                          );
                        },
                      ),
                      buildActionButton(
                        label: 'Delete',
                        color: Colors.red,
                        onPressed: () {
                          ref
                              .read(propertyControllerProvider.notifier)
                              .deleteProperty(property.id!);
                          ref
                              .read(propertyControllerProvider.notifier)
                              .getAllProperties();
                        },
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );

        return isBuyer
            ? InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder:
                    (context) => PropertyDetailsScreen(property: property),
              ),
            );
          },
          child: cardContent,
        )
            : cardContent;
      },
    );
  }
}
