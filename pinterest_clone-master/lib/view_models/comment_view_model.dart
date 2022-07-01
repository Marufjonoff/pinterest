import 'package:flutter/material.dart';
import 'package:pinterest_project/services/log_service.dart';

import '../models/pinterest_model.dart';
import '../services/http_service.dart';

class CommentViewModel extends ChangeNotifier {
  List<Post> note = [];
  List<Post> imageList = [];
  bool isLoadMore = false;
  bool isLoading = true;
  int count = 10;
  late int pageIndex = 0;

  Future<void> random() async {
    String? response = await HttpService.GET(HttpService.API_TODO_LIST_RANDOM, HttpService.randomPage(count));
    List<Post> list = HttpService.parseResponse(response!);

      note.addAll(list);
      Log.d("Length => ${list.length}");
    notifyListeners();
  }

  Future<void> randomBasicImage(int countImage) async {
    String? response = await HttpService.GET(HttpService.API_TODO_LIST_RANDOM, HttpService.randomPage(countImage));
    List<Post> list = HttpService.parseResponse(response!);

      imageList.clear();
      imageList.addAll(list);
  notifyListeners();
  }

  void tabControl(int index) {
    pageIndex = index;
    notifyListeners();
  }

}