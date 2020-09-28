import 'package:audio_player_full_flutter_course/models/audiofiles.dart';
import 'package:audio_player_full_flutter_course/models/category.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants.dart';

class NetworkServices {
  Future getRegisterResponse(String name, String email, String password) async {
    http.Response response = await http.post(kRegisterUrl, body: {
      "name": name,
      "password": password,
      "switch_status": "1",
      "email": email
    });
    return jsonDecode(response.body)["status"];
  }

  Future getLoginResponse(String email, String password) async {
    http.Response response = await http.post(kLoginUrl,
        body: {"password": password, "switch_status": "1", "email": email});
    if (jsonDecode(response.body)["status"] == "error") {
      return "error";
    } else {
      return jsonDecode(response.body)["login"]["user_id"];
    }
  }

  Future<List<Category>> getCategories(String uId) async {
    http.Response response =
        await http.post(kCategoryUrl, body: {"user_id": uId});
    var jsonData = json.decode(response.body)["categories"];
    List<Category> categoryList = [];
    for (var data in jsonData) {
      Category category = Category(
        category_description: data["category_description"],
        category_id: data["category_id"],
        category_image: data["category_image"],
        category_name: data["category_name"],
      );
      categoryList.add(category);
    }
    return categoryList;
  }

  Future<List<AudioFiles>> getAudioFiles(String uId, String categoryId) async {
    http.Response response = await http.post(kAudioFilesUrl,
        body: {"user_id": uId, "category_id": categoryId});
    var jsonData = json.decode(response.body)["category_audio"];
    List<AudioFiles> audioFilesList = [];
    for (var data in jsonData) {
      AudioFiles audioFiles = AudioFiles(
          audio_description: data["audio_description"],
          audio_image: data["audio_image"],
          audio_link_1: data["audio_link_1"],
          audio_name: data["audio_name"]);
      audioFilesList.add(audioFiles);
    }
    return audioFilesList;
  }
}
