import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:i_can_quit/data/model/smoking_entry.dart';
import 'package:i_can_quit/data/model/user_setting.dart';
import 'package:i_can_quit/ui/screen/smoking_entry/smoking_entry_chart.dart';

abstract class SmokingEntryState extends Equatable {
  SmokingEntryState([List props = const []]) : super(props);
}

class FetchSmokingEntrySuccess extends SmokingEntryState {
  final List<SmokingEntry> entries;
  final SmokingEntry latestHasSmokedEntry;
  final int nonSmokingDays;
  final List<SmokingEntryTimeSeries> smokingCountTimeSeries;
  final List<SmokingEntryTimeSeries> cigarettCountTimeSeries;

  final List<UserSetting> userSettings;
  final UserSetting latestUserSetting;

  FetchSmokingEntrySuccess({
    @required this.entries,
    @required this.latestHasSmokedEntry,
    @required this.nonSmokingDays,
    @required this.smokingCountTimeSeries,
    @required this.cigarettCountTimeSeries,
    @required this.userSettings,
    @required this.latestUserSetting,
  }) : super([
          entries,
          nonSmokingDays,
          latestHasSmokedEntry,
          smokingCountTimeSeries,
          cigarettCountTimeSeries,
          userSettings,
          latestUserSetting,
        ]);
}

class SmokingEntryLoading extends SmokingEntryState {}

class SmokingEntryEmpty extends SmokingEntryState {}

class SaveSmokingEntryLoading extends SmokingEntryState {}

class SaveSmokingEntrySuccess extends SmokingEntryState {}

class SaveSmokingEntryError extends SmokingEntryState {}
