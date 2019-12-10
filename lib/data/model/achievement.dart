import 'dart:convert';

import 'package:flutter/material.dart';

class Achievement {
  final String name;
  final String description;
  final bool achieved;
  Achievement({
    @required this.name,
    this.description = '',
    this.achieved = false,
  });

  Achievement copyWith({
    String name,
    String description,
    bool achieved,
  }) {
    return Achievement(
      name: name ?? this.name,
      description: description ?? this.description,
      achieved: achieved ?? this.achieved,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'achieved': achieved,
    };
  }

  static List<Achievement> fromArrayMap(List<dynamic> array) {
    return array.map((json) => fromMap(json)).toList();
  }

  static Achievement fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Achievement(
      name: map['name'],
      description: map['description'],
      achieved: map['achieved'],
    );
  }

  String toJson() => json.encode(toMap());

  static Achievement fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Achievement name: $name, description: $description, achieved: $achieved';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Achievement && o.name == name && o.description == description && o.achieved == achieved;
  }

  @override
  int get hashCode => name.hashCode ^ description.hashCode ^ achieved.hashCode;
}
