import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserFirstSetupState extends Equatable {
  UserFirstSetupState([List props = const <dynamic>[]]) : super(props);
}

class InitialUserFirstSetupState extends UserFirstSetupState {}

class UserFirstSetupLoading extends UserFirstSetupState {}

class UserFirstSetupEmpty extends UserFirstSetupState {}

class SaveUserFirstSetupSuccess extends UserFirstSetupState {}
