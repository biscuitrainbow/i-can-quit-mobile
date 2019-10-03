import 'package:equatable/equatable.dart';
import 'package:i_can_quit/data/model/user_setup.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserFirstSetupEvent extends Equatable {
  UserFirstSetupEvent([List props = const <dynamic>[]]) : super(props);
}

class SaveUserFirstSetup extends UserFirstSetupEvent {
  final UserSetup setup;

  SaveUserFirstSetup({@required this.setup});
}

class FetchUserSetups extends UserFirstSetupEvent {}
