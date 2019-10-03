import 'dart:convert';

import 'package:i_can_quit/data/model/user_setting.dart';
import 'package:meta/meta.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String password;
  final String token;
  final bool newUser;
  final List<UserSetting> settings;

  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.token,
    this.newUser,
    this.settings,
  });

  User.register({
    @required this.name,
    @required this.email,
    @required this.password,
    this.id,
    this.token,
    this.newUser = false,
    this.settings = const [],
  });

  User copyWith({
    int id,
    String name,
    String email,
    String password,
    String token,
    String gender,
    bool isNewUser,
    List<UserSetting> settings,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      token: token ?? this.token,
      newUser: isNewUser ?? this.newUser,
      settings: settings ?? this.settings,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'token': token,
      'isNewUser': newUser,
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
      newUser: map['isNewUser'],
      settings: UserSetting.fromMapArray(map['setups']),
    );
  }

  String toJson() => json.encode(toMap());

  static User fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'User id: $id, name: $name, email: $email, password: $password, token: ${token[0]}, newUser: $newUser, setups: $settings';
  }
}
