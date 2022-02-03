import 'dart:io';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

class ApiBaseHelper {
  final String _apiKey = "9b2fb7c1c9b14bcda149e7819e1203e8";
  static String baseUrl =
      "https://newsapi.org/v2/everything?q=tesla&from=2022-01-03&sortBy=publishedAt&apiKey=9b2fb7c1c9b14bcda149e7819e1203e8";

  Future<dynamic> get(String url) async {
    print('Api Get, url $url');
    dynamic responseJson;
    try {
      print(baseUrl + url);
      final response = await http.get(Uri.parse(baseUrl),
          headers: await getRequestHeaders());
      // print("response json${response.body}");
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
    }
    return responseJson;
  }

  // Future<String> del(String url, dynamic postParams) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String accessToken = prefs.getString("accessToken").toString();
  //   print("inside post method");
  //   print(postParams);
  //   final request = http.Request("DELETE", Uri.parse(baseUrl + url));
  //   request.headers.addAll(<String, String>{
  //     "Content-type": "application/json",
  //     'Authorization': 'Bearer ' + accessToken,
  //     "Accept": "application/json",
  //     "x-api-key": _apiKey,
  //     "language": "de"
  //   });
  //   request.body = jsonEncode(postParams);
  //   final response = await request.send();
  //   if (response.statusCode != 200) {
  //     return Future.error("error: status code ${response.statusCode}");
  //   }
  //   return await response.stream.bytesToString();
  // }

  Future<Map<String, String>> getRequestHeaders() async {
    Map<String, String> requestHeaders = {
      "Content-type": "application/json",
      "Accept": "application/json",
      "x-api-key": _apiKey,
      "language": "de"
    };
    print(getRequestHeaders);

    return requestHeaders;
  }

  dynamic _returnResponse(http.Response response) {
    print('statuscode ${response.statusCode}');
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 202:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
      // throw BadRequestException(response.body.toString());
      case 401:
        print("The response in 401$response");
        var responseJson = json.decode(response.body.toString());
        print("sdfjsgefuegyrfy$responseJson");
        return responseJson;
      case 403:
        print("The response in 403$response");
        var responseJson = json.decode(response.body.toString());
        print("sdfjsgefuegyrfy$responseJson");
        return responseJson;
      case 404:
        print("The response in 404$response");
        var responseJson = json.decode(response.body.toString());
        print("sdfjsgefuegyrfy$responseJson");
        return responseJson;
      // throw UnauthorisedException(response.body.toString());
      case 422:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 500:
      default:
        print(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
