import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:i_can_quit/data/model/smoking_entry.dart';

abstract class SmokingEntryEvent extends Equatable {
  SmokingEntryEvent([List props = const []]) : super(props);
}

class FetchSmokingEntry extends SmokingEntryEvent {}

class SaveSmokingEntry extends SmokingEntryEvent {
  final SmokingEntry entry;

  SaveSmokingEntry({@required this.entry});
}

 