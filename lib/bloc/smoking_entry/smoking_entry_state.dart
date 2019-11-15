import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:i_can_quit/data/model/smoking_entry.dart';
import 'package:i_can_quit/ui/screen/smoking_entry/smoking_entry_chart.dart';

abstract class SmokingEntryState extends Equatable {
  SmokingEntryState([List props = const []]) : super(props);
}

class FetchSmokingEntrySuccess extends SmokingEntryState {
  final List<SmokingEntry> entries;
  final SmokingEntry latestHasSmokedEntry;
  final int nonSmokingDays;
  final List<SmokingEntryTimeSeries> timeSeries;

  FetchSmokingEntrySuccess({
    @required this.entries,
    @required this.latestHasSmokedEntry,
    @required this.nonSmokingDays,
    @required this.timeSeries,
  }) : super([entries, nonSmokingDays, latestHasSmokedEntry, timeSeries]);
}

class SmokingEntryLoading extends SmokingEntryState {}

class SmokingEntryEmpty extends SmokingEntryState {}

class SaveSmokingEntryLoading extends SmokingEntryState {}

class SaveSmokingEntrySuccess extends SmokingEntryState {}

class SaveSmokingEntryError extends SmokingEntryState {}
