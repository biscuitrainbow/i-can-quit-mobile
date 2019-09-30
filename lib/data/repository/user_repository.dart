import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:i_can_quit/data/model/user.dart';
import 'package:i_can_quit/data/repository/token_repository.dart';
import 'package:i_can_quit/ui/util/string_util.dart';

class UserRepository {
  final Dio dio;
  final TokenRepository _tokenRepository;
  final FacebookLogin facebookLogin;
  final GoogleSignIn googleSignIn;

  UserRepository(this.dio, this._tokenRepository, this.facebookLogin, this.googleSignIn);

  Future<User> loginWithEmailAndPassword(String email, String password) async {
    final response = await dio.post('/login', data: {
      'email': email,
      'password': password,
    });

    return User.fromMap(response.data);
  }

  Future<User> loginWithGoogle() async {
    try {
      final googleAccount = await googleSignIn.signIn();

      if (googleAccount != null) {
        return User(
          email: googleAccount.email,
          name: googleAccount.displayName,
        );
      }

      throw UserCanceledException();
    } catch (error) {
      throw UnauthorizedException("Unauthorized");
    }
  }

  Future<User> loginWithFacebook() async {
    final result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await dio.get('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
        final profile = graphResponse.data;

        return User(email: profile['email'], name: '${profile['first_name']} ${profile['last_name']}');
      case FacebookLoginStatus.cancelledByUser:
        throw UserCanceledException();
        break;
      case FacebookLoginStatus.error:
        throw UnauthorizedException(result.errorMessage);
        break;
    }

    return null;
  }

  Future<User> register(User user) async {
    final response = await dio.post('/register', data: {
      'name': user.name,
      'email': user.email,
      'password': user.password,
    });

    return User.fromMap(response.data);
  }

  Future<User> loginWithOnlyEmail(String email) async {
    final response = await dio.get('/login/email', queryParameters: {
      'email': email,
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

class UserCanceledException implements Exception {}
