import 'package:movie_assignment/service/server_error.dart';

class BaseResponse<T> {
  late ServerError _error;
  late T data;

  setException(ServerError error) {
    _error = error;
  }

  setData(T data) {
    this.data = data;
  }

  get getException {
    return _error;
  }
}
