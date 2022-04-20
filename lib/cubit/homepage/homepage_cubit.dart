import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_assignment/cubit/homepage/homepage_states.dart';
import 'package:movie_assignment/service/api_services.dart';
import 'package:movie_assignment/service/response/base_response.dart';
import 'package:movie_assignment/service/response/movie_list_response.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageInitState()) {
    getData();
  }
  List<Results> hindiMovies = [];
  List<Results> koreanMovies = [];
  List<Results> japaneseMovies = [];
  List<Results> topRatedMovies = [];

  getData() async {
    emit(HomePageLoadingState());
    try {
      BaseResponse<MovieListResponse> hindiData =
          await ApiServices().getMovieByLanguage("hi-IN","1");
      BaseResponse<MovieListResponse> japanData =
          await ApiServices().getMovieByLanguage("ja-JP","1");
      BaseResponse<MovieListResponse> koreaData =
          await ApiServices().getMovieByLanguage("ko-KP","1");
      BaseResponse<MovieListResponse> listTopRated =
      await ApiServices().getTopRatedMovie("1");

      hindiMovies = hindiData.data.results!;
      japaneseMovies = japanData.data.results!;
      koreanMovies = koreaData.data.results!;
      topRatedMovies = listTopRated.data.results!.sublist(0,5);

      if (hindiMovies.isNotEmpty &&
          japaneseMovies.isNotEmpty &&
          koreanMovies.isNotEmpty) {
        emit(HomePageCompleteState(hindiMovies, japaneseMovies, koreanMovies,this.topRatedMovies));
      }
    } catch (e) {
      emit(HomePageErrorState(e.toString()));
    }
  }
}
