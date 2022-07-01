import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../view_models/account_view_model.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  static const String id = 'account_page';
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  AccountViewModel viewModel = AccountViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<AccountViewModel>(
        builder: (ctx, viewModel, widget) => RefreshIndicator(
          onRefresh: viewModel.refresh,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              actions: [
                IconButton(
                  icon: const Icon(Icons.share, color: Colors.black,),
                  onPressed: (){},
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: IconButton(
                    icon: const Icon(FontAwesomeIcons.ellipsisH, color: Colors.black, size: 18,),
                    onPressed: (){},
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 114,
                    width: 114,
                    child: CircleAvatar(
                      radius: 57,
                      backgroundColor: Colors.grey.shade300,
                      child: Center(
                        child: TextButton(
                          onPressed: (){
                            if (kDebugMode) {
                              print("Hello => welcome account");
                            }
                          },
                          child: Text(viewModel.name.substring(0, 1), style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 30, color: Colors.black),),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Center(child: Text(viewModel.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 35, color: Colors.black),)),
                  const SizedBox(
                    height: 12,
                  ),
                  Center(child: Text(viewModel.email, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: Colors.black),)),
                  const SizedBox(
                    height: 12,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: Text(viewModel.followers.toString(), style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: Colors.black),)),
                        const SizedBox(
                          width: 5,
                        ),
                        const Center(child: Text("followers", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: Colors.black),)),
                        const SizedBox(
                          width: 5,
                        ),
                        const CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 1,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Center(child: Text(viewModel.followings.toString(), style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: Colors.black),)),
                        const SizedBox(
                          width: 5,
                        ),
                        const Center(child: Text("followings", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: Colors.black),)),
                      ],
                    ),
                  ),
                  Container(
                    height: 70,
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 5,
                              child: GestureDetector(
                                onTap: (){
                                  if (kDebugMode) {
                                    print("Hello => TextField");
                                  }
                                },
                                child: Container(
                                    height: 38,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(19),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: const [
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Icon(Icons.search, color: Colors.black54,),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        Text("Search your Pins", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black54),),
                                      ],
                                    )
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                  onTap: (){
                                    if (kDebugMode) {
                                      print("Hello => add");
                                    }
                                  },
                                  child: const Icon(Icons.add, size: 30,  color: Colors.black,)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: MasonryGridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          itemCount: viewModel.defaultImage.length,
                          itemBuilder: (context, index){
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Image(
                                    image: NetworkImage(viewModel.defaultImage[index]),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Align(
                                      child: GestureDetector(
                                        onTap: (){},
                                        child: const Icon(FontAwesomeIcons.ellipsisH, color: Colors.black, size: 17,),
                                      ),
                                      alignment: Alignment.centerRight,
                                    ),
                                  ),
                                  width: MediaQuery.of(context).size.width/2,
                                  height: 20,
                                ),
                              ],
                            );
                          }
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
