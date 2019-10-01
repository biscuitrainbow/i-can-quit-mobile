import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:i_can_quit/bloc/authentication/authentication_event.dart';
import 'package:i_can_quit/bloc/authentication/authentication_state.dart';
import 'package:i_can_quit/data/repository/token_repository.dart';
import 'package:i_can_quit/data/repository/user_repository.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  final TokenRepository tokenRepository;

  AuthenticationBloc(
    this.userRepository,
    this.tokenRepository,
  );

  @override
  AuthenticationState get initialState => UserIsUnAuthenticated();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticateUser) {
      await tokenRepository.saveToken(event.user.token);

      yield LoginSuccess(user: event.user);
    }

    if (event is LoginWithEmailAndPassword) {
      yield LoginLoading();

      try {
        final user = await userRepository.loginWithEmailAndPassword(event.email, event.password);
        await tokenRepository.saveToken(user.token);

        yield LoginSuccess(user: user);
      } catch (error) {
        yield LoginError();
      }
    }

    if (event is LoginWithGoogle) {
      yield LoginLoading();

      try {
        final googleUser = await userRepository.loginWithGoogle();
        final user = await userRepository.loginWithOnlyEmail(googleUser.email);

        await tokenRepository.saveToken(user.token);

        yield LoginSuccess(user: user);
      } on DioError catch (error) {
        if (error.response.statusCode == HttpStatus.unauthorized) {
          final googleUser = await userRepository.loginWithGoogle();

          yield NewSocialUserHasRegistered(user: googleUser);
        }
      } on UserCanceledException catch (error) {
        print(error);
      } catch (error) {
        yield LoginError();
      }
    }

    if (event is LoginWithFacebook) {
      yield LoginLoading();

      try {
        final facebookUser = await userRepository.loginWithFacebook();
        final user = await userRepository.loginWithOnlyEmail(facebookUser.email);

        await tokenRepository.saveToken(user.token);

        yield LoginSuccess(user: user);
      } on DioError catch (error) {
        if (error.response.statusCode == HttpStatus.unauthorized) {
          final facebookUser = await userRepository.loginWithFacebook();

          yield NewSocialUserHasRegistered(user: facebookUser);
        }
      } on UserCanceledException catch (error) {
        print(error);
        yield LoginError();
      } catch (error) {
        print(error);
        yield LoginError();
      }
    }

    if (event is CheckAuthenticated) {
      final token = await tokenRepository.getToken();
      print(token);
      yield LoginLoading();

      if (token != null) {
        try {
          final user = await userRepository.fetchUser();

          yield LoginSuccess(user: user);
        } catch (error) {
          print(error);
        }
      } else {
        print('unauthenticated');
        yield UserIsUnAuthenticated();
      }
    }
  }
}
