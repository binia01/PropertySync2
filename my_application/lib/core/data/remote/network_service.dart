import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:my_application/core/data/remote/network_service_interceptor.dart';

final networkServiceProvider = Provider<Dio>((ref) {
  final options = BaseOptions(
    baseUrl: 'http://192.168.1.3:3000',
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
    sendTimeout: const Duration(seconds: 60),
  );
  final dio = Dio(options);
  final provider = ref.watch(networkServiceInterceptorProvider);
  dio.interceptors.addAll([HttpFormatter(), provider]);
  return dio;
});
