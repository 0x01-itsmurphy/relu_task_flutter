import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:relu_task_flutter/Retrofit/exceptions.dart';

class ApiHandler {
  final String _baseUrl = 'https://api.musixmatch.com/ws/1.1/';

  Future<dynamic> get(String url) async {
    var responseJson;
    print(Uri.parse(_baseUrl + url));
    try {
      final response = await http.get(Uri.parse(_baseUrl + url));
      responseJson = _response(response);
      print(responseJson);
    } on SocketException {
      throw FetchDataException('Error in communication');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body.toString());
        print(responseJson);
        return responseJson;

      case 400:
        throw BadRequestException(response.body.toString());

      case 403:
        throw UnauthorisedException(response.body.toString());

      default:
        throw FetchDataException(
            'Communication Error with StatusCode : ${response.statusCode}');
    }
  }
}
