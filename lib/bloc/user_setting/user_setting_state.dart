import 'package:equatable/equatable.dart';
import 'package:i_can_quit/data/model/user_setting.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserSettingState extends Equatable {
  UserSettingState([List props = const <dynamic>[]]) : super(props);
}

class InitialUserFirstSettingState extends UserSettingState {}

class SaveUserSettingLoading extends UserSettingState {}

class SaveUserSettingSuccess extends UserSettingState {}

class SaveUserSettingError extends UserSettingState {}

class FetchUserSettingLoading extends UserSettingState {}

class FetchUserSettingSuccess extends UserSettingState {
  final List<UserSetting> settings;
  final UserSetting latestSetting;

  FetchUserSettingSuccess({
    @required this.settings,
    @required this.latestSetting,
  });
}

class FetchUserSettingError extends UserSettingState {}
