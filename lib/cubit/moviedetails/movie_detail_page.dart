import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_assignment/service/response/movie_list_response.dart';
import 'package:movie_assignment/utils/common_textstyles.dart';
import 'package:movie_assignment/utils/network_image_view.dart';

class MovieDetailPage extends StatefulWidget {
  Results movie;
  MovieDetailPage(this.movie, {Key? key}) : super(key: key);

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black54,
        appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text(
              "Movie Details",
              style: CommonTextStyles.boldStyle
                  .copyWith(color: Colors.white, fontSize: 24.0),
            )),
        body: Container(
      padding: EdgeInsets.all(12.0),
      child: Column(
        children: [
          NetworkImageView(
              width: Get.width,
              height: 200,
              url: widget.movie.posterPath.toString()),
          const SizedBox(
            height: 12.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Title : ",
                  style: CommonTextStyles.boldStyle
                      .copyWith(color: Colors.white, fontSize: 18.0)),
              Text(widget.movie.title.toString(),
                  maxLines: 20,
                  style: CommonTextStyles.boldStyle
                      .copyWith(color: Colors.white, fontSize: 14.0)),
            ],
          ),
          const SizedBox(
            height: 12.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Original Language : ",
                  style: CommonTextStyles.boldStyle
                      .copyWith(color: Colors.white, fontSize: 18.0)),
              Text(widget.movie.originalLanguage.toString(),
                  maxLines: 20,
                  style: CommonTextStyles.boldStyle
                      .copyWith(color: Colors.white, fontSize: 14.0)),
            ],
          ),
          const SizedBox(
            height: 12.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Overview : ",
                  style: CommonTextStyles.boldStyle
                      .copyWith(color: Colors.white, fontSize: 18.0)),
              Flexible(
                child: Text(widget.movie.overview.toString(),
                    maxLines: 20,
                    style: CommonTextStyles.boldStyle
                        .copyWith(color: Colors.white, fontSize: 14.0)),
              ),
            ],
          ),
          const SizedBox(
            height: 12.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Popularity : ",
                  style: CommonTextStyles.boldStyle
                      .copyWith(color: Colors.white, fontSize: 18.0)),
              Text(widget.movie.popularity.toString(),
                  maxLines: 20,
                  style: CommonTextStyles.boldStyle
                      .copyWith(color: Colors.white, fontSize: 14.0)),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Adult : ",
                  style: CommonTextStyles.boldStyle
                      .copyWith(color: Colors.white, fontSize: 18.0)),
              Flexible(
                child: Text(widget.movie.adult.toString(),
                    maxLines: 20,
                    style: CommonTextStyles.boldStyle
                        .copyWith(color: Colors.white, fontSize: 14.0)),
              ),
            ],
          ),

          const SizedBox(
            height: 12.0,
          ),
        ],
      ),
    ));
  }
}
