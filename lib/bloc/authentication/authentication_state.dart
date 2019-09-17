import 'package:equatable/equatable.dart';
import 'package:i_can_quit/data/model/user.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  AuthenticationState([List props = const <dynamic>[]]) : super(props);
}

class InitialAuthenticationState extends AuthenticationState {}

class LoginLoading extends AuthenticationState {}

class LoginSuccess extends AuthenticationState {
  final User user;

  LoginSuccess({this.user});
}

class LoginError extends AuthenticationState {}

class AuthenticationAuthed extends AuthenticationState {}
