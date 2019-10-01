import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:i_can_quit/data/model/quiting_path.dart';

class UserSetup {
  final int id;
  final int numberOfCigarettesPerDay;
  final int numberOfCigarettesPerPackage;
  final int pricePerPackage;
  final QuitingPath path;

  UserSetup({
    this.id,
    @required this.numberOfCigarettesPerDay,
    @required this.numberOfCigarettesPerPackage,
    @required this.pricePerPackage,
    @required this.path,
  });

  UserSetup.initial({
    this.id,
    this.numberOfCigarettesPerPackage = 20,
    this.pricePerPackage = 50,
    this.numberOfCigarettesPerDay = 5,
    this.path = QuitingPath.slowyQuit,
  });

  UserSetup copyWith({
    int id,
    int numberOfCigarettesPerDay,
    int numberOfCigarettesPerPackage,
    int pricePerPackage,
    QuitingPath path,
  }) {
    return UserSetup(
      id: id ?? this.id,
      numberOfCigarettesPerDay: numberOfCigarettesPerDay ?? this.numberOfCigarettesPerDay,
      numberOfCigarettesPerPackage: numberOfCigarettesPerPackage ?? this.numberOfCigarettesPerPackage,
      pricePerPackage: pricePerPackage ?? this.pricePerPackage,
      path: path ?? this.path,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'numberOfCigarettesPerDay': numberOfCigarettesPerDay,
      'numberOfCigarettesPerPackage': numberOfCigarettesPerPackage,
      'pricePerPackage': pricePerPackage,
      'path': quitingPathToString(path),
    };
  }

  static UserSetup fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserSetup(
      id: map['id'],
      numberOfCigarettesPerDay: map['number_of_cigarette_per_day'],
      numberOfCigarettesPerPackage: map['number_of_cigarette_per_package'],
      pricePerPackage: map['price_per_package'],
      path: quitingPathFromString(map['path']),
    );
  }

  static List<UserSetup> fromMapArray(List<dynamic> array) {
    return array.map((setup) => UserSetup.fromMap(setup)).toList();
  }

  String toJson() => json.encode(toMap());

  static UserSetup fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserSetup id: $id, numberOfCigarettesPerDay: $numberOfCigarettesPerDay, numberOfCigarettesPerPackage: $numberOfCigarettesPerPackage, pricePerPackage: $pricePerPackage, path: $path';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UserSetup &&
        o.id == id &&
        o.numberOfCigarettesPerDay == numberOfCigarettesPerDay &&
        o.numberOfCigarettesPerPackage == numberOfCigarettesPerPackage &&
        o.pricePerPackage == pricePerPackage &&
        o.path == path;
  }

  @override
  int get hashCode {
    return id.hashCode ^ numberOfCigarettesPerDay.hashCode ^ numberOfCigarettesPerPackage.hashCode ^ pricePerPackage.hashCode ^ path.hashCode;
  }
}
