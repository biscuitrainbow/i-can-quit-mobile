import 'dart:io';

import 'package:dio/dio.dart';
import 'package:i_can_quit/data/model/achievement.dart';
import 'package:i_can_quit/ui/util/string_util.dart';

import 'token_repository.dart';

class AchievementRepository {
  final Dio dio;
  final TokenRepository tokenRepository;

  AchievementRepository(this.dio, this.tokenRepository);

  Future<List<Achievement>> fetchAchievements() async {
    final response = await dio.get(
      '/achievement',
      options: Options(headers: {
        HttpHeaders.authorizationHeader: toBearer(await tokenRepository.token()),
      }),
    );

    return Achievement.fromArrayMap(response.data);
  }
}
