import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:movie_assignment/cubit/homepage/homepage_cubit.dart';
import 'package:movie_assignment/cubit/homepage/homepage_states.dart';
import 'package:movie_assignment/cubit/movielist/movielist.dart';
import 'package:movie_assignment/service/response/movie_list_response.dart';
import 'package:movie_assignment/utils/common_textstyles.dart';
import 'package:movie_assignment/utils/network_image_view.dart';
import 'package:movie_assignment/utils/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageCubit homePageCubit = HomePageCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
          title: Text(
        "Home Page",
        style: CommonTextStyles.boldStyle
            .copyWith(color: Colors.white, fontSize: 24.0),
      )),
      body: Container(
          padding: const EdgeInsets.all(12.0),
          child: BlocConsumer<HomePageCubit, HomePageState>(
              bloc: homePageCubit,
              listener: (context, state) {
                if (state is HomePageLoadingState) {
                  Utils.showLoader(context);
                } else if (state is HomePageErrorState) {
                  //show Toast with message
                  Utils.hideLoader(context);
                  Utils.showToast(state.messsage);
                }
              },
              listenWhen: (context, state) {
                return true;
              },
              buildWhen: (context, state) {
                return true;
              },
              builder: (context, state) {
                if (state is HomePageCompleteState) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        getListView(state.listHindi, "hi-IN"),
                        getListView(state.listJapanse, "ja-JP"),
                        getListView(state.listKorea, "ka-KR"),
                        getListView(state.listTopRated, "",isTopRated: true),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              })),
    );
  }

  Widget getListView(List<Results> list, String language,{bool isTopRated = false}) {
    return Container(
      padding: EdgeInsets.all(8.0),
      height: 180,
      child: Column(
        children: [
          Row(
            children: [
              Spacer(),
              InkWell(
                onTap: (){
                  Get.to(MovieListPage(language,isTopRated));
                },
                child: Text("View All",
                    style: CommonTextStyles.boldStyle
                        .copyWith(color: Colors.white, fontSize: 18.0)),
              ),
            ],
          ),
          SizedBox(height: 12,),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (context, index) {
              return Container(
                height: 100,
                width: 100,
                margin: EdgeInsets.all(4.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    NetworkImageView(width: 100, height: 100, url: list[index].posterPath.toString()),
                    Text(list[index].title.toString(),
                        style: CommonTextStyles.primaryStyle
                            .copyWith(color: Colors.white, fontSize: 12.0)),
                  ],
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
