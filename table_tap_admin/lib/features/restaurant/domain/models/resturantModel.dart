class RestaurantModel {
  final String? id;
  final String? name;
  final String? address;
  final String? cellphone;
  final String? rut;
  final String? responsibleId;

  const RestaurantModel({
    this.id,
    this.name,
    this.address,
    this.cellphone,
    this.rut,
    this.responsibleId,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json, String id) => RestaurantModel(
        id: id,
        name: json['name'],
        address: json['address'],
        cellphone: json['cellphone'],
        rut: json['rut'],
        responsibleId: json['responsibleId'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'address': address,
        'cellphone': cellphone,
        'rut': rut,
        'responsibleId': responsibleId,
      };

  RestaurantModel copyWith({
    String? id,
    String? name,
    String? address,
    String? cellphone,
    String? rut,
    String? responsibleId,
  }) {
    return RestaurantModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      cellphone: cellphone ?? this.cellphone,
      rut: rut ?? this.rut,
      responsibleId: responsibleId ?? this.responsibleId,
    );
  }
}
