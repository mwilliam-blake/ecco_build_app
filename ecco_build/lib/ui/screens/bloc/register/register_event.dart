abstract class RegisterEvent {}

class RegisterUserEvent extends RegisterEvent {
  String? fname;
  String? lname;
  String? uname;
  String? mobNo;
  String? email;
  String? pTrade;
  String? sTrade;
  String? tTrade;
  String? position;
  String? client;
  String? notes;

  RegisterUserEvent({required this.fname,required this.lname,required this.uname,required this.mobNo,required this.email,required this.pTrade,required this.sTrade,required this.tTrade,required this.position,required this.client,required this.notes});
}