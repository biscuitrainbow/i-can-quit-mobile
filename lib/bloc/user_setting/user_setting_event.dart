import 'package:equatable/equatable.dart';
import 'package:i_can_quit/data/model/user_setting.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserSettingEvent extends Equatable {
  UserSettingEvent([List props = const <dynamic>[]]) : super(props);
}

class SaveUserSetting extends UserSettingEvent {
  final UserSetting settings;

  SaveUserSetting({@required this.settings});
}

class FetchUserSetting extends UserSettingEvent {}
