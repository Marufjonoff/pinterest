import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:pinterest_project/models/utils.dart';
import 'package:pinterest_project/pages/detail_page.dart';
import 'package:pinterest_project/view_models/home_view_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String id = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  HomeViewModel viewModel = HomeViewModel();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    viewModel.scrollController.removeListener(() {});
    viewModel.scrollController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.apiGet();
    viewModel.tabController = TabController(length: 1, vsync: this);
    viewModel.tabController.animateTo(0);
    viewModel.scrollPosition();
  }
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<HomeViewModel>(
        builder: (ctx, viewModel, widget) => Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            toolbarHeight: 58,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, bottom: 8),
                  child: TabBar(
                    isScrollable: true,
                    // indicatorSize: TabBarIndicatorSize.label,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    indicator: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    tabs: viewModel.tabs,
                    controller: viewModel.tabController,
                  ),
                ),
              ),
            ),
          ),
          body: TabBarView(
            controller: viewModel.tabController,
            children: [
              viewModel.isLoading
                  ? Center(
                      child: SizedBox(
                          height: 40,
                          width: 40,
                          child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.grey.shade800,
                              child: Lottie.asset("assets/anime/lf30_editor_naboxmse.json"))),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Expanded(
                            flex: viewModel.isLoadMore ? 15 : 1,
                            child: MasonryGridView.builder(
                              controller: viewModel.scrollController,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemCount: viewModel.note.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                                        return DetailPage(viewModel.note[index].urls!.small!);
                                      }),
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width / 2,
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.circular(15.0),
                                              child: CachedNetworkImage(
                                                imageUrl: viewModel.note[index].urls!.small!,
                                                placeholder: (context, widget) => AspectRatio(
                                                  aspectRatio: viewModel.note[index].width!/viewModel.note[index].height!,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15.0),
                                                      color: UtilsColors(value: viewModel.note[index].color!).toColor(),
                                                    ),
                                                  ),
                                                ),
                                              )
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [viewModel.note[index].altDescription == null
                                                  ? Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        const Icon(Icons.favorite_rounded, color: Colors.red,
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(viewModel.note[index].likes.toString())
                                                      ],
                                                    )
                                                  : SizedBox(
                                                      width: MediaQuery.of(context).size.width / 2 - 60,
                                                      child: viewModel.note[index].altDescription!.length > 50
                                                          ? Text(
                                                              viewModel.note[index].altDescription!, overflow: TextOverflow.ellipsis,
                                                            )
                                                          : Text(viewModel.note[index].altDescription!)),

                                              IconButton(
                                                onPressed: (){},
                                                icon: const Icon(
                                                  FontAwesomeIcons.ellipsisH,
                                                  color: Colors.black,
                                                  size: 15,
                                                ),
                                                splashRadius: 5,
                                                padding: EdgeInsets.zero,
                                                constraints: const BoxConstraints(),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                );
                              },
                            ),
                          ),
                          viewModel.isLoadMore
                              ? Expanded(
                                  flex: 3,
                                  child: Container(
                                    alignment: Alignment.topCenter,
                                    color: Colors.transparent,
                                    child: SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Colors.grey.shade800,
                                            child: Lottie.asset("assets/anime/lf30_editor_naboxmse.json"))),
                                  ),
                                )
                              : const SizedBox.shrink()
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
