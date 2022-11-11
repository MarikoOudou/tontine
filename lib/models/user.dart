import 'dart:convert';
import 'dart:io';

import 'package:tontino/models/Tontine.dart';
import 'package:tontino/services/ServiceHttp.dart';

import 'package:http/http.dart' as http;

class User {
  int? id;
  String? username;
  String? nom;
  String? prenom;
  String? sse_link;
  String? slug;
  String? tel;
  double? solde;
  String? password;
  static String pathGetUser = "user";
  ServiceHttp serviceHttp = ServiceHttp();

  User({
    this.id,
    this.slug,
    this.username,
    this.sse_link,
    this.nom,
    this.prenom,
    this.tel,
    this.solde,
    this.password,
  });

  deconnexion() async {
    return await serviceHttp.cleanAll();
  }

  Future<ModelReponse> getUser() async {
    pathGetUser = "user/infos";
    // return User.fromJsonMap(await serviceHttp.getReqHttp(pathGetUser));

    http.Response response = await serviceHttp.getReqHttp(pathGetUser);

    int code = response.statusCode;

    print("ERREUR DE SERVEUR ${code}");

    if (code != null && code >= 400) {
      // Map<dynamic, dynamic?> body = jsonDecode(response.body);
      // print(body);
      dynamic body = User.fromJsonMap(jsonDecode(response.body));

      return ModelReponse(
          message: "info user",
          reponse: false,
          code: code,
          data: body,
          body: body);
    } else {
      User _user = User();

      User body = User.fromJsonMap(jsonDecode(response.body));

      // ServiceHttp().setUrlSse(url: body.sse_link);

      // User.j(map)
      print(body.id);

      serviceHttp.setTel(body.tel);

      return ModelReponse(
          message: "info user",
          reponse: true,
          code: code,
          data: body,
          body: body);
    }
  }

  Future<Map<String, dynamic>> getTransactionById(
      dynamic id_transaction) async {
    pathGetUser = "transaction/card/$id_transaction";
    // return User.fromJsonMap(await serviceHttp.getReqHttp(pathGetUser));

    http.Response response = await serviceHttp.getReqHttp(pathGetUser);

    int code = response.statusCode;

    print("ERREUR DE SERVEUR ${code}");

    if (code != null && code >= 400) {
      // Map<dynamic, dynamic?> body = jsonDecode(response.body);
      print(jsonDecode(response.body));
      return {
        "reponse": false,
        "message": "erreur du serveur",
        "message_serveur": jsonDecode(response.body)['message']
      };
    } else {
      Map<dynamic, dynamic?> body = jsonDecode(response.body);
      print(body);
      return {"data": body, "reponse": true, "code": code};
    }
  }

  Future<Map<String, dynamic>> historique() async {
    pathGetUser = "user/transactions";
    // return User.fromJsonMap(await serviceHttp.getReqHttp(pathGetUser));

    http.Response response = await serviceHttp.getReqHttp(pathGetUser);

    int code = response.statusCode;

    print("ERREUR DE SERVEUR ${code}");

    if (code != null && code >= 400) {
      return {"reponse": false, "message": "erreur du serveur", "code": code};
    } else {
      dynamic body = jsonDecode(response.body);

      print(body);
      return {"data": body, "reponse": true, "code": code};
    }
  }

  create() async {
    pathGetUser = "public/register";
    Map<dynamic, dynamic?> user = {
      "username": "${nom}_${prenom}",
      "nom": nom,
      "prenom": prenom,
      "tel": tel,
      "password": password
    };

    http.Response response =
        await serviceHttp.postReqHttpNotAuth(user, pathGetUser);

    int code = response.statusCode;
    print("ERREUR DE SERVEUR ${code}");

    if (code != null && code >= 400) {
      return {
        "reponse": false,
        "message": "erreur du serveur",
        "responseServeur": jsonDecode(response.body)
      };
    } else {
      Map<dynamic, dynamic?> body = jsonDecode(response.body);

      print(body["message"]);
      return {"data": body, "reponse": true};
    }
  }

  Future<Map<String, dynamic>> login(
      {String? telephone, String? motDpass}) async {
    pathGetUser = "login_check";
    // dynamic user = User(username: username, password: password).toJsonMap();

    var DataSend;

    if (telephone != null && motDpass != null) {
      DataSend = {"username": telephone, "password": motDpass};
    } else {
      DataSend = {"username": username, "password": password};
    }

    http.Response response =
        await serviceHttp.postReqHttp(DataSend, pathGetUser);

    int code = response.statusCode;

    if (code != null && code >= 400) {
      print("ERREUR DE SERVEUR");
      Map<dynamic, dynamic?> body = jsonDecode(response.body);
      print(body);
      return {"reponse": false, "message": "erreur du serveur", "code": code};
    } else {
      Map<dynamic, dynamic?> body = jsonDecode(response.body);

      serviceHttp.setAuthorization(body["token"]);
      print(body["token"]);
      return {"data": body, "reponse": true, "code": code};
    }
  }

  Future<Map<String, dynamic>> transfert(Map<String, dynamic> transfert) async {
    pathGetUser = "transaction/transfert";
    http.Response response =
        await serviceHttp.postReqHttp(transfert, pathGetUser);

    int code = response.statusCode;

    if (code != null && code >= 400) {
      print("ERREUR DE SERVEUR");
      return {"reponse": false, "message": "erreur du serveur"};
    } else {
      Map<dynamic, dynamic?> body = jsonDecode(response.body);

      return {"data": body, "reponse": true};
    }
  }

  User.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"] as int,
        username = map["username"],
        sse_link = map["sse_link"],
        nom = map["nom"],
        prenom = map["prenom"],
        slug = map["slug"],
        tel = map["tel"],
        solde = map["solde"] == null ? 0.0 : map["solde"].toDouble(),
        password = map["password"];

  Map<String, dynamic> toJsonMap() => {
        "id": id,
        "username": username,
        "sse_link": sse_link,
        "nom": nom,
        "prenom": prenom,
        "tel": tel,
        "password": password,
        "slug": slug,
      };
}
