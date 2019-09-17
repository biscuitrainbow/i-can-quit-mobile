import 'dart:io';

import 'package:dio/dio.dart';
import 'package:i_can_quit/data/model/smoking_entry.dart';
import 'package:i_can_quit/data/repository/token_repository.dart';
import 'package:i_can_quit/ui/util/string_util.dart';

class SmokingEntryRepository {
  final Dio dio;
  final TokenRepository tokenRepository;

  SmokingEntryRepository(this.dio, this.tokenRepository);

  Future<Null> create(SmokingEntry entry) async {
    final response = await dio.post(
      '/entry',
      options: Options(headers: {
        HttpHeaders.authorizationHeader: toBearer(await tokenRepository.getToken()),
      }),
      data: entry.toMap(),
    );

    return null;
  }

  Future<List<SmokingEntry>> fetchEntries() async {
    final response = await dio.get(
      '/entry',
      options: Options(headers: {
        HttpHeaders.authorizationHeader: toBearer(await tokenRepository.getToken()),
      }),
    );

    return SmokingEntry.fromJsonArray(response.data);
  }
}
