import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const <dynamic>[]]) : super(props);
}

class AuthenticationLogin extends AuthenticationEvent {
  final String email;
  final String password;

  AuthenticationLogin({@required this.email, @required this.password});
}

class AuthenticationCheck extends AuthenticationEvent {}
