import 'dart:convert';

class ExpenseModel {
  String? description;
  String? type;
  double? value;
  String? date;
  String? dueDate;

  ExpenseModel({
    this.description,
    this.type,
    this.value,
    this.date,
    this.dueDate,
  });

  ExpenseModel copyWith({
    String? description,
    String? type,
    double? value,
    String? date,
    String? dueDate,
  }) {
    return ExpenseModel(
      description: description ?? this.description,
      type: type ?? this.type,
      value: value ?? this.value,
      date: date ?? this.date,
      dueDate: dueDate ?? this.dueDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'type': type,
      'value': value,
      'date': date,
      'dueDate': dueDate,
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      description: map['DESCRIPTION'],
      type: map['TYPE'],
      value: map['VALUE'],
      date: map['DATE'],
      dueDate: map['DUEDATE'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpenseModel.fromJson(String source) =>
      ExpenseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExpenseModel(description: $description, type: $type, value: $value, date: $date, dueDate: $dueDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpenseModel &&
        other.description == description &&
        other.type == type &&
        other.value == value &&
        other.date == date &&
        other.dueDate == dueDate;
  }

  @override
  int get hashCode {
    return description.hashCode ^
        type.hashCode ^
        value.hashCode ^
        date.hashCode ^
        dueDate.hashCode;
  }
}
