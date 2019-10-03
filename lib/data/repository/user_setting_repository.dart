import 'dart:io';

import 'package:dio/dio.dart';
import 'package:i_can_quit/data/model/quiting_path.dart';
import 'package:i_can_quit/data/model/user_setting.dart';
import 'package:i_can_quit/data/repository/token_repository.dart';
import 'package:i_can_quit/ui/util/string_util.dart';

class UserSettingRepository {
  final Dio dio;
  final TokenRepository tokenRepository;

  UserSettingRepository(this.dio, this.tokenRepository);

  Future<Null> create(UserSetting setting) async {
    await dio.post(
      '/user/setup',
      options: Options(headers: {
        HttpHeaders.authorizationHeader: toBearer(await tokenRepository.token()),
      }),
      data: {
        'number_of_cigarette_per_day': setting.numberOfCigarettesPerDay,
        'price_per_package': setting.pricePerPackage,
        'number_of_cigarette_per_package': setting.numberOfCigarettesPerPackage,
        'quiting_path': quitingPathToString(setting.path),
      },
    );

    return null;
  }

  Future<List<UserSetting>> fetchUserSettings() async {
    final response = await dio.get(
      '/user/setup',
      options: Options(headers: {
        HttpHeaders.authorizationHeader: toBearer(await tokenRepository.token()),
      }),
    );

    return UserSetting.fromMapArray(response.data);
  }
}
