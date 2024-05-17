
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:pro_mina/core/utils/shered_utils.dart';
import 'package:pro_mina/data/modals/AuthResponse.dart';
import 'package:pro_mina/domain/repo/auth_repo/data_sources/auth_online_data_source.dart';

@injectable
class AuthOnlineDataSourceImpl extends AuthOnlineDataSource {
  @override
  Future<Either<String, bool>> login(String email, String password) async {
    try {
      Uri url = Uri.parse('https://flutter.prominaagency.com/api/auth/login');
      Response serverResponse =
      await post(url, body: {"email": email, "password": password});
      AuthResponse authResponse =
      AuthResponse.fromJson(jsonDecode(serverResponse.body));
      if (serverResponse.statusCode >= 200 && serverResponse.statusCode < 300) {
        await CacheHelper.setDataToSharedPref(
            key: 'userToken',
            value: authResponse.token);
        return const Right(true);
      } else {
        return Left(authResponse.user?.name ??
            "invalid user name or password");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}