// lib/utils/app_env.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider to indicate if we are in an integration test environment
final isIntegrationTestProvider = Provider<bool>((ref) => false); // Default to false