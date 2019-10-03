import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class TokenRepository {
  static final String keyToken = 'token';
  final SharedPreferences sharedPreferences;

  TokenRepository(this.sharedPreferences);

  Future<Null> persist(String token) async {
    await sharedPreferences.setString(keyToken, token);
  }

  Future<Null> delete() async {
    await sharedPreferences.remove(keyToken);
  }

  Future<String> token() async {
    return sharedPreferences.getString(keyToken);
  }
}
