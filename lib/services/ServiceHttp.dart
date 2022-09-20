import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ServiceHttp {
  String authorization = "Bearer ";

  // Obtain shared preferences.

  String url = "https://mtn-hackathon.herokuapp.com/api/";
  // Create storage
  setAuthorization(String token) async {
    authorization = "Bearer " + token;

    print(authorization);
    updateToken(authorization);
  }

  ServiceHttp() {
// Read value
    // authorization = getToken();
    // print( "authorization ::::::::::::::::::::::::::::::::::::::: ${authorization}");
  }

  updateToken(String authorization) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('authorization', authorization);
  }

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Object? action = prefs.get('authorization');
    return action;
  }

  cleanToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Object action = await prefs.remove('authorization');
    return action;
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
}
