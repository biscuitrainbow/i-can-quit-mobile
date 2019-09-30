import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegisterState extends Equatable {
  RegisterState([List props = const <dynamic>[]]) : super(props);
}

class InitialRegisterState extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterError extends RegisterState {}

class RegisterLoading extends RegisterState {}
