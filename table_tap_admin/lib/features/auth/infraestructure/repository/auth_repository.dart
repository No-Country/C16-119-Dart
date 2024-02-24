import '../entities/user_entities.dart';

abstract class AuthRepository {
  // Iniciar sesión
  Future<UserEntity> login(String email, String password);

  // Registrarse
  Future<UserEntity> register(UserEntity user);

  // buscar por id
  Future<UserEntity> userById(String id);

  // Cerrar sesión
  Future<void> logout();

  // envia el codigo al correo
  Future<bool> sendCodeEmail(String correo);

  Future<bool> verifyCodePass(String code);

  Future<bool> changePassword(String code, String password);
}
