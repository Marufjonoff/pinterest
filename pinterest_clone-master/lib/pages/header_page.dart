import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinterest_project/pages/account_page.dart';
import 'package:pinterest_project/pages/comment_page.dart';
import 'package:pinterest_project/pages/home_page.dart';
import 'package:pinterest_project/pages/search_page.dart';
import 'package:pinterest_project/view_models/header_view_model.dart';
import 'package:provider/provider.dart';

class HeaderPage extends StatelessWidget {
  static const String id = 'header_page';
  HeaderPage({Key? key}) : super(key: key);

  final _viewModel = HeaderViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel,
      child: Consumer<HeaderViewModel>(
        builder: (ctx, model, index) =>Scaffold(
          extendBody: true,
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _viewModel.pageController,
            onPageChanged: (int index) => _viewModel.indexManage(index),
            children:const [
              HomePage(),
              SearchPage(),
              CommentPage(),
              AccountPage(),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal:45, vertical: 15),
            child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.white,
                ),
                child: BottomNavigationBar(
                  backgroundColor: Colors.transparent,
                  type: BottomNavigationBarType.fixed,
                  elevation: 0,
                  selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.blueGrey,
                  items: const [
                    BottomNavigationBarItem(icon: Icon(Icons.home_filled, size: 30,), label: ''),
                    BottomNavigationBarItem(icon: Icon(Icons.search, size:  30,), label: ''),
                    BottomNavigationBarItem(icon: Icon(Icons.comment, size: 30,), label: ''),
                    BottomNavigationBarItem(icon: Icon(Icons.perm_identity, size: 30,), label: ''),
                  ],
                  currentIndex: _viewModel.selectedIndex,
                  onTap: (int index) => _viewModel.pageControl(index),
                )
            ),
          ),
        ),
      )
    );
  }
}
