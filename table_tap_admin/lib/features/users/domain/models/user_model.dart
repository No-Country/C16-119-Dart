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

  factory UserModel.fromJson(Map<String, dynamic> json, String id) => UserModel(
        id: id,
        name: json['name'] as String,
        lastName: json['lastName'] as String,
        rol: json['rol'] as String?,
        celPhone: json['celPhone'] as String?,
        direction: json['direction'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'lastName': lastName,
        'rol': rol,
        'celPhone': celPhone,
        'direction': direction,
      };

  UserModel copyWith({
    String? id,
    String? name,
    String? lastName,
    String? rol,
    String? celPhone,
    String? direction,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      rol: rol ?? this.rol,
      celPhone: celPhone ?? this.celPhone,
      direction: direction ?? this.direction,
    );
  }
}
