import 'package:movie_assignment/service/response/movie_list_response.dart';

abstract class HomePageState {}

class HomePageInitState extends HomePageState {}

class HomePageLoadingState extends HomePageState {}

class HomePageErrorState extends HomePageState {
  String messsage;

  HomePageErrorState(this.messsage);
}

class HomePageCompleteState extends HomePageState {
  List<Results> listJapanse;
  List<Results> listHindi;
  List<Results> listKorea;
  List<Results> listTopRated;

  HomePageCompleteState(this.listJapanse, this.listHindi, this.listKorea,this.listTopRated);
}


