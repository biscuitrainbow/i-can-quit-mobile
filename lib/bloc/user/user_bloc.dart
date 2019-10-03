import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:i_can_quit/bloc/user/user_event.dart';
import 'package:i_can_quit/bloc/user/user_state.dart';
import 'package:i_can_quit/data/repository/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository);

  @override
  UserState get initialState => InitialUserState();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is FetchUser) {
      try {
        final user = await _userRepository.fetchUser();

        yield FetchUserSuccess(user: user);
      } catch (error) {
        print(error);
      }
    }
  }
}
