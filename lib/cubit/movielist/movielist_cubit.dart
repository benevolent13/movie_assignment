import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_assignment/cubit/movielist/movielist_states.dart';
import 'package:movie_assignment/service/api_services.dart';
import 'package:movie_assignment/service/response/movie_list_response.dart';

class MovieListCubit extends Cubit<MovieListState> {
  MovieListCubit() : super(MovieListInitState());


  int page = 0;

  getMovieList(String language) {
    emit(MovieListLoadingState());
    page = page + 1;
    try {
      emit(MovieListStopLoadingState());
      ApiServices().getMovieByLanguage(language, page.toString()).then((value) {
        emit(MovieListCompleteState(value.data.results!));
      });
    } catch (e) {
      emit(MovieListErrorState(e.toString()));
    }
  }

  getTopMovieList() {
    emit(MovieListLoadingState());
    page = page + 1;
    try {
      emit(MovieListStopLoadingState());
      ApiServices().getTopRatedMovie(page.toString()).then((value) {
        emit(MovieListCompleteState(value.data.results!));
      });
    } catch (e) {
      emit(MovieListErrorState(e.toString()));
    }
  }
}
