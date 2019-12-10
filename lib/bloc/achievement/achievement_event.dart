import 'package:equatable/equatable.dart';

abstract class AchievementEvent extends Equatable {
  const AchievementEvent();
}

class FetchAchievements extends AchievementEvent {}
