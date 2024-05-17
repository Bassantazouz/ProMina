import 'package:dartz/dartz.dart';
import 'package:pro_mina/data/modals/get_photo_response.dart';
import 'package:pro_mina/domain/repo/home_repo/get_photo_repo.dart';

class HomeUseCase {
  GetHomeRepo repo;
  HomeUseCase(this.repo);
  Future<GetPhotoResponse?> execute() {
    return repo.getPhotos();
  }
}