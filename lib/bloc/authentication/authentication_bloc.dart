import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
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
  AuthenticationState get initialState => InitialAuthenticationState();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationLogin) {
      try {
        final user = await userRepository.login(event.email, event.password);
        await tokenRepository.saveToken(user.token);

        yield LoginSuccess(user: user);
        yield AuthenticationAuthed();
      } catch (error) {
        print(error);
      }
    }

    if (event is AuthenticationCheck) {
      final token = await tokenRepository.getToken();

      if (token != null) {
        yield AuthenticationAuthed();

        try {
          final user = await userRepository.fetchUser();
          print(user);
        } catch (error) {
          print(error);
        }
      }
    }
  }
}
