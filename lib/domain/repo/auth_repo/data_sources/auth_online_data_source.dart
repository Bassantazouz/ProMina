import 'package:dartz/dartz.dart';

abstract class AuthOnlineDataSource {
  Future<Either<String, bool>> login(String email, String password);

}