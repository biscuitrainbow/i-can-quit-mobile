import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:i_can_quit/bloc/user_first_setup/user_first_setup_state.dart';
import 'package:i_can_quit/data/repository/user_setup_repository.dart';

import 'user_first_setup_event.dart';

class UserFirstSetupBloc extends Bloc<UserFirstSetupEvent, UserFirstSetupState> {
  final UserSetupRepository userSetupRepository;

  UserFirstSetupBloc(this.userSetupRepository);

  @override
  UserFirstSetupState get initialState => InitialUserFirstSetupState();

  @override
  Stream<UserFirstSetupState> mapEventToState(
    UserFirstSetupEvent event,
  ) async* {
    if (event is SaveUserFirstSetup) {
      print('save');
      try {
        await userSetupRepository.create(event.setup);
      } catch (error) {
        print(error);
      }
    }
  }
}
