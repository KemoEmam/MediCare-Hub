import 'package:medi_care_hub/core/helper/log_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

//*add this in the main.dart
// * WidgetsFlutterBinding.ensureInitialized();
// *await Prefs.init();
class Prefs {
  Prefs._(); // Private constructor to block instantiation

  static SharedPreferences? _prefs;

  // Cache the SharedPreferences instance after the first call
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //------------------------------------------------
  // Save Methods (Type-Specific)
  //------------------------------------------------

  /// Save a String value
  static Future<bool> saveString(String key, String value) async {
    LogHelper.info('Saving string "$value" for key "$key"');
    return _prefs?.setString(key, value) ?? Future.value(false);
  }

  /// Save an int value
  static Future<bool> saveInt(String key, int value) async {
    LogHelper.info('Saving int "$value" for key "$key"');
    return _prefs?.setInt(key, value) ?? Future.value(false);
  }

  /// Save a boolean value
  static Future<bool> saveBool(String key, bool value) async {
    LogHelper.info('Saving bool "$value" for key "$key"');
    return _prefs?.setBool(key, value) ?? Future.value(false);
  }

  /// Save a double value
  static Future<bool> saveDouble(String key, double value) async {
    LogHelper.info('Saving double "$value" for key "$key"');
    return _prefs?.setDouble(key, value) ?? Future.value(false);
  }

  //------------------------------------------------
  // Get Methods (Type-Specific)
  //------------------------------------------------

  /// Get a String value (returns `null` if not found)
  static Future<String?> getString(String key) async {
    final value = _prefs?.getString(key);
    if (value == null) {
      LogHelper.warning('Prefs: Key "$key" not found.');
      return null; // or return a default value like `return ""`
    }
    return value;
  }

  /// Get an int value (returns `null` if not found)
  static Future<int?> getInt(String key) async {
    final value = _prefs?.getInt(key);
    if (value == null) {
      LogHelper.warning('Prefs: Key "$key" not found.');
      return null; // or return a default value like `return 0`
    }
    return value;
  }

  /// Get a boolean value (returns `null` if not found)
  static Future<bool?> getBool(String key) async {
    final value = _prefs?.getBool(key);
    if (value == null) {
      LogHelper.warning('Prefs: Key "$key" not found.');
      return null; // or return a default value like `return false`
    }
    return value;
  }

  /// Get a double value (returns `null` if not found)
  static Future<double?> getDouble(String key) async {
    final value = _prefs?.getDouble(key);
    if (value == null) {
      LogHelper.warning('Prefs: Key "$key" not found.');
      return null; // or return a default value like `return 0.0`
    }
    return value;
  }

  //------------------------------------------------
  // Utility Methods
  //------------------------------------------------

  /// Remove data for a specific key
  static Future<bool> removeData(String key) async {
    try {
      LogHelper.info('Removing data for key "$key"');
      return _prefs?.remove(key) ?? Future.value(false);
    } catch (e) {
      LogHelper.warning('Error removing data for key "$key": $e');
      return false;
    }
  }

  /// Clear all data in SharedPreferences
  static Future<bool> clearAll() async {
    try {
      LogHelper.info('Clearing all data in SharedPreferences');
      return _prefs?.clear() ?? Future.value(false);
    } catch (e) {
      LogHelper.warning('Error clearing SharedPreferences: $e');
      return false;
    }
  }
}
