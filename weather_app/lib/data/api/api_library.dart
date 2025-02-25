import 'dart:convert';
import 'package:http/http.dart' as httpClient;

class ApiHelper {
  Future<dynamic> getApi({required String url}) async {
    var uri = Uri.parse(url);

    var res = await httpClient.get(uri);

    if(res.statusCode==200) {
      var mData = jsonDecode(res.body);
      return mData;
    }
    else {
      return null;
    }

  }

  Future<dynamic> postApi({required String url, Map<String, dynamic>? bodyParams}) async {
    var uri = Uri.parse(url);

    var res = await httpClient.post(uri, body: bodyParams ?? {});

    if(res.statusCode==200) {
      var mData = jsonDecode(res.body);
      return mData;
    }
    else {
      return null;
    }

  }
}