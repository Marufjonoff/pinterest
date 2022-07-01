import 'package:flutter/material.dart';
import 'package:pinterest_project/models/pinterest_model.dart';
import 'package:pinterest_project/services/http_service.dart';

class DetailViewModel extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();

  String name = "Obidjon Ma'rufjonoff";
  int seeMore = 3;
  List<Post> notes = [];
  bool isLoading = true;
  bool isLoadMore = false;

  scrollPosition() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
          isLoadMore = true;
        notifyListeners();

        random();
      }
    });
  }

  void _showResponse(String response) {
    List<Post> list = HttpService.parseResponse(response);
      notes = list;
      isLoading = false;
    notifyListeners();
  }

  void apiGet() {
    HttpService.GET(HttpService.API_TODO_LIST, HttpService.paramEmpty())
        .then((value) {
      if (value != null) {
        _showResponse(value);
      }
    });
  }

  Future<void> random() async {
    String? response = await HttpService.GET(HttpService.API_TODO_LIST_RANDOM, HttpService.randomPage(10));
    List<Post> list = HttpService.parseResponse(response!);
      notes.addAll(list);
      isLoadMore = false;
    notifyListeners();
  }

}