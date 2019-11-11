import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:i_can_quit/bloc/user_setting/user_setting_state.dart';
import 'package:i_can_quit/data/repository/smoking_entry_repository.dart';
import 'package:i_can_quit/data/repository/user_setting_repository.dart';

import 'user_setting_event.dart';

class UserSettingBloc extends Bloc<UserSettingEvent, UserSettingState> {
  final UserSettingRepository userSettingRepository;
  final SmokingEntryRepository smokingEntryRepository;

  UserSettingBloc(this.userSettingRepository, this.smokingEntryRepository);

  @override
  UserSettingState get initialState => InitialUserFirstSettingState();

  @override
  Stream<UserSettingState> mapEventToState(
    UserSettingEvent event,
  ) async* {
    if (event is SaveUserSetting) {
      yield SaveUserSettingLoading();

      try {
        await userSettingRepository.create(event.settings);
        yield SaveUserSettingSuccess();

        this.add(FetchUserSetting());
      } catch (error) {
        yield SaveUserSettingError();
      }
    }

    if (event is FetchUserSetting) {
      yield FetchUserSettingLoading();

      try {
        final settings = await userSettingRepository.fetchUserSettings();
        final latestSetting = settings.isNotEmpty ? settings.last : null;

        yield FetchUserSettingSuccess(
          settings: settings,
          latestSetting: latestSetting,
        );
      } catch (error) {
        print(error);
        yield FetchUserSettingError();
      }
    }
  }
}
