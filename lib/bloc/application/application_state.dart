import 'package:equatable/equatable.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_state.dart';
import 'package:i_can_quit/bloc/user_setting/user_setting_state.dart';

abstract class ApplicationState extends Equatable {
  const ApplicationState();
}

class InitialApplicationState extends ApplicationState {
  @override
  List<Object> get props => [];
}

class ApplicationReady extends ApplicationState {}

class UserSettingAndSmokingEntryState {
  final UserSettingState userSettingState;
  final SmokingEntryState smokingEntryState;

  UserSettingAndSmokingEntryState(this.userSettingState, this.smokingEntryState);
}
