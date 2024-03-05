
import 'package:table_tap_admin/features/users/domain/models/user_model.dart';

abstract class UserRepository {
  // crear
  Future<UserModel> createUser(UserModel user);

  // eliminar
  Future<bool> deleteUser(String id);

  // editar
  Future<UserModel?> updateUser(UserModel user, String id);

  // listar todos
  Future<List<UserModel>> getUsers();

  // buscar por id
  Future<UserModel?> getUserById(String id);
}
