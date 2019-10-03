import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:i_can_quit/bloc/authentication/authentication_bloc.dart';
import 'package:i_can_quit/bloc/authentication/authentication_event.dart';
import 'package:i_can_quit/bloc/authentication/authentication_state.dart';
import 'package:i_can_quit/bloc/register/register_event.dart';
import 'package:i_can_quit/bloc/register/register_state.dart';
import 'package:i_can_quit/data/repository/token_repository.dart';
import 'package:i_can_quit/data/repository/user_repository.dart';
import 'package:i_can_quit/data/service/authentication_service.dart';

class RegistrationBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;
  final TokenRepository _tokenRepository;
  final AuthenticationService _authenticationService;
  final AuthenticationBloc _authenticationBloc;

  RegistrationBloc(
    this._userRepository,
    this._tokenRepository,
    this._authenticationService,
    this._authenticationBloc,
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
        final token = await _authenticationService.register(event.user);

        _authenticationBloc.dispatch(AuthenticateUser(token: token));

        yield RegisterSuccess();
      } catch (error) {
        yield RegisterError();
      }
    }
  }
}
