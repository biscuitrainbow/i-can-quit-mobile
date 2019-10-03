import 'dart:io';

import 'package:dio/dio.dart';
import 'package:i_can_quit/data/model/user.dart';
import 'package:i_can_quit/data/repository/token_repository.dart';
import 'package:i_can_quit/ui/util/string_util.dart';

class UserRepository {
  final Dio _dio;
  final TokenRepository _tokenRepository;

  UserRepository(
    this._dio,
    this._tokenRepository,
  );

  Future<User> fetchUser() async {
    final response = await _dio.get(
      '/user',
      options: Options(headers: {
        HttpHeaders.authorizationHeader: toBearer(await _tokenRepository.token()),
      }),
    );

    return User.fromMap(response.data['user']);
  }
}
