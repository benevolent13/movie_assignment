import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';


class NetworkImageView extends StatelessWidget {
  double width;
  double height;
  EdgeInsets? margin ;
  EdgeInsets? padding;
  String url;
  BoxFit boxFit;

  NetworkImageView({
    required this.width,
    required this.height,
    this.margin,
    this.padding,
    required this.url,
    this.boxFit = BoxFit.fill,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      padding: padding,
      child: CachedNetworkImage(
        fit: boxFit,
        errorWidget: (context, url, error) => const Icon(Icons.error),
        placeholder: (context, url) =>
        Center(child: CircularProgressIndicator()),
        imageUrl: "https://image.tmdb.org/t/p/w500"+url,
      ),
    );
  }
}
