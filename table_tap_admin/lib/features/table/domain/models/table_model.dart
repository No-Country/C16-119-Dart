class ProductModel {
  final String? id;
  final int? number;
  final bool? status;

  const ProductModel({
    this.id,
    this.number,
    this.status,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        number: json['number'],
        status: json['status'] as bool,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'number': number,
        'status': status,
      };
}
