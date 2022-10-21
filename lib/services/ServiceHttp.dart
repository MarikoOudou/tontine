import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ServiceHttp {
  String authorization = "Bearer ";
  String tel = "";

  // Obtain shared preferences.

  String url = "https://mtn-hackathon.herokuapp.com/api/";
  // Create storage
  setAuthorization(String token) async {
    authorization = "Bearer " + token;
    updateToken(authorization);
  }

  setTel(String? tel) async {
    this.tel = tel!;
    updateTel(tel);
  }

  ServiceHttp() {
// Read value
    // authorization = getToken();
    // print( "authorization ::::::::::::::::::::::::::::::::::::::: ${authorization}");
  }

  updateTel(String tel) async {
    print("SET TEL USER ========== ${tel}");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('tel', tel);
  }

  setUrlSse({url}) async {
    print("SET URL SSE ========== ${url}");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('sse_link', url);
  }

  updateToken(String authorization) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('authorization', authorization);
  }

  getUrlSse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Object? action = prefs.get('sse_link');
    return action;
  }

  getTel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Object? action = prefs.get('tel');
    return action;
  }

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Object? action = prefs.get('authorization');
    return action;
  }

  cleanAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // final bool action1 = await prefs.remove('tel');
    // final bool action2 = await prefs.remove('sse_link');
    // final bool action3 = await prefs.remove('authorization');
    final bool actionAll = await prefs.clear();
    // ('authorization');
    if (actionAll) {
      return true;
    } else {
      return false;
    }
  }

  cleanToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Object action = await prefs.remove('authorization');
    print("action $action");
    return action;
  }

  postReqHttpNotAuth(dynamic body, String path) async {
    //Pass headers below
    if ((await getToken()) != null) {
      authorization = await getToken();
    } else {
      print("PAS DE TOKEN =====================================");
    }

    // print(authorization);
    String url = this.url + path;
    print("DATA SEND                : ${body}");
    print("DATA SEND IN JSON        : ${json.encode(body)}");
    print("REQUETE DE TYPE POST URL : ${Uri.parse(url)}");

    return await http.post(
      Uri.parse(url),
      body: json.encode(body),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
      // encoding: encoding
    );
  }

  postReqHttp(dynamic body, String path) async {
    //Pass headers below
    if ((await getToken()) != null) {
      authorization = await getToken();
    } else {
      print("PAS DE TOKEN =====================================");
    }

    // print(authorization);
    String url = this.url + path;
    print("DATA SEND                : ${body}");
    print("DATA SEND IN JSON        : ${json.encode(body)}");
    print("REQUETE DE TYPE POST URL : ${Uri.parse(url)}");

    return await http.post(
      Uri.parse(url),
      body: json.encode(body),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": authorization
      },
      // encoding: encoding
    );
  }

  Future<http.Response> getReqHttp(String path) async {
    //Pass headers below
    // print("Authorization :::::  ${await getToken()}");
    if ((await getToken()) != null) {
      authorization = await getToken();
    } else {
      print("PAS DE TOKEN =====================================");
    }

    String url = this.url + path;

    print("URL : ${Uri.parse(url)}");
    return http
        .get(Uri.parse(url), headers: {"Authorization": authorization}).then(
            (http.Response response) {
      final int statusCode = response.statusCode;
      final dynamic json = response.body;
      print("====response ${response.body.toString()}");

      /*if (statusCode < 200 || statusCode >= 400 || json == null) {
        throw Exception(response.body);
      }*/
      return response;
    });
  }

  // dynamic _returnResponse(http.Response response) {
  //   String responseJson = response.body;
  //   final jsonResponse = jsonDecode(responseJson);
  //   switch (response.statusCode) {
  //     case 200:
  //       return jsonResponse;
  //     case 400:
  //       throw BadRequestException(
  //           jsonResponse['message'] ?? AppConstants.exceptionMessage);
  //     case 401:
  //       throw InvalidInputException(
  //           jsonResponse['message'] ?? AppConstants.exceptionMessage);
  //     case 403:
  //       throw UnauthorisedException(
  //           jsonResponse['message'] ?? AppConstants.exceptionMessage);
  //     case 404:
  //       throw FetchDataException(
  //           jsonResponse['message'] ?? AppConstants.exceptionMessage);
  //     case 500:
  //     default:
  //       throw FetchDataException(
  //           jsonResponse['message'] ?? AppConstants.exceptionMessage);
  //   }
  // }
}
