import 'package:flutter/material.dart';
import 'package:my_application/main_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MainWidget()));
}
