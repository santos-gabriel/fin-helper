import 'dart:convert';

class ExpenseModel {
  final String? description;
  final String? type;
  final double? value;
  final String? dueDate;

  ExpenseModel({
    this.description,
    this.dueDate,
    this.type,
    this.value,
  });

  ExpenseModel copyWith({
    String? description,
    String? type,
    double? value,
    String? dueDate,
  }) {
    return ExpenseModel(
      description: description ?? this.description,
      type: type ?? this.type,
      value: value ?? this.value,
      dueDate: dueDate ?? this.dueDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'type': type,
      'value': value,
      'dueDate': dueDate,
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      description: map['description'],
      type: map['type'],
      value: map['value'],
      dueDate: map['dueDate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpenseModel.fromJson(String source) =>
      ExpenseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExpenseModel(description: $description, type: $type, value: $value, dueDate: $dueDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpenseModel &&
        other.description == description &&
        other.type == type &&
        other.value == value &&
        other.dueDate == dueDate;
  }

  @override
  int get hashCode {
    return description.hashCode ^
        type.hashCode ^
        value.hashCode ^
        dueDate.hashCode;
  }
}
