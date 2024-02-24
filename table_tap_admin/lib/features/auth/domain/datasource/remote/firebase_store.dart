import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_tap_admin/features/auth/domain/model/user_model.dart';

class FirebaseStore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> userCreate(
    String id,
    String name,
    String lastName,
    String cellPhone,
    String direction,
    String rol,
  ) async {
    try {
      DocumentReference userRef = _firestore.collection('users').doc(id);
      await userRef.set({
        'name': name,
        'lastName': lastName,
        'cellPhone': cellPhone,
        'direction': direction,
        'rol': rol,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> userUpdate(
    String id,
    String name,
    String lastName,
    String cellPhone,
    String direction,
    String rol,
  ) async {
    try {
      DocumentReference userRef = _firestore.collection('users').doc(id);
      await _firestore.runTransaction((transaction) async {
        final docSnapshot = await transaction.get(userRef);
        final updatedData = {
          'name': name == '' ? docSnapshot['name'] : name,
          'lastName': lastName == '' ? docSnapshot['lastName'] : lastName,
          'cellPhone': cellPhone == '' ? docSnapshot['cellPhone'] : cellPhone,
          'direction': direction == '' ? docSnapshot['direction'] : direction,
          'rol': rol == '' ? docSnapshot['rol'] : rol,
        };
        transaction.set(userRef, updatedData);
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<UserModel?> userById(String id) async {
    try {
      DocumentSnapshot response =
          await _firestore.collection('users').doc(id).get();
      if (response.exists) {
        final user = UserModel(
          id: id,
          name: response.get('name'),
          lastName: response.get('lastName'),
          celPhone: response.get('cellPhone'),
          direction: response.get('direction'),
          rol: response.get('rol'),
        );
        return user;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> userDelete(
    String id,
  ) async {
    try {
      DocumentReference userRef = _firestore.collection('users').doc(id);
      await userRef.delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
