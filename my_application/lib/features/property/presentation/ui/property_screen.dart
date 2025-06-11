import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/core/widgets/header.dart';
import 'package:my_application/features/property/presentation/controller/property_controller.dart';
import 'package:my_application/features/property/presentation/state/property_state.dart';
import 'package:my_application/features/property/presentation/ui/widget/property_card.dart';
import 'package:my_application/features/user/presentation/controller/user_controller.dart';

class PropertyListScreen extends ConsumerStatefulWidget {
  const PropertyListScreen({super.key});

  @override
  ConsumerState<PropertyListScreen> createState() => _PropertyListScreenState();
}

class _PropertyListScreenState extends ConsumerState<PropertyListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(userControllerProvider.notifier).getUser();
      ref.read(propertyControllerProvider.notifier).getAllProperties();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<PropertyState>(propertyControllerProvider, (
      PropertyState? previous,
      PropertyState next,
    ) {
      next.whenOrNull(
        created: (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Appointment created successfully!')),
          );

          ref.read(propertyControllerProvider.notifier).getAllProperties();
        },
        updated: (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Appointment updated successfully!')),
          );
          ref.read(propertyControllerProvider.notifier).getAllProperties();
        },
        deleted: (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Appointment deleted successfully!')),
          );
          ref.read(propertyControllerProvider.notifier).getAllProperties();
        },
        error: (message) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: $message')));
        },
      );
    });
    final state = ref.watch(propertyControllerProvider);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Header(title: "Find your dream home"),
      ),
      body: state.when(
        initial: () => const Center(child: Text('No data')),
        loading: () => const Center(child: CircularProgressIndicator()),

        allLoaded:
            (properties) => ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: properties.length,
              itemBuilder: (context, index) {
                return PropertyCard(property: properties[index]);
              },
            ),
        loaded: (property) => Center(child: PropertyCard(property: property)),
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
}
