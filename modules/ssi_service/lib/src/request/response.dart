import 'exceptions.dart';

enum Status { COMPLETED, ERROR }

class SsiResponse implements Exception {
  Status? status;
  dynamic data;
  HttpException? exception;

  SsiResponse.completed(this.data) {
    this.status = Status.COMPLETED;
  }

  SsiResponse.error(this.exception) {
    this.status = Status.ERROR;
  }

  SsiResponse.failureFormResponse({this.data}) {
    exception = BadResponseException(data);
    this.status = Status.ERROR;
  }

  SsiResponse.failureFromError([HttpException? error]) {
    this.exception = error ?? UnknownException();
    this.status = Status.ERROR;
  }

  @override
  String toString() {
    return "Status : $status \n Message : $exception \n Data : $data";
  }
}
