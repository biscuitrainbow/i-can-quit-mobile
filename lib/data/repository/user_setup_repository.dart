import 'dart:io';

import 'package:dio/dio.dart';
import 'package:i_can_quit/data/model/quiting_path.dart';
import 'package:i_can_quit/data/model/user_first_setup.dart';
import 'package:i_can_quit/data/repository/token_repository.dart';

class UserSetupRepository {
  final Dio dio;
  final TokenRepository tokenRepository;

  UserSetupRepository(this.dio, this.tokenRepository);

  Future<Null> create(UserSetup setup) async {
    await dio.post(
      '/user/setup',
      options: Options(headers: {
        HttpHeaders.authorizationHeader: await tokenRepository.getToken(),
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
}
