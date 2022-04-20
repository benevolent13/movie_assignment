import 'package:dio/dio.dart';
import 'package:movie_assignment/service/apis.dart';
import 'package:movie_assignment/service/response/movie_list_response.dart';
import 'package:retrofit/retrofit.dart';
part 'apiclient.g.dart';

@RestApi(baseUrl: "https://api.themoviedb.org/3/movie")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET(Apis.getMovieList)
  Future<MovieListResponse> getMoviesByLanguage(@Path("language") String language,@Path("page") String page);

  @GET(Apis.getTopRatedMovieList)
  Future<MovieListResponse> getTopRated(@Path("page") String page);


}
