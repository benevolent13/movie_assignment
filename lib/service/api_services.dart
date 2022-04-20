import 'dart:io';

import 'package:dio/dio.dart';
import 'package:movie_assignment/service/apiclient.dart';
import 'package:movie_assignment/service/response/base_response.dart';
import 'package:movie_assignment/service/response/movie_list_response.dart';
import 'package:movie_assignment/service/server_error.dart';


class ApiServices {
  ApiClient apiClient = ApiClient(Dio(BaseOptions(
      connectTimeout: 10000,
      receiveTimeout: 10000,
  )));

  Future<BaseResponse<MovieListResponse>> getMovieByLanguage(
      String language,String page) async {
    var response;
    try {
      response = await apiClient.getMoviesByLanguage(
          language,page);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<MovieListResponse>> getTopRatedMovie(
      String page) async {
    var response;
    try {
      response = await apiClient.getTopRated(
          page);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error: error as DioError));
    }
    return BaseResponse()..data = response;
  }



}
