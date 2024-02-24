import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_tap_admin/features/auth/infraestructure/repository/shared_preferences_repository.dart';

class SharedPreferencesRepositoryImp implements SharedPreferencesRepository {
  static const String _accessTokenKey = 'access_token';
  static const String _accessId = 'access_id';

  @override
  Future<void> setAccessToken(String token, String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, token);
    await prefs.setString(_accessId, id);
  }

  @override
  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  @override
  Future<void> removeAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    await prefs.remove(_accessId);
  }

  @override
  Future<String?> hasActiveSession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessId);
  }
}
