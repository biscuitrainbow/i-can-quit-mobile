import 'package:equatable/equatable.dart';
import 'package:i_can_quit/data/model/user_setup.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserFirstSetupState extends Equatable {
  UserFirstSetupState([List props = const <dynamic>[]]) : super(props);
}

class InitialUserFirstSetupState extends UserFirstSetupState {}

class SaveUserSetupLoading extends UserFirstSetupState {}

class SaveUserSetupSuccess extends UserFirstSetupState {}

class SaveUserSetupError extends UserFirstSetupState {}

class FetchUserSetupLoading extends UserFirstSetupState {}

class FetchUserSetupSuccess extends UserFirstSetupState {
  final List<UserSetup> setups;
  final UserSetup latestSetup;

  FetchUserSetupSuccess({
    @required this.setups,
    @required this.latestSetup,
  });
}

class FetchUserSetupError extends UserFirstSetupState {}
