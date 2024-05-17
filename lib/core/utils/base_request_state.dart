
import 'package:pro_mina/data/modals/get_photo_response.dart';

abstract class BaseRequestStates {}

class BaseRequestInitialState extends BaseRequestStates {}

class LoginLoadingState extends BaseRequestStates {}

class LoginSuccessState extends BaseRequestStates {}

class LoginErrorState extends BaseRequestStates {
  String message;
LoginErrorState(this.message);
}
class GetPhotoLoadingState extends BaseRequestStates {}


class GetPhotoSuccessState extends BaseRequestStates {
  GetPhotoResponse? data;
  GetPhotoSuccessState({this.data});
}

class GetPhotoErrorState extends BaseRequestStates {
  String message;

  GetPhotoErrorState(this.message);
}
class ImageUploadInitial extends BaseRequestStates {}

class ImageUploadLoading extends BaseRequestStates {}

class ImageUploadSuccess extends BaseRequestStates {
  final String message;
  ImageUploadSuccess(this.message);
}

class ImageUploadFailure extends BaseRequestStates {
  final String error;
  ImageUploadFailure(this.error);
}