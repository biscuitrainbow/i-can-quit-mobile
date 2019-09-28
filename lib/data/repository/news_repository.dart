import 'dart:io';

import 'package:dio/dio.dart';
import 'package:i_can_quit/data/model/news.dart';
import 'package:i_can_quit/data/model/smoking_entry.dart';
import 'package:i_can_quit/data/repository/token_repository.dart';
import 'package:i_can_quit/ui/util/string_util.dart';

class NewsRepository {
  final Dio dio;
  final TokenRepository tokenRepository;

  NewsRepository(this.dio, this.tokenRepository);

  Future<List<News>> fetchNews() async {
    final response = await dio.get(
      '/news',
    );

    return News.fromMapArray(response.data);
  }
}
