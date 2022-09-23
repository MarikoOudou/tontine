import 'dart:convert';

import 'package:tontino/models/user.dart';
import 'package:tontino/services/ServiceHttp.dart';

import 'package:http/http.dart' as http;

class Tontine {
  final int? id;
  final int? compteur;
  final String? nom;
  final dynamic? montant;
  final dynamic periodicite;
  final dynamic createdBy;
  final dynamic avancement;
  final String? type;
  final bool? isActive;
  final bool? stateCotisation;

  final int? solde;

  final List<dynamic>? members;
  final List<dynamic>? history;

  Tontine({
    this.id,
    this.nom,
    this.compteur,
    this.isActive,
    this.montant,
    this.avancement,
    this.stateCotisation,
    this.periodicite,
    this.createdBy,
    this.type,
    this.solde,
    this.members,
    this.history,
  });

  static String pathGetTontine = "";
  ServiceHttp serviceHttp = ServiceHttp();

  Tontine.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"] as int,
        nom = map["nom"],
        montant = map["montant"],
        periodicite = map["periodicite"],
        createdBy = map["createdBy"],
        history = map["history"],
        type = map["type"],
        solde = map["solde"],
        stateCotisation = map["stateCotisation"],
        avancement = map["avancement"],
        isActive = map["isActive"],
        compteur = map["compteur"],
        members = map["members"];

  Map<String, dynamic> toJsonMap() => {
        "id": id,
        "nom": nom,
        "montant": montant,
        "periodicite": periodicite,
        "createdBy": createdBy,
        "type": type
      };

  Future<Map<String, dynamic>> mesTontine() async {
    pathGetTontine = "tontine/my-tontines";
    // return User.fromJsonMap(await serviceHttp.getReqHttp(pathGetUser));

    http.Response response = await serviceHttp.getReqHttp(pathGetTontine);

    int code = response.statusCode;

    print("ERREUR DE SERVEUR ${code}");

    if (code != null && code >= 400) {
      return {"reponse": false, "message": "erreur du serveur"};
    } else {
      dynamic body = jsonDecode(response.body);

      print(body);
      return {"data": body, "reponse": true};
    }
  }

  Future<Map<String, dynamic>> activeTontine(String id_tontine) async {
    pathGetTontine = "tontine/activate/" + id_tontine;
    // return User.fromJsonMap(await serviceHttp.getReqHttp(pathGetUser));

    http.Response response = await serviceHttp.getReqHttp(pathGetTontine);

    int code = response.statusCode;

    print("ERREUR DE SERVEUR ${code}");

    if (code != null && code >= 400) {
      return {"reponse": false, "message": "erreur du serveur"};
    } else {
      dynamic body = jsonDecode(response.body);

      print(body);
      return {"data": body, "reponse": true, "code": code};
    }
  }

  create(Map<String, dynamic> data) async {
    pathGetTontine = "tontine/create";

    Map<dynamic, dynamic?> tontine = {
      "nom": data["nom"],
      "periodicite": data["periodicite"],
      "type": data["type"],
      "montant": data["montant"]
    };

    http.Response response =
        await serviceHttp.postReqHttp(tontine, pathGetTontine);
    int code = response.statusCode;
    Map<dynamic, dynamic?> body = jsonDecode(response.body);

    print("TONTINE CREER CODE ::::::: ${response.statusCode}");
    print("TONTINE  BODY ::::::: ${jsonDecode(response.body)}");

    if (code != null && code >= 400) {
      return {
        "reponse": true,
        "message": "ECHEC DE CREATION DE TONTINE",
        "code": code,
        "body": body,
      };
    } else if (code == null) {
      return {
        "reponse": true,
        "body": body,
        "message":
            "ERREUR DE DE CONNEXION, VEUILLEZ VERIFIER VOTRE CONNEXION INTERNET",
        "code": 100
      };
    } else {
      return {
        "data": body,
        "message": "VOTRE TONTINE A ETE CREE",
        "reponse": true,
        "code": code
      };
    }
  }

  Future<Map<String, dynamic>> cotisation(Map<String, dynamic> data) async {
    pathGetTontine = "transaction/tontine/cotisation";

    Map<dynamic, dynamic?> tontine = {
      "idTontine": data["idTontine"],
      "montant": data["montant"]
    };
    // Map<dynamic, dynamic?> response = await serviceHttp.postReqHttp(user, pathGetUser);

    http.Response response =
        await serviceHttp.postReqHttp(tontine, pathGetTontine);

    int code = response.statusCode;
    Map<dynamic, dynamic?> body = jsonDecode(response.body);

    print("COTISATION CREER CODE ::::::: ${response.statusCode}");
    print("COTISATION  BODY ::::::: ${jsonDecode(response.body)}");

    if (code != null && code >= 400) {
      return {
        "reponse": true,
        "message": "ECHEC",
        "code": code,
        "body": body,
      };
    } else if (code == null) {
      return {
        "reponse": true,
        "body": body,
        "message":
            "ERREUR DE DE CONNEXION, VEUILLEZ VERIFIER VOTRE CONNEXION INTERNET",
        "code": 100
      };
    } else {
      return {
        "data": body,
        "message": "SUCCESS",
        "reponse": true,
        "code": code
      };
    }
  }

  Future<Map<String, dynamic>> removeMember(Map<String, dynamic> data) async {
    pathGetTontine = "tontine/remove-member";

    Map<dynamic, dynamic?> tontine = {
      "tontine": data["tontine"],
      "tel": data["tel"]
    };
    // Map<dynamic, dynamic?> response = await serviceHttp.postReqHttp(user, pathGetUser);

    http.Response response =
        await serviceHttp.postReqHttp(tontine, pathGetTontine);

    int code = response.statusCode;
    print("ERREUR DE SERVEUR ${code}");

    if (code != null && code >= 400) {
      return {"reponse": false, "message": "erreur du serveur"};
    } else {
      Map<dynamic, dynamic?> body = jsonDecode(response.body);

      print(
          ' --------------------------------------------------------------------------- ${body["message"]}');
      return {"data": body, "reponse": true};
    }
  }

  Future<Map<String, dynamic>> addMember(Map<String, dynamic> data) async {
    pathGetTontine = "tontine/add-member";

    Map<dynamic, dynamic?> tontine = {
      "tontine": data["tontine"],
      "tel": data["tel"]
    };
    // Map<dynamic, dynamic?> response = await serviceHttp.postReqHttp(user, pathGetUser);

    http.Response response =
        await serviceHttp.postReqHttp(tontine, pathGetTontine);

    int code = response.statusCode;
    print("REPONSE DE SERVEUR ${response.body}");

    Map<dynamic, dynamic?> body = jsonDecode(response.body);
    if (body["code"] == null) {
      return {
        "data": body,
        "reponse": true,
        "code": code,
        "access": true,
        "message": "VOUS AVEZ AJOUTER UN MEMBRE A VOTRE TONTINE"
      };
    }

    if (code != null && code >= 400) {
      return {"reponse": true, "message": "erreur du serveur", "code": code};
    } else {
      Map<dynamic, dynamic?> body = jsonDecode(response.body);

      print(
          ' --------------------------------------------------------------------------- ${body["message"]}');
      return {
        "data": body,
        "reponse": true,
        "message": "VOUS AVEZ AJOUTER UN MEMBRE A VOTRE TONTINE",
        "code": code
      };
    }
  }
}
