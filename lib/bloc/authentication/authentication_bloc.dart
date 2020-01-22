import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:i_can_quit/bloc/authentication/authentication_event.dart';
import 'package:i_can_quit/bloc/authentication/authentication_state.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_bloc.dart';
import 'package:i_can_quit/bloc/user/user_bloc.dart';
import 'package:i_can_quit/bloc/user_setting/user_setting_bloc.dart';
import 'package:i_can_quit/data/repository/token_repository.dart';
import 'package:i_can_quit/data/repository/user_repository.dart';
import 'package:i_can_quit/data/service/authentication_service.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;
  final TokenRepository _tokenRepository;
  final AuthenticationService _authenticationService;
  final UserBloc _userBloc;
  final SmokingEntryBloc _smokingEntryBloc;
  final UserSettingBloc _userSettingBloc;

  AuthenticationBloc(
    this._userRepository,
    this._tokenRepository,
    this._authenticationService,
    this._userBloc,
    this._smokingEntryBloc,
    this._userSettingBloc,
  );

  @override
  AuthenticationState get initialState => Unauthenticated();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticateUser) {
      await _tokenRepository.persist(event.token);

      yield UserAuthenticated(token: event.token);
    }

    if (event is LoginWithEmailAndPassword) {
      yield LoginLoading();

      try {
        final token = await _authenticationService.loginWithEmailAndPassword(
          event.email,
          event.password,
        );

        await _tokenRepository.persist(token);

        yield UserAuthenticated(token: token);
      } catch (error) {
        print(error);
        yield LoginError();
      }
    }

    if (event is LoginWithGoogle) {
      yield LoginLoading();

      try {
        final token = await _authenticationService.loginWithGoogle();
        await _tokenRepository.persist(token);

        yield UserAuthenticated(token: token);
      } on DioError catch (error) {
        if (error.response.statusCode == HttpStatus.unauthorized) {
          yield ProviderEmailHasNotRegistered(
            email: error.response.data['email'],
            name: error.response.data['name'],
          );
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
        final token = await _authenticationService.loginWithFacebook();
        await _tokenRepository.persist(token);

        yield UserAuthenticated(token: token);
      } on DioError catch (error) {
        if (error.response.statusCode == HttpStatus.unauthorized) {
          yield ProviderEmailHasNotRegistered(
            email: error.response.data['email'],
            name: error.response.data['name'],
          );
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
      yield LoginLoading();

      final token = await _tokenRepository.token();
      if (token != null) {
        try {
          await _authenticationService.checkAuthenticated();

          yield UserAuthenticated(token: token);
        } catch (error) {
          print(error);
          yield Unauthenticated();
        }
      } else {
        yield Unauthenticated();
      }
    }
  }
}
