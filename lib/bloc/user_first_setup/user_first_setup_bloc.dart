import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:i_can_quit/bloc/user_first_setup/user_first_setup_state.dart';
import 'package:i_can_quit/data/repository/smoking_entry_repository.dart';
import 'package:i_can_quit/data/repository/user_setup_repository.dart';

import 'user_first_setup_event.dart';

class UserSetupBloc extends Bloc<UserFirstSetupEvent, UserFirstSetupState> {
  final UserSetupRepository userSetupRepository;
  final SmokingEntryRepository smokingEntryRepository;

  UserSetupBloc(this.userSetupRepository, this.smokingEntryRepository);

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

        yield SaveUserSetupSuccess();
      } catch (error) {
        yield SaveUserSetupError();
      }
    }

    if (event is FetchUserSetups) {
      yield FetchUserSetupLoading();

      try {
        final setups = await userSetupRepository.fetchUserSetups();
        final latestSetup = setups.isNotEmpty ? setups.last : null;

        yield FetchUserSetupSuccess(
          setups: setups,
          latestSetup: latestSetup,
        );
      } catch (error) {
        print(error);
        yield FetchUserSetupError();
      }
    }
  }
}
