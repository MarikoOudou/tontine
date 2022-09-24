// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:tontino/services/ServiceHttp.dart';

class MomoService {
  final double? montant;
  MomoService({
    this.montant,
  });

  static String path = "";
  ServiceHttp serviceHttp = ServiceHttp();

  rechargement(int montant) async {
    path = "transaction/rechargement";
    Map<dynamic, dynamic?> data = {"montant": montant.toString()};

    http.Response response = await serviceHttp.postReqHttp(data, path);

    int code = response.statusCode;
    print("ERREUR DE SERVEUR ${code}");

    if (code != null && code >= 400) {
      return {
        "reponse": true,
        "code": code,
        "message": jsonDecode(response.body)['message']
      };
    } else {
      Map<dynamic, dynamic?> body = jsonDecode(response.body);

      print(body["message"]);
      return {"data": body, "reponse": true, "message": body["message"]};
    }
  }

  retrait(int montant) async {
    path = "transaction/retrait";
    Map<dynamic, dynamic?> data = {"montant": montant.toString()};

    http.Response response = await serviceHttp.postReqHttp(data, path);

    int code = response.statusCode;
    print("ERREUR DE SERVEUR ${code}");

    if (code != null && code >= 400) {
      return {
        "reponse": true,
        "code": code,
        "message": jsonDecode(response.body)['message']
      };
    } else {
      Map<dynamic, dynamic?> body = jsonDecode(response.body);

      print(body["message"]);
      return {"data": body, "reponse": true, "message": body["message"]};
    }
  }

  MomoService copyWith({
    double? montant,
  }) {
    return MomoService(
      montant: montant ?? this.montant,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'montant': montant,
    };
  }

  factory MomoService.fromMap(Map<String, dynamic> map) {
    return MomoService(
      montant: map['montant'] != null ? map['montant'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MomoService.fromJson(String source) =>
      MomoService.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MomoService(montant: $montant)';

  @override
  bool operator ==(covariant MomoService other) {
    if (identical(this, other)) return true;

    return other.montant == montant;
  }

  @override
  int get hashCode => montant.hashCode;
}
