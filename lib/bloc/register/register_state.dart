import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegisterState extends Equatable {
  RegisterState([List props = const <dynamic>[]]) : super(props);
}

class InitialRegisterState extends RegisterState {}
