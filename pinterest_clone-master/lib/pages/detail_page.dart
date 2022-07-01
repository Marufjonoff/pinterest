import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinterest_project/models/utils.dart';
import 'package:pinterest_project/view_models/detail_view_model.dart';
import 'package:provider/provider.dart';

import '../services/log_service.dart';

class DetailPage extends StatefulWidget {

  String indexImage;
  DetailPage(this.indexImage);

  static const String id = "detail_page";
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  DetailViewModel viewModel = DetailViewModel();
  late String imageUrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageUrl = widget.indexImage;
    viewModel.scrollPosition();
    viewModel.apiGet();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    viewModel.scrollController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<DetailViewModel>(
        builder: (ctx, viewModel, widget) => SafeArea(
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            backgroundColor: Colors.black,
            body: SingleChildScrollView(
              controller: viewModel.scrollController,
              child: Column(
                children: [
                  // user #info
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        ClipRRect(
                          borderRadius: BorderRadius.circular(23.0),
                          child: Column(
                            children: [
                              Stack(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: imageUrl,
                                      placeholder: (context, index) => Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(23.0),
                                            color: Colors.grey
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                        child: IconButton(
                                          onPressed: (){},
                                          icon: const Icon(FontAwesomeIcons.ellipsisH, color: Colors.white,size: 30,),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: CircleAvatar(
                                            radius: 25,
                                            backgroundColor: Colors.white.withOpacity(0.4),
                                            child: IconButton(
                                              onPressed: (){},
                                              icon: const Icon(Icons.zoom_in, color: Colors.black, size: 30,),
                                            ),
                                          )
                                      ),
                                    ),
                                  ]
                              ),


                              const SizedBox(
                                height: 15,
                              ),
                              Text(viewModel.name,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),),
                              const SizedBox(
                                height: 20,
                              ),


                              SizedBox(
                                height: 70,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: (){
                                        Log.i("comment");
                                      },
                                      icon: const Icon(FontAwesomeIcons.comment, color: Colors.black,),
                                    ),
                                    Row(
                                      children: [
                                        MaterialButton(
                                          elevation: 0,
                                          onPressed: (){},
                                          height: 60,
                                          shape: const StadiumBorder(),
                                          color: Colors.grey.withOpacity(0.3),
                                          child: const Text("View", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),),
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        MaterialButton(
                                          elevation: 0,
                                          height: 60,
                                          shape: const StadiumBorder(),
                                          onPressed: (){},
                                          color: Colors.red.shade800,
                                          child: const Text("Save", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: (){
                                        Log.i("comment");
                                      },
                                      icon: const Icon(Icons.share, color: Colors.black,),
                                    ),

                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 3,
                  ),

                  // comments
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 18,
                        ),
                        const Align(
                          alignment: Alignment.center,
                          child: Text("Comments", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.black),),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: SizedBox(
                                height: 50,
                                width: 50,
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.grey.shade300,
                                  child: Center(
                                    child: TextButton(
                                      onPressed: (){
                                        Log.i("Hello => welcome account");
                                      },
                                      child: Text(viewModel.name.substring(0, 1), style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 25, color: Colors.black),),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Text("Obidjon", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("Zo'r", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: const [
                                    Icon(Icons.favorite, color: Colors.black,),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("Reply", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: SizedBox(
                                height: 50,
                                width: 50,
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.grey.shade300,
                                  child: Center(
                                    child: TextButton(
                                      onPressed: (){
                                        Log.i("Hello => welcome account");
                                      },
                                      child: Text(viewModel.name.substring(0, 1), style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 25, color: Colors.black),),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){},
                              child: Text("Add a comment", style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.w500),),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: MaterialButton(
                            elevation: 0,
                            onPressed: (){},
                            height: 50,
                            shape: const StadiumBorder(),
                            color: Colors.grey.withOpacity(0.3),
                            child: Text("See ${viewModel.seeMore.toString()} more", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),),
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),

                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: const [
                        SizedBox(
                          height: 18,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text("More likes this", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.black),),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                      ],
                    ),
                  ),

                  // Image builder
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: MasonryGridView.builder(
                        padding: const EdgeInsets.all(0),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: viewModel.notes.length,
                        mainAxisSpacing: 7,
                        crossAxisSpacing: 7,
                        itemBuilder: (context, index){
                          return GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                                return DetailPage(viewModel.notes[index].urls!.small!);
                              })
                              );
                            },
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(23.0),
                                child: CachedNetworkImage(
                                  imageUrl: viewModel.notes[index].urls!.small!,
                                  placeholder: (context, widget) => AspectRatio(
                                    aspectRatio: viewModel.notes[index].width!/viewModel.notes[index].height!,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.0),
                                        color: UtilsColors(value: viewModel.notes[index].color!).toColor(),
                                      ),
                                    ),
                                  ),
                                )
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
