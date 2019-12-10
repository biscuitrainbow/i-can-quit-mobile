import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:i_can_quit/bloc/achievement/achievement_event.dart';
import 'package:i_can_quit/bloc/achievement/achievement_state.dart';
import 'package:i_can_quit/data/model/achievement.dart';
import 'package:i_can_quit/data/repository/achievement_repository.dart';

class AchievementBloc extends Bloc<AchievementEvent, AchievementState> {
  final AchievementRepository _achievementRepository;

  AchievementBloc(this._achievementRepository);

  @override
  AchievementState get initialState => InitialAchievementState();

  @override
  Stream<AchievementState> mapEventToState(
    AchievementEvent event,
  ) async* {
    if (event is FetchAchievements) {
      final achievements = await _achievementRepository.fetchAchievements();

      yield AchievementsLoaded(achievements: achievements);
    }
  }
}
