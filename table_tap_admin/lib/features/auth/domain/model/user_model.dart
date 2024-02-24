class UserModel {
  final String? id;
  final String name;
  final String lastName;
  final String? rol;
  final String? celPhone;
  final String? direction;

  UserModel({
    this.id,
    required this.name,
    required this.lastName,
    this.rol,
    this.celPhone,
    this.direction,
  });
}
