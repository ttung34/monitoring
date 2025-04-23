import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  String id;
  String? name;
  String? value;
  bool isMonitoring;
  ItemModel({
    required this.id,
    this.name,
    this.value,
    this.isMonitoring = true,
  });

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
  factory ItemModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ItemModel(
      id: doc.id,
      name: data['name'] ?? '',
      value: data['value'] ?? '',
      isMonitoring: data['isMonitoring'] ?? false,
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'value': value,
      'isMonitoring': isMonitoring,
    };
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
