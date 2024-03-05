// provedor de repositorios
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_tap_admin/features/users/domain/repositories/user_repository.dart';
import 'package:table_tap_admin/features/users/infraestructure/datasources/user_datasource_impl.dart';
import 'package:table_tap_admin/features/users/infraestructure/repositories/user_repository_impl.dart';
import 'package:table_tap_admin/features/users/presentation/riverpod/users_notifier.dart';

final userRepositoryProvider = Provider<UserRepository>(
  (ref) => UserRepositoryImpl(
    userDatasource: UserDatasourceImp(),
  ),
);

// Proveedor para las entidades
final usersProvider = StateProvider(
  (ref) => UsersNotifier(
    userRepository: ref.read(
      userRepositoryProvider,
    ),
  ),
);
