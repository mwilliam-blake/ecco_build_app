class DataLoginRegModel {
  String? message;
  String? token;
  int? status;

  DataLoginRegModel({required this.message,
    required this.token,
    required this.status});

  factory DataLoginRegModel.fromJson(Map<String, dynamic> json) {
    return DataLoginRegModel(
        message: json['message'],
        token: json['token'],
        status: json['status']);
  }
}

class RegisterModel {
  List<dynamic>? Trades;
  List<dynamic>? Position;
  List<dynamic>? Client;

  RegisterModel({required this.Trades,required this.Position,required this.Client});

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
        Trades: json['Trades'],
        Position: json['Position'],
        Client: json['Client']);
  }
}