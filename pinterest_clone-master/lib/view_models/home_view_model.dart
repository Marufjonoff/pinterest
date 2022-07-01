import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pinterest_project/models/pinterest_model.dart';
import 'package:pinterest_project/services/http_service.dart';
import 'package:pinterest_project/services/log_service.dart';

class HomeViewModel extends ChangeNotifier {
  late TabController tabController;
  late final ScrollController scrollController = ScrollController();

  List<Post> note = [];
  bool isLoading = true;
  bool isLoadMore = false;
  bool isDownload = false;

  void _showResponse(String response) {
    List<Post> list = HttpService.parseResponse(response);
    note = list;
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
  Map <String, String> urlD= {};

  Future<void> random() async {
    String? response = await HttpService.GET(HttpService.API_TODO_LIST_RANDOM, HttpService.randomPage(10));
    List<Post> list = HttpService.parseResponse(response!);

    note.addAll(list);
    isLoadMore = false;

    notifyListeners();
  }

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
  List<Tab> tabs = [
    const Tab(
      height: 40,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6),
        child: Text(
          'All',
          style: TextStyle(fontSize: 16),
        ),
      ),
    ),
  ];

  save(int index) async {
    var status = await Permission.storage.request();
    if(status.isGranted) {
      var response = await Dio().get(
          note[index].urls!.small!,
          options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data), quality: 100,
          name: DateTime.now().toString());
        Log.i("Hello success => $result");
    }
  }

  late int colorIndex;


}