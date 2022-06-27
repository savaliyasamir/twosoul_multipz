import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:twosoul_multipz/Network/api/custom_exception.dart';
import 'package:twosoul_multipz/main.dart';
import 'package:twosoul_multipz/ui/upload_image_screen.dart';
import 'package:twosoul_multipz/utils/constants.dart';


class ApiProvider {

  Future<dynamic> get(String url) async {
    var responseJson;
    var response;
    try {
      response = await http.get(Uri.parse(baseUrl + url), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });
      print(url);

      responseJson = _response(response);
    } on SocketException {
      throw NoInternetException("No Internet Connection!");
    }
    return responseJson;
  }



  Future<dynamic> tokenWithGet(String url) async {
    var responseJson;
    var response;
    var token = getStorage.read('LoginToken');
    try {
    response = await http.get(Uri.parse(baseUrl + url), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "Authorization": "Bearer " +token,
      });
      print(url);

      responseJson = _response(response);
    } on SocketException {
      throw NoInternetException("No Internet Connection!");
    }
    return responseJson;
  }


  Future<dynamic> post(String url, {var body}) async {
    var responseJson;
    var response;

    try {
        response = await http.post(
          Uri.parse(baseUrl + url),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
          body: jsonEncode(body),
        );
      responseJson = _response(response);

    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
  Future<dynamic> tokenWithPost(String url, {var body}) async {
    var responseJson;
    var response;
    var token =  getStorage.read('LoginToken');
    try {
        response = await http.post(
          Uri.parse(baseUrl + url),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            "Authorization": "Bearer " +token,
          },
          body: jsonEncode(body),
        );
        responseJson = _response(response);
      print(responseJson);

    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> multipartPost(String url) async {
    var responseJson;
    try {
      var token = getStorage.read('LoginToken');
      Map<String, String> headers = {"Authorization": "Bearer " + token,'Content-Type': 'application/json','Accept' : 'application/json'};
      var requestImage = http.MultipartRequest(
        'POST',
        Uri.parse(
          baseUrl + url,
        ),
      );
      requestImage.headers.addAll(headers);
      for (var element in finalImageList) {
        requestImage.files.add(element);
      }
      final streamedResponse = await requestImage.send();
      final response = await http.Response.fromStream(streamedResponse);

      responseJson = _response(response);
      print(requestImage);
    } on SocketException {
      throw NoInternetException( "No Internet Connection!" );
    }
    return responseJson;
  }


  dynamic _response(http.Response response) {

    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());

        return responseJson;
      case 201:
      case 204:
        var responseJson = json.decode(response.body.toString());

        return responseJson;
      case 400:
        var responseJson = json.decode(response.body.toString());
        var msg = responseJson["message"];
        return responseJson;
      case 302:
      case 401:
        throw UnauthorisedException("Something went wrong");
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 412:
        var responseJson = json.decode(response.body.toString());
        return UnauthorisedException(responseJson);

      case  500:
        var responseJson = json.decode(response.body.toString());
        var error = responseJson["errors"] ?? "";

        throw BadRequestException(response.body.toString());
      case 422:
        var responseJson = json.decode(response.body.toString());
        var msg = responseJson["message"];
        throw BadRequestException(msg);
      default:
        throw FetchDataException('Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

}