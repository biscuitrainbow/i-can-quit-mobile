import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const <dynamic>[]]) : super(props);
}

class LoginWithEmailAndPassword extends AuthenticationEvent {
  final String email;
  final String password;

  LoginWithEmailAndPassword({@required this.email, @required this.password}) : super([email, password]);
}

class LoginWithGoogle extends AuthenticationEvent {}

class LoginWithFacebook extends AuthenticationEvent {}

class CheckAuthenticated extends AuthenticationEvent {}

class AuthenticateUser extends AuthenticationEvent {
  final String token;

  AuthenticateUser({@required this.token});
}
