import 'package:equatable/equatable.dart';
import 'package:i_can_quit/data/model/achievement.dart';

abstract class AchievementState extends Equatable {
  const AchievementState();
}

class InitialAchievementState extends AchievementState {
  @override
  List<Object> get props => [];
}

class AchievementsLoaded extends AchievementState {
  final List<Achievement> achievements;

  AchievementsLoaded({this.achievements});
}
