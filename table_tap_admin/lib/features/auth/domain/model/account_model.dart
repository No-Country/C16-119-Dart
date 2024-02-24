class AccountModel {
  final String? id;
  final String email;
  final String? password;
  final String? token;

  const AccountModel({
     this.id,
    required this.email,
    this.password,
    this.token,
  });
}
