import 'package:flutter/material.dart';
import 'package:my_application/main_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyObserver extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    // Log state changes for debugging
    print(
      '${provider.name ?? provider.runtimeType} changed from $previousValue to $newValue',
    );
  }
}

void main() {
  runApp(ProviderScope(observers: [MyObserver()], child: const MainWidget()));
}
