import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/core/widgets/header.dart';
import 'package:my_application/features/property/presentation/controller/property_controller.dart';
import 'package:my_application/features/property/presentation/ui/widget/property_card.dart';

class PropertyListScreen extends ConsumerStatefulWidget {
  const PropertyListScreen({super.key});

  @override
  ConsumerState<PropertyListScreen> createState() => _PropertyListScreenState();
}

class _PropertyListScreenState extends ConsumerState<PropertyListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(propertyControllerProvider.notifier).getAllProperties(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(propertyControllerProvider);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Header(title: "Properties"),
      ),
      body: state.when(
        initial: () => const Center(child: Text('No data')),
        loading: () => const Center(child: CircularProgressIndicator()),
        created: (_) => const Center(child: Text('Property created')),
        loaded: (property) => Center(child: PropertyCard(property: property)),
        allLoaded:
            (properties) => ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: properties.length,
              itemBuilder: (context, index) {
                return PropertyCard(property: properties[index]);
              },
            ),
        error: (msg) => Center(child: Text('Error: $msg')),
        updated: (property) => Center(child: PropertyCard(property: property)),
        deleted: (property) => Center(child: Text('Property deleted')),
      ),
    );
  }
}
