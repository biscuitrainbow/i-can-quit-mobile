import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class TokenRepository {
  static final String keyToken = 'token';
  final SharedPreferences sharedPreferences;

  TokenRepository(this.sharedPreferences);

  Future<Null> saveToken(String token) async {
    await sharedPreferences.setString(keyToken, token);
  }

  Future<Null> deleteToken() async {
    await sharedPreferences.remove(keyToken);
  }

  Future<String> getToken() async {
    return sharedPreferences.getString(keyToken);
  }
}
