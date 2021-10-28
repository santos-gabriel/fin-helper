import 'dart:convert';

class RevenueModel {
  String? description;
  String? type;
  String? date;
  double? value;

  RevenueModel({
    this.description,
    this.type,
    this.date,
    this.value,
  });

  RevenueModel copyWith({
    String? description,
    String? type,
    String? date,
    double? value,
  }) {
    return RevenueModel(
      description: description ?? this.description,
      type: type ?? this.type,
      date: date ?? this.date,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'type': type,
      'date': date,
      'value': value,
    };
  }

  factory RevenueModel.fromMap(Map<String, dynamic> map) {
    return RevenueModel(
      description: map['DESCRIPTION'],
      type: map['TYPE'],
      date: map['DATE'],
      value: map['VALUE'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RevenueModel.fromJson(String source) =>
      RevenueModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RevenueModel(description: $description, type: $type, date: $date, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RevenueModel &&
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
