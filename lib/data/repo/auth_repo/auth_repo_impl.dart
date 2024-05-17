
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/repo/auth_repo/auth_repo.dart';
import 'data_sources/auth_online_data_source.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl extends AuthRepo {
  AuthOnlineDataSourceImpl onlineDataSource;
  Connectivity connectivity = Connectivity();

  AuthRepoImpl(this.onlineDataSource, this.connectivity);

  @override
  Future<Either<String, bool>> login(String email, String password) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      return onlineDataSource.login(email, password);
    } else {
      return Left("Please check your internet connection");
    }
  }


}