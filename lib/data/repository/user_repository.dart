import 'dart:io';

import 'package:dio/dio.dart';
import 'package:i_can_quit/data/model/user.dart';
import 'package:i_can_quit/data/repository/token_repository.dart';
import 'package:i_can_quit/ui/util/string_util.dart';

class UserRepository {
  final Dio dio;
  final TokenRepository _tokenRepository;

  UserRepository(this.dio, this._tokenRepository);

  Future<User> login(String email, String password) async {
    final response = await dio.post('/login', data: {
      'email': email,
      'password': password,
    });

    return User.fromMap(response.data);
  }

  Future<User> register(User user) async {
    final response = await dio.post('/register', data: {
      'name': user.name,
      'email': user.email,
      'password': user.password,
    });

    return User.fromMap(response.data);
  }

  Future<User> fetchUser() async {
    final response = await dio.get(
      '/user',
      options: Options(headers: {
        HttpHeaders.authorizationHeader: toBearer(await _tokenRepository.getToken()),
      }),
    );

    return User.fromMap(response.data);
  }

  // Future<Null> update(User user) async {
  //   final token = await _tokenRepository.getToken();
  //   await dio.put('/user',
  //       options: Options(
  //         contentType: ContentType.parse("application/x-www-form-urlencoded"),
  //         headers: {
  //           HttpHeaders.authorizationHeader: toBearer(token),
  //         },
  //       ),
  //       data: {
  //         'name': user.name,
  //         'date_of_birth': user.dateOfBirth,
  //         'health_condition': user.healthCondition,
  //         'gender': user.gender,
  //         'sodium_limit': user.sodiumLimit,
  //         'is_new_user': user.isNewUser ? 1 : 0,
  //         'enable_notification': user.enableNotification ? 1 : 0,
  //       });
  // }
}

class UnauthorizedException implements Exception {
  String error;

  UnauthorizedException(this.error);
}
