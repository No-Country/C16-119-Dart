abstract class SharedPreferencesRepository {
  // guarda el token
  Future<void> setAccessToken(String token, String id);

  // estrae el token
  Future<String?> getAccessToken();

  // estrae el id
  Future<String?> hasActiveSession();

  // elimina el token
  Future<void> removeAccessToken();
}
