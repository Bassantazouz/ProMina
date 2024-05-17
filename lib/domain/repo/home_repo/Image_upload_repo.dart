import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

abstract class UploadHomeRepo{
  Future <Either<String,bool>> uploadImage();
}