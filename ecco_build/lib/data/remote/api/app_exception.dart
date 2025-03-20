class AppExceptions implements Exception {
  String title;
  String msg;

  AppExceptions({required this.title, required this.msg});

  String toErrorMsg() {
    return "${title}: ${msg}";
  }
}

class FetchDataException extends AppExceptions {
  FetchDataException({required String errorMsg}) : super(title: "Network Error", msg: errorMsg);
}

class BadRequestException extends AppExceptions {
  BadRequestException({required String errorMsg}) : super(title: "Invalid Request: ", msg: errorMsg);
}

class UnAuthorisedException extends AppExceptions {
  UnAuthorisedException({required String errorMsg}) : super(title: "Unauthorised: ", msg: errorMsg);
}

class InvalidException extends AppExceptions {
  InvalidException({required String errorMsg}) : super(title: "Invalid Input: ", msg: errorMsg);
}

class InvalidData extends AppExceptions {
  InvalidData({required String errorMsg}) : super(title: "Error: ", msg: errorMsg);
}