import 'package:table_tap_admin/features/auth/infraestructure/entities/user_entities.dart';
import 'package:table_tap_admin/features/auth/infraestructure/repository/auth_repository.dart';
import '../datasource/remote/auth_remote_datasource.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDataSource _dataSource = AuthRemoteDataSource();

  @override
  Future<UserEntity> login(String email, String password) async {
    try {
      return await _dataSource.login(email, password);
    } catch (error) {
      return UserEntity(success: false, errorMessage: error.toString());
    }
  }

  @override
  Future<void> logout() async {
    await _dataSource.logout();
  }

  @override
  Future<UserEntity> register(UserEntity userModel) async {
    try {
      return await _dataSource.register(userModel);
    } catch (errorMessage) {
      return UserEntity(success: false, errorMessage: errorMessage.toString());
    }
  }

  @override
  Future<UserEntity> userById(String id) async {
    try {
      return await _dataSource.getIdUser(id);
    } catch (errorMessage) {
      return UserEntity(success: false, errorMessage: errorMessage.toString());
    }
  }

  @override
  Future<bool> sendCodeEmail(String correo) async {
    try {
      return await _dataSource.sendPasswordResetEmail(correo);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> changePassword(String code, String newPassword) async {
    try {
      return await _dataSource.resetPassword(code, newPassword);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> verifyCodePass(String code) async {
    try {
      return await _dataSource.verifyPasswordResetCode(code);
    } catch (e) {
      return false;
    }
  }
}
