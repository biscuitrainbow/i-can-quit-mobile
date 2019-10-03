import 'package:equatable/equatable.dart';
import 'package:i_can_quit/data/model/user.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  AuthenticationState([List props = const <dynamic>[]]) : super(props);
}

class Unauthenticated extends AuthenticationState {}

class LoginLoading extends AuthenticationState {}

class LoginSuccess extends AuthenticationState {}

class LoginError extends AuthenticationState {}

class ProviderEmailHasNotRegistered extends AuthenticationState {
  final String email;
  final String name;

  ProviderEmailHasNotRegistered({
    @required this.email,
    @required this.name,
  }) : super([email, name]);
}

class UserAuthenticated extends AuthenticationState {}

class RegistrationSuccess extends AuthenticationState {
  final User user;

  RegistrationSuccess({@required this.user}) : super([user]);
}
