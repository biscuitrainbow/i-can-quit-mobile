import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:i_can_quit/ui/util/date_time_util.dart';

class News {
  final String title;
  final String content;
  final String featuredImage;
  final DateTime updatedAt;

  News({
    @required this.title,
    @required this.content,
    @required this.featuredImage,
    @required this.updatedAt,
  });

  News copyWith({
    String title,
    String content,
    String featuredImage,
    DateTime updatedAt,
  }) {
    return News(
      title: title ?? this.title,
      content: content ?? this.content,
      featuredImage: featuredImage ?? this.featuredImage,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'featuredImage': featuredImage,
    };
  }

  static News fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return News(
      title: map['title'],
      content: map['content'],
      featuredImage: map['featured_image'],
      updatedAt: fromMysqlDateTime(map['updated_at']),
    );
  }

  static List<News> fromMapArray(List<dynamic> array) {
    return array.map((map) => fromMap(map)).toList();
  }

  String toJson() => json.encode(toMap());

  static News fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'News title: $title, content: $content, featuredImage: $featuredImage';

  @override
  bool operator ==(Object o) {
    return o is News && o.title == title && o.content == content && o.featuredImage == featuredImage;
  }

  @override
  int get hashCode {
    return hashList([
      title,
      content,
      featuredImage,
    ]);
  }
}
