import 'dart:convert';

class RevenueModel {
  final String? description;
  final String? type;
  final double? value;

  RevenueModel({
    this.description,
    this.type,
    this.value,
  });

  RevenueModel copyWith({
    String? description,
    String? type,
    double? value,
  }) {
    return RevenueModel(
      description: description ?? this.description,
      type: type ?? this.type,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'type': type,
      'value': value,
    };
  }

  factory RevenueModel.fromMap(Map<String, dynamic> map) {
    return RevenueModel(
      description: map['description'],
      type: map['type'],
      value: map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RevenueModel.fromJson(String source) =>
      RevenueModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RevenueModel(description: $description, type: $type, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RevenueModel &&
        other.description == description &&
        other.type == type &&
        other.value == value;
  }

  @override
  int get hashCode {
    return description.hashCode ^ type.hashCode ^ value.hashCode;
  }
}
