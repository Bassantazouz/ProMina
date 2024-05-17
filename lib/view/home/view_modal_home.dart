import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_mina/data/modals/get_photo_response.dart';
import 'package:pro_mina/data/repo/home_repo/get_photo_repo_impl.dart';
import 'package:pro_mina/domain/repo/home_repo/get_photo_repo.dart';
import '../../core/utils/base_request_state.dart';
import '../../data/repo/home_repo/image_upload_repo_impl.dart';

class HomeViewModel extends Cubit<BaseRequestStates> {
  HomeViewModel() : super(BaseRequestInitialState());
  GetPhotoResponse getPhotoResponse = GetPhotoResponse();
  ImageUploadRepo imageUploadRepo = ImageUploadRepo();
  GetHomeRepo getHomeRepo = GetHomeImpl();
  XFile? pickerFile;
  final picker = ImagePicker();
  Future getImageFromCamera() async {
    emit(ImageUploadLoading());
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final result = await imageUploadRepo.uploadImage(pickedFile);

      result.fold(
            (left) {
          emit(ImageUploadFailure(left));
        },
            (right) {
          emit(ImageUploadSuccess(right));
        },
      );
    } else {
      emit(ImageUploadFailure('No image selected.'));

    }
  }

  Future getImageFromGallery() async {
    emit(ImageUploadLoading());
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final result = await imageUploadRepo.uploadImage(pickedFile);

      result.fold(
            (left) {
          emit(ImageUploadFailure(left));
        },
            (right) {
          emit(ImageUploadSuccess(right));
        },
      );
    } else {
      emit(ImageUploadFailure('No image selected.'));

    }
  }


  Future<void> getPhotos()async{
    emit(GetPhotoLoadingState());
    await getHomeRepo.getPhotos().then((value){
      getPhotoResponse = value!;
    },onError: (e){});
    if(getPhotoResponse.status == "success"){
      emit(GetPhotoSuccessState(data: getPhotoResponse));
    }else{
      emit(GetPhotoErrorState("something went wrong please try again"));
    }
  }

}