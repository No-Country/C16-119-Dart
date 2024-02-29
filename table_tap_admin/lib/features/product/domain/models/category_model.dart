class CategoryModel {
  final String? id;
  final String name;
  final bool? status;

  const CategoryModel({
    this.id,
    required this.name,
    this.status,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json, String id) => CategoryModel(
        id: id,
        name: json['name'],
        status: json['status'] as bool,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'status': status,
      };

  CategoryModel copyWith({
    String? id,
    String? name,
    bool? status,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
    );
  }
}
