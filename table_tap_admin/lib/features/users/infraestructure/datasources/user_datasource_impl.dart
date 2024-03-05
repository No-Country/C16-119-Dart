
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_tap_admin/config/config.dart';
import 'package:table_tap_admin/features/users/domain/datasources/user_datasource.dart';
import 'package:table_tap_admin/features/users/domain/models/user_model.dart';

class UserDatasourceImp implements UserDatasource {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  @override
  Future<UserModel> createUser(UserModel user) async {
    final result = await _firebase.collection(Constants.tableUser).add(
          user.toJson(),
        );
    final data = await result.get();
    final createdProduct = UserModel.fromJson(data.data()!, data.id);
    return createdProduct;
  }

  @override
  Future<bool> deleteUser(String id) async {
    try {
      await _firebase.collection(Constants.tableUser).doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      var result = await _firebase.collection(Constants.tableUser).get();
      return result.docs.map((doc) {
        final UserId = doc.id;
        return UserModel.fromJson(
          doc.data(),
          UserId,
        );
      }).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<UserModel?> updateUser(
      UserModel User, String id) async {
    try {
      await _firebase
          .collection(Constants.tableUser)
          .doc(id)
          .update(User.toJson());
      return User.copyWith(id: id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<UserModel?> getUserById(String id) async {
    try {
      var snapshot =
          await _firebase.collection(Constants.tableUser).doc(id).get();
      if (snapshot.exists) {
        return UserModel.fromJson(
            snapshot.data() as Map<String, dynamic>, id);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
