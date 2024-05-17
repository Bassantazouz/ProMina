import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/utils/shered_utils.dart';

class ImageUploadRepo{

Future <Either<String,String>> uploadImage(XFile? pickedFile)async{
  try{
    Dio dio = Dio();
    if(pickedFile != null){
      FormData formData = FormData.fromMap(
        {
          "img" : await MultipartFile.fromFile(pickedFile.path,filename: pickedFile.path.split('/').last)
        }
      );
      Options options = Options(
        headers: {
          'Authorization':'Bearer ${CacheHelper.getDataToSharedPref(key: "userToken")}'
        },
      );
      Response response = await dio.post(
        "https://flutter.prominaagency.com/api/upload",
        data: formData,
        options: options
      );

      if (response.statusCode == 200) {
        String message = response.data['message'] ?? 'Photo uploaded successfully';
        return Right(message);
      }  else {
        return Left('Failed to upload photo: ${response.statusCode}');
      }
    }
    return const Left('please select valid file');
  }catch(e){
    return const Left('Failed to upload photo');
  }
}




}