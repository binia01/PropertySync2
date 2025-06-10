import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/features/property/domain/model/property_model.dart';
import 'package:my_application/features/property/presentation/ui/widget/property_form.dart';

class EditPropertyPage extends ConsumerWidget {
  final PropertyModel property;

  const EditPropertyPage({super.key, required this.property});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Property')),
      body: PropertyForm(
        isEdit: true,
        propertyId: property.id,
        initialData: property,
      ),
    );
  }
}
