import 'dart:convert';

class MovementModel {
  String? description;
  String? type;
  String? date;
  double? value;
  MovementModel({
    this.description,
    this.type,
    this.date,
    this.value,
  });

  MovementModel copyWith({
    String? description,
    String? type,
    String? date,
    double? value,
  }) {
    return MovementModel(
      description: description ?? this.description,
      type: type ?? this.type,
      date: date ?? this.date,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'DESCRIPTION': description,
      'TYPE': type,
      'DATE': date,
      'VALUE': value,
    };
  }

  factory MovementModel.fromMap(Map<String, dynamic> map) {
    return MovementModel(
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
    return 'MovementModel(description: $description, type: $type, date: $date, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MovementModel &&
        other.description == description &&
        other.type == type &&
        other.date == date &&
        other.value == value;
  }

  @override
  int get hashCode {
    return description.hashCode ^
        type.hashCode ^
        date.hashCode ^
        value.hashCode;
  }
}
