import 'dart:convert';

class RevenueModel {
  int? id;
  String? description;
  String? type;
  String? date;
  double? value;
  int? userId;

  RevenueModel({
    this.id,
    this.description,
    this.type,
    this.date,
    this.value,
    this.userId,
  });

  RevenueModel copyWith({
    int? id,
    String? description,
    String? type,
    String? date,
    double? value,
    int? userId,
  }) {
    return RevenueModel(
      id: id ?? this.id,
      description: description ?? this.description,
      type: type ?? this.type,
      date: date ?? this.date,
      value: value ?? this.value,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'type': type,
      'date': date,
      'value': value,
      'user_id': userId,
    };
  }

  factory RevenueModel.fromMap(Map<String, dynamic> map) {
    return RevenueModel(
      id: map['ID'],
      description: map['DESCRIPTION'],
      type: map['TYPE'],
      date: map['DATE'],
      value: map['VALUE'],
      userId: map['USER_ID'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RevenueModel.fromJson(String source) =>
      RevenueModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RevenueModel(id: $id, description: $description, type: $type, date: $date, value: $value, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RevenueModel &&
        other.id == id &&
        other.description == description &&
        other.type == type &&
        other.date == date &&
        other.value == value &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        description.hashCode ^
        type.hashCode ^
        date.hashCode ^
        value.hashCode ^
        userId.hashCode;
  }
}
