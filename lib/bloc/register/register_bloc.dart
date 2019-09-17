import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:i_can_quit/bloc/register/register_event.dart';
import 'package:i_can_quit/bloc/register/register_state.dart';
import 'package:i_can_quit/data/repository/token_repository.dart';
import 'package:i_can_quit/data/repository/user_repository.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;
  final TokenRepository tokenRepository;

  RegisterBloc(
    this.userRepository,
    this.tokenRepository,
  );

  @override
  RegisterState get initialState => InitialRegisterState();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {}
}
