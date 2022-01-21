import 'dart:convert';

class MovementModel {
  int? id;
  String? description;
  String? type;
  String? date;
  double? value;
  MovementModel({
    this.id,
    this.description,
    this.type,
    this.date,
    this.value,
  });

  MovementModel copyWith({
    int? id,
    String? description,
    String? type,
    String? date,
    double? value,
  }) {
    return MovementModel(
      id: id ?? this.id,
      description: description ?? this.description,
      type: type ?? this.type,
      date: date ?? this.date,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'DESCRIPTION': description,
      'TYPE': type,
      'DATE': date,
      'VALUE': value,
    };
  }

  factory MovementModel.fromMap(Map<String, dynamic> map) {
    return MovementModel(
      id: map['ID'],
      description: map['DESCRIPTION'],
      type: map['TYPE'],
      date: map['DATE'],
      value: map['VALUE'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MovementModel.fromJson(String source) =>
      MovementModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MovementModel(id: $id, description: $description, type: $type, date: $date, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MovementModel &&
        other.id == id &&
        other.description == description &&
        other.type == type &&
        other.date == date &&
        other.value == value;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        description.hashCode ^
        type.hashCode ^
        date.hashCode ^
        value.hashCode;
  }
}
