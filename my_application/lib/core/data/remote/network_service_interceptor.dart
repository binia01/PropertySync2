import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/core/data/local/secure_storage/isecure_storage.dart';
import 'package:my_application/core/data/local/secure_storage/secure_storage.dart';
import 'package:my_application/core/data/local/secure_storage/secure_storage_const.dart';

final networkServiceInterceptorProvider = Provider<NetworkServiceInterceptor>((
  ref,
) {
  final secureStorage = ref.watch(secureStorageProvider);
  return NetworkServiceInterceptor(secureStorage);
});

final class NetworkServiceInterceptor extends Interceptor {
  final IsecureStorage _secureStorage;

  NetworkServiceInterceptor(this._secureStorage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await _secureStorage.read(accessTokenKey);
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';
    options.headers['Authorization'] = 'Bearer $accessToken';
    super.onRequest(options, handler);
  }
}
