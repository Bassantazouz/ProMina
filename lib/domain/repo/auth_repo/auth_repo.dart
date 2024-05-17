
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either<String, bool>> login(String email, String password);

}