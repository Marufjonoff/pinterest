import 'dart:convert';
import 'package:http/http.dart';
import 'package:pinterest_project/models/pinterest_model.dart';
import 'package:pinterest_project/services/log_service.dart';

class HttpService {
  static String BASE_URL = "api.unsplash.com";
  static bool isTester = true;

  // Header
  static Map<String, String> headers = {
    "Accept-Version": "v1",
    "Authorization": "Client-ID SGvm8KCgoAUBo9DQLWKVeCBfP8HZe1yZr5OOUPnUanA"
  };

  // Apis
  static String API_TODO_LIST_RANDOM = "/photos/random/";
  static String API_TODO_LIST = "/photos";
  static String API_DOWNLOAD = "/photos/:id/download";
  static String API_TODO_ONE = "/photos"; // {ID}
  static String API_TODO_SEARCH = "/search/photos";

  // Methods
  static Future<String?> GET(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE_URL, api, params);
    Log.d("URL => $uri");
    Response response = await get(uri, headers: headers);
      Log.i("Hello http $params => ${response.body}");
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  // Future<String?> MULTIPART(String api, String filePath, Map<String,  String> params) async {
  //   var uri = Uri.https(getServer(), api); // http or https
  //   var request = MultipartRequest("POST", uri);
  //
  //   request.headers.addAll(getHeaders());
  //   request.fields.addAll(params);
  //   request.files.add(await MultipartFile.fromPath("picture", filePath));
  //
  //   var res = await request.send();
  //   return res.reasonPhrase;
  // }

  static Map<String, String> paramsPage(int pageNumber, int number) {
    Map<String, String> params = {};
    params.addAll({
      "page":pageNumber.toString(),
      "per_page":number.toString(),
    });
    return params;
  }

  static Map<String, String> paramsSearch(int pageNumber,String query) {
    Map<String, String> params = {};
    params.addAll({
      "page":pageNumber.toString(),
      "query":query.toString()
    });
    return params;
  }

  static Map<String, String> randomPage(int pageNumber) {
    Map<String, String> params = {};
    params.addAll({
      "count":pageNumber.toString(),
    });
    return params;
  }

  // Params
  static Map<String, String> paramEmpty() {
    Map<String, String> map = {};
    return map;
  }


  static List<Post> parseResponse(String response) {
    List json = jsonDecode(response);
    Log.i("Json => $json");
    List<Post> photos = List<Post>.from(json.map((x) => Post.fromJson(x)));
    return photos;
  }

  static Map<String, String> downloadUrl(String id){
    Map<String, String> params = {};
    params.addAll({"id": id});
    return params;
  }

  static List<Post> parseSearchParse(String response) {
    Map<String, dynamic> json = jsonDecode(response);
    List<Post> photos = List<Post>.from(json["results"].map((x) => Post.fromJson(x)));
    return photos;
  }
}