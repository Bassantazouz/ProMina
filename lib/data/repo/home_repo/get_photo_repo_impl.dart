import 'dart:convert';

import 'package:http/http.dart';
import 'package:pro_mina/domain/repo/home_repo/get_photo_repo.dart';

import '../../../../core/utils/shered_utils.dart';
import '../../modals/get_photo_response.dart';

class GetHomeImpl extends GetHomeRepo {
  @override
  Future<GetPhotoResponse?> getPhotos() async {
    try {
      Uri url = Uri.parse('https://flutter.prominaagency.com/api/my-gallery');
      Response serverResponse = await get(url, headers: {
        'Authorization':
        'Bearer ${CacheHelper.getDataToSharedPref(key: "userToken")}'
      });
      if (serverResponse.statusCode >= 200 && serverResponse.statusCode < 300) {
        GetPhotoResponse authResponse =
        GetPhotoResponse.fromJson(jsonDecode(serverResponse.body));
        return authResponse;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
