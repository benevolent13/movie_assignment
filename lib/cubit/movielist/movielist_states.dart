import 'package:movie_assignment/service/response/movie_list_response.dart';

abstract class MovieListState {}

class MovieListInitState extends MovieListState {}

class MovieListLoadingState extends MovieListState {}

class MovieListStopLoadingState extends MovieListState {}

class MovieListErrorState extends MovieListState {
  String messsage;

  MovieListErrorState(this.messsage);
}

class MovieListCompleteState extends MovieListState {
  List<Results> list;

  MovieListCompleteState(this.list);
}
