import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_tap_admin/features/auth/presentation/riverpod/user_notifier.dart';

import '../../domain/repository/auth_repository_imp.dart';
import '../../domain/repository/shared_preferences_repository_imp.dart';
import '../../infraestructure/entities/response_recovery.dart';
import '../../infraestructure/entities/user_entities.dart';
import '../../infraestructure/repository/auth_repository.dart';
import '../../infraestructure/repository/shared_preferences_repository.dart';

final sharedPrefRepoProvider = Provider<SharedPreferencesRepository>(
  (ref) => SharedPreferencesRepositoryImp(),
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImp(),
);

final usuarioProvider = StateNotifierProvider<UserNotifier, UserEntity?>(
  (ref) => UserNotifier(
    authRepository: ref.watch(authRepositoryProvider),
    sharedPrefRepo: ref.watch(sharedPrefRepoProvider),
  ),
);

final recoveryUserProvider = StateProvider<ResponseRecovery?>((ref) => null);
