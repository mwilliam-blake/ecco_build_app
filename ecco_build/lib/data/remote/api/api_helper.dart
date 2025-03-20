import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'app_exception.dart';
class ApiHelper {

  Future<dynamic> getAPI({required String url}) async{
    var uri = Uri.parse(url);

    try {
      http.Response response = await http.get(uri);
      return returnJsonResponse(response);
    } on SocketException catch(e) {
      throw(FetchDataException(errorMsg: "No internet!!"));
    }
  }

  Future<dynamic> postAPI({required String url, Map<String, dynamic>? bodyParams}) async {
    var uri = Uri.parse(url);

    try {   ///jsonEncode
      http.Response response = await http.post(uri, body: bodyParams!=null?bodyParams:null);
      return returnJsonResponse(response);
    } on SocketException catch(e) {
      throw(FetchDataException(errorMsg: "No internet!!"));
    }
  }

  dynamic returnJsonResponse(http.Response response) {
    //print(response.statusCode);
    switch(response.statusCode) {
      case 200: {
        var data = jsonDecode(response.body);
        return data;
      }
       case 422: {
        var data = jsonDecode(response.body);
        throw InvalidData(errorMsg: data['message'].toString());
      }
      case 400: throw BadRequestException(errorMsg: response.body.toString());
      case 401:
      case 403: throw UnAuthorisedException(errorMsg: response.body.toString());
      case 500:
      default:
        throw FetchDataException(errorMsg: "error occurred while communication with server with Status code: ${response.statusCode}");
    }
  }

}