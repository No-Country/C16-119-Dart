import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_tap_admin/features/users/domain/models/user_model.dart';
import 'package:table_tap_admin/features/users/domain/repositories/user_repository.dart';

class UsersNotifier extends StateNotifier<AsyncValue<List<UserModel>>> {
  final UserRepository userRepository;

  UsersNotifier({required this.userRepository}) : super(const AsyncLoading()) {
    list();
  }

  Future<void> list() async {
    try {
      state = await AsyncValue.guard(() async {
        final users = await userRepository.getUsers();
        return users;
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> addUser(UserModel user) async {
    try {
      await userRepository.createUser(user);
      await list();
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateUser(UserModel user, String id) async {
    state = const AsyncLoading();
    try {
      await userRepository.updateUser(user, id);
      final userUpdate = await userRepository.getUsers();
      state = AsyncData(userUpdate);
      await list();
    } catch (error) {
      print(error);
    }
  }

  Future<void> deleteUser(String userId) async {
    list();
    state = const AsyncLoading();
    try {
      await userRepository.deleteUser(userId);
      final updatedUser = await userRepository.getUsers();
      state = AsyncData(updatedUser);
    } catch (error) {
      print(error);
    }
  }

  UserModel? getUserById(String userId) {
    list();
    if (state is AsyncData<List<UserModel>>) {
      final users = (state as AsyncData<List<UserModel>>).value;
      return users.firstWhere(
        (user) => user.id == userId,
      );
    } else {
      return null;
    }
  }

  Future<List<UserModel>> getUserAll() async {
    if (state is AsyncData<List<UserModel>>) {
      final users = (state as AsyncData<List<UserModel>>).value;
      return users;
    } else {
      return [];
    }
  }
}
