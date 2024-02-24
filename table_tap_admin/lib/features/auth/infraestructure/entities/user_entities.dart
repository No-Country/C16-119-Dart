import 'package:table_tap_admin/features/auth/domain/model/account_model.dart';
import 'package:table_tap_admin/features/auth/domain/model/user_model.dart';

class UserEntity {
  final bool? success;
  final UserModel? user;
  final AccountModel? account;
  final String? errorMessage;

  UserEntity({
    this.success,
    this.user,
    this.account,
    this.errorMessage,
  });
}
