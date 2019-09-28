import 'dart:convert';
import 'package:flutter/material.dart';

class News {
  final String title;
  final String content;
  final String featuredImage;

  News({
    @required this.title,
    @required this.content,
    @required this.featuredImage,
  });

  News copyWith({
    String title,
    String content,
    String featuredImage,
  }) {
    return News(
      title: title ?? this.title,
      content: content ?? this.content,
      featuredImage: featuredImage ?? this.featuredImage,
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
      featuredImage: map['featuredImage'],
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
