import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:i_can_quit/bloc/authentication/authentication_bloc.dart';
import 'package:i_can_quit/bloc/authentication/authentication_event.dart';
import 'package:i_can_quit/bloc/register/register_event.dart';
import 'package:i_can_quit/bloc/register/register_state.dart';
import 'package:i_can_quit/data/repository/token_repository.dart';
import 'package:i_can_quit/data/repository/user_repository.dart';

class RegistrationBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;
  final TokenRepository tokenRepository;

  final AuthenticationBloc authenticationBloc;

  RegistrationBloc(
    this.userRepository,
    this.tokenRepository,
    this.authenticationBloc,
  );

  @override
  RegisterState get initialState => InitialRegisterState();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is Register) {
      yield RegisterLoading();

      try {
        final user = await userRepository.register(event.user);
        await tokenRepository.saveToken(user.token);

        authenticationBloc.dispatch(AuthenticateUser(user: user));
        yield RegisterSuccess();
      } catch (error) {
        yield RegisterError();
      }
    }
  }
}
