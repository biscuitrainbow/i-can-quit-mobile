import 'dart:convert';
import 'dart:ui';

import 'package:i_can_quit/data/model/user_first_setup.dart';
import 'package:meta/meta.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String password;
  final String token;
  final String gender;
  final bool isNewUser;
  final List<UserSetup> setups;

  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.token,
    this.gender,
    this.isNewUser,
    this.setups,
  });

  User.register({
    @required this.name,
    @required this.email,
    @required this.password,
    this.id,
    this.token,
    this.gender,
    this.isNewUser = false,
    this.setups = const [],
  });

  User copyWith({
    int id,
    String name,
    String email,
    String password,
    String token,
    String gender,
    bool isNewUser,
    List<UserSetup> setups,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      token: token ?? this.token,
      gender: gender ?? this.gender,
      isNewUser: isNewUser ?? this.isNewUser,
      setups: setups ?? this.setups,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'token': token,
      'gender': gender,
      'isNewUser': isNewUser,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      token: map['token'],
      gender: map['gender'],
      isNewUser: map['isNewUser'],
      setups: map['setups'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  static User fromJson(String source) => fromMap(json.decode(source));

  @override
  bool operator ==(Object o) {
    return o is User &&
        o.id == id &&
        o.name == name &&
        o.email == email &&
        o.password == password &&
        o.token == token &&
        o.gender == gender &&
        o.isNewUser == isNewUser;
  }

  @override
  int get hashCode {
    return hashList([
      id,
      name,
      email,
      password,
      token,
      gender,
      isNewUser,
    ]);
  }

  @override
  String toString() {
    return 'User id: $id, name: $name, email: $email, password: $password, token: $token, gender: $gender, isNewUser: $isNewUser, setups: $setups';
  }
}
