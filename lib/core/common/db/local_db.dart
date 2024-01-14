import 'package:mr_ambarisha_frontend_new/core/common/db/db_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseBoxes {
  DatabaseBoxes._();
  static late DatabaseBoxes _instance;
  static late SharedPreferences _prefs;

  factory DatabaseBoxes() {
    return _instance;
  }

  static void init() async {
    _instance = DatabaseBoxes._();
    _prefs = await SharedPreferences.getInstance();
  }

  static void setAccessToken(String accessToken) async {
    await _prefs.setString(LocalDatabaseKeys.accessToken, accessToken);
  }

  static void setUserId(String userId) async {
    await _prefs.setString(LocalDatabaseKeys.userId, userId);
  }

  static String? getAccessToken() {
    return 'Bearer ${_prefs.getString(LocalDatabaseKeys.accessToken)}';
  }

  static String? getUserId() {
    return _prefs.getString(LocalDatabaseKeys.userId);
  }

  void clear() async {
    await _prefs.clear();
  }
}
