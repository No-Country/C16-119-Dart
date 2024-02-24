import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_tap_admin/features/auth/infraestructure/entities/user_entities.dart';
import 'package:table_tap_admin/features/auth/infraestructure/repository/auth_repository.dart';
import 'package:table_tap_admin/features/auth/infraestructure/repository/shared_preferences_repository.dart';

class UserNotifier extends StateNotifier<UserEntity?> {
  final AuthRepository _authRepository;
  final SharedPreferencesRepository _sharedPrefRepo;

  UserNotifier({
    required AuthRepository authRepository,
    required SharedPreferencesRepository sharedPrefRepo,
  })  : _authRepository = authRepository,
        _sharedPrefRepo = sharedPrefRepo,
        super(null) {
    _cargarUsuario();
  }

  _cargarUsuario() async {
    final userId = await _sharedPrefRepo.hasActiveSession();
    if (userId != null) {
      final usuario = await _authRepository.userById(userId);
      state = usuario;
    }
  }

  logout() async {
    await _authRepository.logout();
    await _sharedPrefRepo.removeAccessToken();
    state = null;
  }

  update(UserEntity entity) {
    state = entity;
  }
}
