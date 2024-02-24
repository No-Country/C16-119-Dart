
import 'package:table_tap_admin/features/auth/domain/datasource/remote/firebase_authenticate.dart';
import 'package:table_tap_admin/features/auth/domain/datasource/remote/firebase_store.dart';
import 'package:table_tap_admin/features/auth/domain/model/account_model.dart';
import 'package:table_tap_admin/features/auth/domain/model/user_model.dart';
import 'package:table_tap_admin/features/auth/infraestructure/entities/user_entities.dart';

class AuthRemoteDataSource {
  final FirebaseAuthenticate _auth = FirebaseAuthenticate();
  final FirebaseStore _firestore = FirebaseStore();

  Future<UserEntity> register(UserEntity request) async {
    try {
      // Registrar la cuenta
      final responseAccount = await _auth.accountCreate(
        request.account!.email,
        request.account!.password!,
      );

      if (responseAccount == null) {
        return UserEntity(
          success: false,
          errorMessage: "No se puede crear la cuenta",
        );
      }

      // Crear el usuario en Firestore
      final responseUserCreate = await _firestore.userCreate(
        responseAccount.id!,
        request.user!.name,
        request.user!.lastName,
        request.user!.celPhone ?? '',
        request.user!.direction ?? '',
        request.user!.rol ?? '',
      );

      if (!responseUserCreate) {
        return UserEntity(
          success: false,
          errorMessage: "No se puede registrar usuario",
        );
      }

      // Obtener información del usuario registrado
      final responseShow = await _firestore.userById(responseAccount.id!);

      if (responseShow == null) {
        return UserEntity(
          success: false,
          errorMessage: "Error en el servidor",
        );
      }

      // Construir modelos account y user
      AccountModel account = AccountModel(
        id: responseAccount.id,
        email: responseAccount.email,
        token: responseAccount.token,
      );

      UserModel user = UserModel(
        id: responseAccount.id,
        name: responseShow.name,
        lastName: responseShow.lastName,
        celPhone: responseShow.celPhone,
        direction: responseShow.direction,
        rol: responseShow.rol,
      );

      // retornar la respuesta
      return UserEntity(
        success: true,
        user: user,
        account: account,
      );
    } catch (error) {
      return UserEntity(
        success: false,
        errorMessage: error.toString(),
      );
    }
  }

  Future<UserEntity> login(String email, String password) async {
    try {
      // Iniciar sesión
      final responseAuth = await _auth.accountInit(email, password);

      if (responseAuth == null) {
        return UserEntity(
          success: true,
          errorMessage: "No se puede iniciar sesion\ncredenciales invalidas.",
        );
      }
      // Obtener información del usuario
      final responseShow = await _firestore.userById(responseAuth.id!);
      if (responseShow != null) {
        // Construir el objeto UserModel
        UserModel user = UserModel(
          id: responseAuth.id,
          name: responseShow.name,
          lastName: responseShow.lastName,
          celPhone: responseShow.celPhone,
          direction: responseShow.direction,
          rol: responseShow.rol,
        );
        AccountModel account = AccountModel(
          id: responseAuth.id,
          email: responseAuth.email,
          token: responseAuth.token,
        );
        return UserEntity(
          success: true,
          user: user,
          account: account,
        );
      }
      return UserEntity(
        success: false,
        errorMessage: "Error en el servidor.",
      );
    } catch (error) {
      return UserEntity(
        success: false,
        errorMessage: error.toString(),
      );
    }
  }

  Future<bool> logout() async {
    try {
      // Cerrar sesión
      final closeSession = await _auth.accountLogout();
      return closeSession;
    } catch (error) {
      return false;
    }
  }

  Future<UserEntity> getIdUser(String id) async {
    try {
      // Obtener usuario por ID
      final user = await _firestore.userById(id);
      if (user == null) {
        return UserEntity(
          success: false,
          errorMessage: 'Usuario no encontrado',
        );
      }
      return UserEntity(
        success: true,
        user: user,
      );
    } catch (error) {
      return UserEntity(
        success: false,
        errorMessage: error.toString(),
      );
    }
  }

  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sentEmailResestPassword(email);
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> verifyPasswordResetCode(String code) async {
    try {
      await _auth.verifyCodeResetPassword(code);
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> resetPassword(String code, String newPassword) async {
    try {
      await _auth.resetPassword(code, newPassword);
      return true;
    } catch (error) {
      return false;
    }
  }
}
