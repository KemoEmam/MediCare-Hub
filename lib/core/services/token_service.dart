import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medi_care_hub/core/helper/log_helper.dart';

class TokenService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  /// Save a value securely
  Future<void> saveToken(String name, String token) async {
    try {
      await _storage.write(key: name, value: token);
      LogHelper.info('Token saved successfully: $name');
    } catch (e) {
      LogHelper.warning('Error saving token ($name): $e');
    }
  }

  /// Retrieve a value securely
  Future<String?> getToken(String name) async {
    //TODO: add files to forbidden package
    try {
      return await _storage.read(key: name);
    } catch (e) {
      LogHelper.warning('Error retrieving token ($name): $e');
      return null;
    }
  }

  /// Delete a value securely
  Future<void> deleteToken(String name) async {
    try {
      await _storage.delete(key: name);
      LogHelper.info('Token deleted successfully: $name');
    } catch (e) {
      LogHelper.warning('Error deleting token ($name): $e');
    }
  }

  /// Clear all secure storage (use with caution!)
  Future<void> clearStorage() async {
    try {
      await _storage.deleteAll();
      LogHelper.info('All storage cleared successfully');
    } catch (e) {
      LogHelper.warning('Error clearing storage: $e');
    }
  }
}
