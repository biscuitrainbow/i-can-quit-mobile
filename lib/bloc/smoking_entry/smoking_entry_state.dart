import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:i_can_quit/data/model/smoking_entry.dart';

abstract class SmokingEntryState extends Equatable {
  SmokingEntryState([List props = const []]) : super(props);
}

class SmokingEntryLoaded extends SmokingEntryState {
  final List<SmokingEntry> entries;
  final SmokingEntry latestHasSmokedEntry;
  final int nonSmokingDays;

  SmokingEntryLoaded({
    @required this.entries,
    @required this.latestHasSmokedEntry,
    @required this.nonSmokingDays,
  });
}

class SmokingEntryLoading extends SmokingEntryState {}

class SmokingEntryEmpty extends SmokingEntryState {}

class SaveSmokingEntrySuccess extends SmokingEntryState {}
