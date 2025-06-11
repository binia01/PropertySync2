// property_form.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/features/property/presentation/controller/property_controller.dart';
import 'package:my_application/features/property/domain/model/property_model.dart';

class PropertyForm extends ConsumerWidget {
  final bool isEdit;
  final int? propertyId;
  final PropertyModel? initialData;

  const PropertyForm({
    super.key,
    this.isEdit = false,
    this.propertyId,
    this.initialData,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(propertyFormProvider);
    final formController = ref.read(propertyFormProvider.notifier);
    final controller = ref.read(propertyControllerProvider.notifier);

    // if (isEdit && initialData != null) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     formController.setFromModel(initialData!);
    //   });
    // }

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
                    TextFormField(
                      initialValue: form.title ?? '',
                      onChanged: formController.updateTitle,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        prefixIcon: Icon(Icons.title),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: form.description ?? '',
                      onChanged: formController.updateDescription,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        prefixIcon: Icon(Icons.description),
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: form.price?.toString() ?? '',
                      onChanged: formController.updatePrice,
                      decoration: const InputDecoration(
                        labelText: 'Price',
                        prefixIcon: Icon(Icons.attach_money),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: form.location,
                      onChanged: formController.updateLocation,
                      decoration: const InputDecoration(
                        labelText: 'Location',
                        prefixIcon: Icon(Icons.location_on),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: form.beds?.toString() ?? '',
                            onChanged: formController.updateBeds,
                            decoration: const InputDecoration(
                              labelText: 'Beds',
                              prefixIcon: Icon(Icons.bed),
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            initialValue: form.baths?.toString() ?? '',
                            onChanged: formController.updateBaths,
                            decoration: const InputDecoration(
                              labelText: 'Baths',
                              prefixIcon: Icon(Icons.bathtub),
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: form.area?.toString() ?? '',
                      onChanged: formController.updateArea,
                      decoration: const InputDecoration(
                        labelText: 'Area',
                        prefixIcon: Icon(Icons.square_foot),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Button color
                foregroundColor: Colors.white, // Text color
              ),
              onPressed: () async {
                bool success = false;
                if (isEdit && propertyId != null) {
                  await controller.editProperty(propertyId!, form);
                  success = true;
                } else {
                  await controller.createProperty(form);
                  success = true;
                }
                if (success) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isEdit
                              ? 'Property updated successfully!'
                              : 'Property created successfully!',
                        ),
                      ),
                    );
                  }
                }
              },
              child: Text(isEdit ? 'Update Property' : 'Create Property'),
            ),
          ],
        ),
      ),
    );
  }
}
