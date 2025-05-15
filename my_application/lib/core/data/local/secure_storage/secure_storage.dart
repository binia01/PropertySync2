import 'package:my_application/core/data/local/secure_storage/flutter_secure_storage_provider.dart';
import 'package:my_application/core/data/local/secure_storage/isecure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final secureStorageProvider = Provider<IsecureStorage>((ref) {
  final secureStorage = ref.watch(flutterSecureStorageProvider);
  return SecureStorage(secureStorage);
});

final class SecureStorage implements IsecureStorage {
  final FlutterSecureStorage _storage;

  const SecureStorage(this._storage);

  @override
  Future<String?> read(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      throw Exception("Error reading key: $key");
    }
  }

  @override
  Future<void> write(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      throw Exception("Error writing key: $key");
    }
  }

  @override
  Future<void> delete(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      throw Exception("Error deleting key: $key");
    }
  }
}
