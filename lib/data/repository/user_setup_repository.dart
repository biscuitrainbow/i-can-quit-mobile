import 'dart:io';

import 'package:dio/dio.dart';
import 'package:i_can_quit/data/model/quiting_path.dart';
import 'package:i_can_quit/data/model/user_setup.dart';
import 'package:i_can_quit/data/repository/token_repository.dart';
import 'package:i_can_quit/ui/util/string_util.dart';

class UserSetupRepository {
  final Dio dio;
  final TokenRepository tokenRepository;

  UserSetupRepository(this.dio, this.tokenRepository);

  Future<Null> create(UserSetup setup) async {
    await dio.post(
      '/user/setup',
      options: Options(headers: {
        HttpHeaders.authorizationHeader: toBearer(await tokenRepository.token()),
      }),
      data: {
        'number_of_cigarette_per_day': setup.numberOfCigarettesPerDay,
        'price_per_package': setup.pricePerPackage,
        'number_of_cigarette_per_package': setup.numberOfCigarettesPerPackage,
        'quiting_path': quitingPathToString(setup.path),
      },
    );

    return null;
  }

  Future<List<UserSetup>> fetchUserSetups() async {
    final response = await dio.get(
      '/user/setup',
      options: Options(headers: {
        HttpHeaders.authorizationHeader: toBearer(await tokenRepository.token()),
      }),
    );

    return UserSetup.fromMapArray(response.data);
  }
}
