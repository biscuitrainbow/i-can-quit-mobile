import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:i_can_quit/bloc/authentication/authentication_bloc.dart';
import 'package:i_can_quit/bloc/authentication/authentication_state.dart';
import 'package:i_can_quit/bloc/news/news_bloc.dart';
import 'package:i_can_quit/bloc/news/news_event.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_bloc.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_event.dart';
import 'package:i_can_quit/bloc/user/user_bloc.dart';
import 'package:i_can_quit/bloc/user/user_event.dart';
import 'package:i_can_quit/bloc/user_setting/user_setting_bloc.dart';
import 'package:i_can_quit/bloc/user_setting/user_setting_event.dart';

import 'application_event.dart';
import 'application_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  final AuthenticationBloc _authenticationBloc;
  final UserBloc _userBloc;
  final SmokingEntryBloc _smokingEntryBloc;
  final UserSettingBloc _userSettingBloc;
  final NewsBloc _newsBloc;

  StreamSubscription _authenticationSubscription;

  ApplicationBloc(
    this._authenticationBloc,
    this._userBloc,
    this._smokingEntryBloc,
    this._userSettingBloc,
    this._newsBloc,
  ) {
    _authenticationSubscription = _authenticationBloc.listen((state) {
      if (state is UserAuthenticated) {
        _initilizeApplication();
      }
    });
  }

  void _initilizeApplication() {
    _userSettingBloc.add(FetchUserSetting());
    _smokingEntryBloc.add(FetchSmokingEntry());
    _userBloc.add(FetchUser());
    _newsBloc.add(FetchNews());
  }

  @override
  ApplicationState get initialState => InitialApplicationState();

  @override
  Stream<ApplicationState> mapEventToState(
    ApplicationEvent event,
  ) async* {
    if (event is ReadyApplication) {
      yield ApplicationReady();
    }
  }
}
