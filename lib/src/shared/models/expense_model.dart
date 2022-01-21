import 'dart:convert';

class ExpenseModel {
  int? id;
  String? description;
  String? type;
  double? value;
  String? date;
  String? dueDate;
  int? userId;

  ExpenseModel({
    this.id,
    this.description,
    this.type,
    this.value,
    this.date,
    this.dueDate,
    this.userId,
  });

  ExpenseModel copyWith({
    int? id,
    String? description,
    String? type,
    double? value,
    String? date,
    String? dueDate,
    int? userId,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      description: description ?? this.description,
      type: type ?? this.type,
      value: value ?? this.value,
      date: date ?? this.date,
      dueDate: dueDate ?? this.dueDate,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'type': type,
      'value': value,
      'date': date,
      'due_date': dueDate,
      'user_id': userId,
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
        id: map['ID'],
        description: map['DESCRIPTION'],
        type: map['TYPE'],
        value: map['VALUE'],
        date: map['DATE'],
        dueDate: map['DUE_DATE'],
        userId: map['USER_ID']);
  }

  String toJson() => json.encode(toMap());

  factory ExpenseModel.fromJson(String source) =>
      ExpenseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExpenseModel(id: $id, description: $description, type: $type, value: $value, date: $date, dueDate: $dueDate, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpenseModel &&
        other.id == id &&
        other.description == description &&
        other.type == type &&
        other.value == value &&
        other.date == date &&
        other.dueDate == dueDate &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        description.hashCode ^
        type.hashCode ^
        value.hashCode ^
        date.hashCode ^
        dueDate.hashCode ^
        userId.hashCode;
  }
}
