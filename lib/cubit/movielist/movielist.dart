import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:movie_assignment/cubit/moviedetails/movie_detail_page.dart';
import 'package:movie_assignment/cubit/movielist/movielist_cubit.dart';
import 'package:movie_assignment/cubit/movielist/movielist_states.dart';
import 'package:movie_assignment/service/response/movie_list_response.dart';
import 'package:movie_assignment/utils/common_textstyles.dart';
import 'package:movie_assignment/utils/network_image_view.dart';
import 'package:movie_assignment/utils/utils.dart';

class MovieListPage extends StatefulWidget {
  String language;
  bool isTopRated;
  MovieListPage(this.language, this.isTopRated, {Key? key}) : super(key: key);

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  MovieListCubit movieListCubit = MovieListCubit();

  ScrollController? scrollController;

  List<Results> list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController =  ScrollController(keepScrollOffset: true);
    scrollController!.addListener(scrollListener);
    widget.isTopRated
        ? movieListCubit.getTopMovieList()
        : movieListCubit.getMovieList(widget.language);
  }

  void scrollListener() {
    if ((scrollController?.position.extentAfter == 0)) {
      widget.isTopRated
          ? movieListCubit.getTopMovieList()
          : movieListCubit.getMovieList(widget.language);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black54,
        appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text(
              "Movie Listing",
              style: CommonTextStyles.boldStyle
                  .copyWith(color: Colors.white, fontSize: 24.0),
            )),
        body: BlocConsumer<MovieListCubit, MovieListState>(
            bloc: movieListCubit,
            listener: (context, state) {
              if (state is MovieListLoadingState) {
                Utils.showLoader(context);
              } else if (state is MovieListErrorState) {
                //show Toast with message
                Utils.hideLoader(context);
                Utils.showToast(state.messsage);
              } else if (state is MovieListStopLoadingState) {
                Utils.hideLoader(context);
              }else if(state is MovieListCompleteState){
                setState(() {
                  list.addAll(state.list);
                });
              }
            },
            listenWhen: (context, state) {
              return true;
            },
            buildWhen: (context, state) {
              return true;
            },
            builder: (context, state) {
              return list.isNotEmpty
                  ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  controller: scrollController,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(MovieDetailPage(list[index]));
                      },
                      child: Container(
                        width: Get.width,
                        margin: EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            NetworkImageView(
                                width: Get.width,
                                height: 200,
                                url: list[index].posterPath
                                    .toString()),
                            SizedBox(
                              height: 12.0,
                            ),
                            Text(list[index].title.toString(),
                                style: CommonTextStyles.boldStyle
                                    .copyWith(
                                    color: Colors.white,
                                    fontSize: 18.0)),
                          ],
                        ),
                      ),
                    );
                  })
                  : Container();
            }));
  }
}
