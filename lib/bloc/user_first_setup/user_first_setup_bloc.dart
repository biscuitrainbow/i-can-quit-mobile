import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:i_can_quit/bloc/authentication/authentication_bloc.dart';
import 'package:i_can_quit/bloc/authentication/authentication_event.dart';
import 'package:i_can_quit/bloc/user_first_setup/user_first_setup_state.dart';
import 'package:i_can_quit/data/model/smoking_entry.dart';
import 'package:i_can_quit/data/repository/smoking_entry_repository.dart';
import 'package:i_can_quit/data/repository/user_setup_repository.dart';

import 'user_first_setup_event.dart';

class UserFirstSetupBloc extends Bloc<UserFirstSetupEvent, UserFirstSetupState> {
  final UserSetupRepository userSetupRepository;
  final SmokingEntryRepository smokingEntryRepository;
  final AuthenticationBloc authenticationBloc;

  UserFirstSetupBloc(this.userSetupRepository, this.authenticationBloc, this.smokingEntryRepository);

  @override
  UserFirstSetupState get initialState => InitialUserFirstSetupState();

  @override
  Stream<UserFirstSetupState> mapEventToState(
    UserFirstSetupEvent event,
  ) async* {
    if (event is SaveUserFirstSetup) {
      yield SaveUserSetupLoading();

      try {
        await userSetupRepository.create(event.setup);
        await smokingEntryRepository.create(SmokingEntry.create(
          hasSmoked: true,
          mood: 'เครียด',
        ));
        yield SaveUserSetupSuccess();

        authenticationBloc.dispatch(CheckAuthenticated()); // Temporary use for refresh user
      } catch (error) {
        yield SaveUserSetupError();
      }
    }
  }
}
