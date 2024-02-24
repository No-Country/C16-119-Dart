import 'package:firebase_auth/firebase_auth.dart';
import 'package:table_tap_admin/features/auth/domain/model/account_model.dart';

class FirebaseAuthenticate {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<AccountModel?> accountCreate(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        final token = await firebaseUser.getIdToken();
        return AccountModel(
          id: firebaseUser.uid,
          email: firebaseUser.email!,
          password: '',
          token: token!,
        );
      }
      return null;
    } catch (error) {
      return null;
    }
  }

  Future<AccountModel?> accountInit(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        final token = await firebaseUser.getIdToken();
        return AccountModel(
          id: firebaseUser.uid,
          email: firebaseUser.email!,
          password: '',
          token: token!,
        );
      }
      return null;
    } catch (error) {
      return null;
    }
  }

  Future<bool> accountLogout() async {
    try {
      await _auth.signOut();
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> resetPassword(String codigo, String nuevaContrasena) async {
    try {
      await _auth.confirmPasswordReset(
        code: codigo,
        newPassword: nuevaContrasena,
      );
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> sentEmailResestPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> verifyCodeResetPassword(String codigo) async {
    try {
      await _auth.verifyPasswordResetCode(codigo);
      return true;
    } catch (error) {
      return false;
    }
  }
}
