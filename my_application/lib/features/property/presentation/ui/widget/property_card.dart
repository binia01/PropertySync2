import 'package:flutter/material.dart';
import 'package:my_application/features/property/domain/model/property_model.dart';

class PropertyCard extends StatelessWidget {
  final PropertyModel property;

  const PropertyCard({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              property.title ?? 'No Title',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 6),
            Text(
              property.description ?? 'No Description',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Text(
              '${property.price} USD',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text('${property.beds} Beds'),
                const SizedBox(width: 10),
                Text('${property.baths} Baths'),
                const SizedBox(width: 10),
                Text('${property.area} sqft'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
