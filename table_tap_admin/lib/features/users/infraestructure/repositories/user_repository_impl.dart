import 'package:table_tap_admin/features/users/domain/datasources/user_datasource.dart';
import 'package:table_tap_admin/features/users/domain/models/user_model.dart';
import 'package:table_tap_admin/features/users/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDatasource userDatasource;

  UserRepositoryImpl({required this.userDatasource});

  @override
  Future<UserModel> createUser(UserModel User) {
    return userDatasource.createUser(User);
  }

  @override
  Future<bool> deleteUser(String id) {
    return userDatasource.deleteUser(id);
  }

  @override
  Future<List<UserModel>> getUsers() {
    return userDatasource.getUsers();
  }

  @override
  Future<UserModel?> getUserById(String id) {
    return userDatasource.getUserById(id);
  }

  @override
  Future<UserModel?> updateUser(UserModel User, String id) {
    return userDatasource.updateUser(User, id);
  }
}
