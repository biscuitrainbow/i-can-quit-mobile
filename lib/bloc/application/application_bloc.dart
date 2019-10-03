import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:i_can_quit/bloc/authentication/authentication_bloc.dart';
import 'package:i_can_quit/bloc/authentication/authentication_state.dart';
import 'package:i_can_quit/bloc/news/news_bloc.dart';
import 'package:i_can_quit/bloc/news/news_event.dart';
import 'package:i_can_quit/bloc/register/register_bloc.dart';
import 'package:i_can_quit/bloc/register/register_state.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_bloc.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_event.dart';
import 'package:i_can_quit/bloc/user/user_bloc.dart';
import 'package:i_can_quit/bloc/user/user_event.dart';
import 'package:i_can_quit/bloc/user_first_setup/user_first_setup_bloc.dart';
import 'package:i_can_quit/bloc/user_first_setup/user_first_setup_event.dart';

import 'application_event.dart';
import 'application_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  final AuthenticationBloc _authenticationBloc;
  final UserBloc _userBloc;
  final SmokingEntryBloc _smokingEntryBloc;
  final UserSetupBloc _userSetupBloc;
  final NewsBloc _newsBloc;
  final RegistrationBloc _registerBloc;

  StreamSubscription _authenticationSubscription;
  StreamSubscription _registerSubscription;

  ApplicationBloc(
    this._authenticationBloc,
    this._userBloc,
    this._smokingEntryBloc,
    this._userSetupBloc,
    this._newsBloc,
    this._registerBloc,
  ) {
    _authenticationSubscription = _authenticationBloc.state.listen((state) {
      if (state is UserAuthenticated) {
        _initilizeApplication();
      }
    });
  }

  void _initilizeApplication() {
    _userBloc.dispatch(FetchUser());
    _smokingEntryBloc.dispatch(FetchSmokingEntry());
    _userSetupBloc.dispatch(FetchUserSetups());
    _newsBloc.dispatch(FetchNews());
  }

  @override
  void dispose() {
    _authenticationSubscription.cancel();
    _registerSubscription.cancel();

    super.dispose();
  }

  @override
  ApplicationState get initialState => InitialApplicationState();

  @override
  Stream<ApplicationState> mapEventToState(
    ApplicationEvent event,
  ) async* {
    // if (event is InitilizeApplication) {
    //   _smokingEntryBloc.dispatch(FetchSmokingEntry());
    //   _newsBloc.dispatch(FetchNews());
    // }
  }
}
