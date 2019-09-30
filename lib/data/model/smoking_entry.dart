import 'dart:ui';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:i_can_quit/ui/util/date_time_util.dart';

class SmokingEntry {
  final int id;
  final String smokingNeededLevel;
  final bool hasSmoked;
  final DateTime datetime;
  final LatLng location;
  final String mood;

  SmokingEntry({
    this.id,
    this.smokingNeededLevel,
    this.hasSmoked,
    this.datetime,
    this.location,
    this.mood,
  });

  SmokingEntry.create({
    this.id,
    this.smokingNeededLevel = 'ไม่เลย',
    this.hasSmoked = false,
    this.location,
    this.mood,
  }) : datetime = DateTime.now();

  SmokingEntry copyWith({
    int id,
    String smokingNeededLevel,
    bool hasSmoked,
    DateTime datetime,
    LatLng location,
    String mood,
  }) {
    return SmokingEntry(
      id: id ?? this.id,
      smokingNeededLevel: smokingNeededLevel ?? this.smokingNeededLevel,
      hasSmoked: hasSmoked ?? this.hasSmoked,
      datetime: datetime ?? this.datetime,
      location: location ?? this.location,
      mood: mood ?? this.mood,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'smoking_needed_level': this.smokingNeededLevel,
      'has_smoked': hasSmoked ? 1 : 0,
      'date_time': toMysqlDateTime(this.datetime),
      'lat': this.location?.latitude,
      'lng': this.location?.longitude,
      'mood': this.mood,
    };
  }

  static SmokingEntry fromJson(dynamic json) {
    return SmokingEntry(
      id: json['id'],
      smokingNeededLevel: json['smoking_needed_level'],
      hasSmoked: json['has_smoked'],
      datetime: fromMysqlDateTime(json['date_time']),
      location: json['lat'] != null && json['lng'] != null ? LatLng(json['lat'], json['lng']) : null,
      mood: json['mood'] ?? null,
    );
  }

  static List<SmokingEntry> fromJsonArray(List<dynamic> array) {
    return array.map((json) => fromJson(json)).toList();
  }

  @override
  String toString() {
    return 'SmokingEntry id: $id, smokingNeededLevel: $smokingNeededLevel, hasSmoked: $hasSmoked, datetime: $datetime, location: $location, mood: $mood';
  }

  @override
  bool operator ==(Object o) {
    return o is SmokingEntry &&
        o.id == id &&
        o.smokingNeededLevel == smokingNeededLevel &&
        o.hasSmoked == hasSmoked &&
        o.datetime == datetime &&
        o.location == location &&
        o.mood == mood;
  }

  @override
  int get hashCode {
    return hashList([
      id,
      smokingNeededLevel,
      hasSmoked,
      datetime,
      location,
      mood,
    ]);
  }
}
