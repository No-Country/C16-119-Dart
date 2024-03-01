class TableModel {
  final String? id;
  final int? number;
  final bool? available;

  const TableModel({
    this.id,
    this.number,
    this.available,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) => TableModel(
        id: json['id'],
        number: json['number'],
        available: json['available'] as bool,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'number': number,
        'available': available,
      };

  TableModel copyWith({
    String? id,
    int? number,
    bool? available,
  }) {
    return TableModel(
      id: id ?? this.id,
      number: number ?? this.number,
      available: available ?? this.available,
    );
  }
}
