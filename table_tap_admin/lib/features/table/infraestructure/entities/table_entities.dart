class TableEntities {
  final String? id;
  final int? number;
  final bool? status;

  const TableEntities({
    this.id,
    this.number,
    this.status,
  });

  factory TableEntities.fromJson(Map<String, dynamic> json) => TableEntities(
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
