import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:i_can_quit/data/model/quiting_path.dart';

class UserSetup {
  final int numberOfCigarettesPerDay;
  final int numberOfCigarettesPerPackage;
  final int pricePerPackage;
  final QuitingPath path;

  UserSetup({
    @required this.numberOfCigarettesPerDay,
    @required this.numberOfCigarettesPerPackage,
    @required this.pricePerPackage,
    @required this.path,
  });

  UserSetup.initial({
    this.numberOfCigarettesPerPackage = 20,
    this.pricePerPackage = 50,
    this.numberOfCigarettesPerDay = 5,
    this.path = QuitingPath.slowyQuit,
  });

  UserSetup copyWith({
    int numberOfCigarettesPerDay,
    int numberOfCigarettesPerPackage,
    int pricePerPackage,
    QuitingPath path,
  }) {
    return UserSetup(
      numberOfCigarettesPerDay: numberOfCigarettesPerDay ?? this.numberOfCigarettesPerDay,
      numberOfCigarettesPerPackage: numberOfCigarettesPerPackage ?? this.numberOfCigarettesPerPackage,
      pricePerPackage: pricePerPackage ?? this.pricePerPackage,
      path: path ?? this.path,
    );
  }

  @override
  String toString() {
    return 'UserFirstSetup numberOfCigarettesPerDay: $numberOfCigarettesPerDay, numberOfCigarettesPerPackage: $numberOfCigarettesPerPackage, pricePerPackage: $pricePerPackage, path: $path';
  }

  @override
  bool operator ==(Object o) {
    return o is UserSetup &&
        o.numberOfCigarettesPerDay == numberOfCigarettesPerDay &&
        o.numberOfCigarettesPerPackage == numberOfCigarettesPerPackage &&
        o.pricePerPackage == pricePerPackage &&
        o.path == path;
  }

  @override
  int get hashCode {
    return hashList([
      numberOfCigarettesPerDay,
      numberOfCigarettesPerPackage,
      pricePerPackage,
      path,
    ]);
  }

  Map<String, dynamic> toMap() {
    return {
      'numberOfCigarettesPerDay': numberOfCigarettesPerDay,
      'numberOfCigarettesPerPackage': numberOfCigarettesPerPackage,
      'pricePerPackage': pricePerPackage,
      'path': quitingPathToString(path),
    };
  }

  static UserSetup fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserSetup(
      numberOfCigarettesPerDay: map['numberOfCigarettesPerDay'],
      numberOfCigarettesPerPackage: map['numberOfCigarettesPerPackage'],
      pricePerPackage: map['pricePerPackage'],
      path: quitingPathFromString(map['path']),
    );
  }

  static List<UserSetup> fromMapArray(List<Map<String, dynamic>> array) {
    return array.map((setup) => UserSetup.fromMap(setup)).toList();
  }

  String toJson() => json.encode(toMap());

  static UserSetup fromJson(String source) => fromMap(json.decode(source));
}
