// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ItemModel {
  String id;
  String name;
  String value;
  bool isMonitoring;
  ItemModel({
    required this.id,
    required this.name,
    required this.value,
    this.isMonitoring = true,
  });
  void toggleDone() {
    isMonitoring = !isMonitoring;
  }

  ItemModel copyWith({
    String? id,
    String? name,
    String? value,
    bool? isMonitoring,
  }) {
    return ItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      value: value ?? this.value,
      isMonitoring: isMonitoring ?? this.isMonitoring,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'value': value,
      'isMonitoring': isMonitoring,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'] as String,
      name: map['name'] as String,
      value: map['value'] as String,
      isMonitoring: map['isMonitoring'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) =>
      ItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ItemModel(id: $id, name: $name, value: $value, isMonitoring: $isMonitoring)';
  }

  @override
  bool operator ==(covariant ItemModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.value == value &&
        other.isMonitoring == isMonitoring;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ value.hashCode ^ isMonitoring.hashCode;
  }
}
