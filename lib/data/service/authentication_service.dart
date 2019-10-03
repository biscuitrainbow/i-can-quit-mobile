import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:i_can_quit/data/model/user.dart';
import 'package:i_can_quit/data/repository/token_repository.dart';
import 'package:i_can_quit/ui/util/string_util.dart';

class AuthenticationService {
  final Dio _dio;
  final TokenRepository _tokenRepository;
  final FacebookLogin _facebookLogin;
  final GoogleSignIn _googleSignIn;

  AuthenticationService(
    this._dio,
    this._tokenRepository,
    this._facebookLogin,
    this._googleSignIn,
  );

  Future<String> register(User user) async {
    final response = await _dio.post(
      '/register',
      data: {
        'name': user.name,
        'email': user.email,
        'password': user.password,
      },
    );

    return response.data['token'];
  }

  Future<String> loginWithEmailAndPassword(String email, String password) async {
    final response = await _dio.post(
      '/login',
      data: {
        'email': email,
        'password': password,
      },
    );

    return response.data['token'];
  }

  Future<String> loginWithGoogle() async {
    final googleAccount = await _googleSignIn.signIn();

    if (googleAccount != null) {
      final accessToken = (await googleAccount.authentication).accessToken;
      final response = await _dio.post('/login/provider/google', data: {
        'access_token': accessToken,
      });

      return response.data['token'];
    }

    throw UserCanceledException();
  }

  Future<String> loginWithFacebook() async {
    final result = await _facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final accessToken = result.accessToken.token;
        final response = await _dio.post('/login/provider/facebook', data: {
          'access_token': accessToken,
        });

        return response.data['token'];
      case FacebookLoginStatus.cancelledByUser:
        throw UserCanceledException();
      case FacebookLoginStatus.error:
        throw UnauthorizedException(result.errorMessage);
    }

    return null;
  }

  Future<bool> checkAuthenticated() async {
    await _dio.post(
      '/authentication/check',
      options: Options(headers: {
        HttpHeaders.authorizationHeader: toBearer(await _tokenRepository.token()),
      }),
    );

    return true;
  }

  Future<Null> logout() async {
    await _dio.post('/logout');
  }
}

class UnauthorizedException implements Exception {
  String error;

  UnauthorizedException(this.error);
}

class UserCanceledException implements Exception {}
