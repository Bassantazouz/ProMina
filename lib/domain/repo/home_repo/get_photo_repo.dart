import '../../../data/modals/get_photo_response.dart';

abstract class GetHomeRepo{
  Future<GetPhotoResponse?> getPhotos();
}
