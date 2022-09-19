import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tontino/models/Tontine.dart';
import 'package:tontino/models/user.dart';
import 'package:tontino/screens/ContentVlider.dart';
import 'package:tontino/screens/home.dart';
import 'package:tontino/screens/loading.dart';
import 'package:tontino/screens/login.dart';
import 'package:tontino/services/Colors.dart';

class AddTontine extends StatefulWidget {
  const AddTontine({Key? key, required this.infoUseer, required this.idTontine})
      : super(key: key);

  final String infoUseer;
  final int idTontine;

  @override
  _AddTontineState createState() => _AddTontineState();
}

class _AddTontineState extends State<AddTontine> {
  dynamic convertData = {};

  String text = "Acceptez-vous d'integrer la tontine ?";
  Map<String, dynamic> dataSend = {};
  Tontine tontine = Tontine();
  User user = User();
  String tel =
      "{\"id\":3,\"nom\":\"asad\",\"montant\":1000,\"periodicite\":\"Hebdomadaire\",\"type\":\"Tontine avec intérêt\"}";

  addTontine(Map<String, dynamic> data) {
    return tontine!.addMember(data);
  }

  loadingUser() async {
    Map<String, dynamic> userget = await user.getUser();
    print("user info  ${userget}");

    if (userget["reponse"]) {
      user = User.fromJsonMap({
        "id": userget["data"]["id"],
        "nom": userget["data"]["nom"],
        "prenom": userget["data"]["prenom"],
        "tel": userget["data"]["tel"],
        "solde": userget["data"]["solde"]
      });
      return user;

      // loading = false;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("String ${widget.infoUseer.toString()}");
    print("jsonDecode ${jsonDecode(widget.infoUseer.toString())}");

    // int idTontine = (jsonDecode(widget.infoTontine.toString())["id"])!.toInt();
    dynamic userInfo = jsonDecode(widget.infoUseer.toString());

    return FutureBuilder(
        future: loadingUser(),
        builder: ((context, snapshot) {
          dynamic dataUser = snapshot.data;

          // print("USER INFO     ${dataUser}");

          if (dataUser == null) {
            return Loading();
          }

          text =
              "SOUHAITER VOUS INTEGRER ${userInfo['nom']} ${userInfo['prenom']} A VOTRE TONTINE ?";

          // if (dataUser.id == null) {
          //   return Login();
          //   // Navigator.pop(context);
          // }
          dataSend = {
            "tontine": widget.idTontine,
            "tel": userInfo['tel'],
          };

          return Scaffold(
              appBar: AppBar(
                title: const Text('Invitation a latontine'),
                centerTitle: true,
              ),
              body: Container(
                height: size.height - kToolbarHeight - 30,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: size.width,
                      // height: size.height - kToolbarHeight - 25,
                      padding: EdgeInsets.all(40),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                text,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      onPressed: (() {
                                        Navigator.pop(context);
                                      }),
                                      child: Text("NON")),
                                  ElevatedButton(
                                      onPressed: (() {
                                        showModalBottomSheet(
                                            backgroundColor:
                                                ColorTheme.primaryColorBlue,
                                            context: context,
                                            isDismissible: false,
                                            enableDrag: false,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                top: Radius.circular(30.0),
                                              ),
                                            ),
                                            builder: (context) {
                                              print(
                                                  "DataSend      ${dataSend}");

                                              return FutureBuilder(
                                                  future: addTontine(dataSend),
                                                  builder:
                                                      ((context, snapshot) {
                                                    dynamic cotise =
                                                        snapshot.data;

                                                    print(
                                                        "cotise ....... ${cotise}");

                                                    if (cotise == null ||
                                                        (cotise["reponse"] ==
                                                                null ||
                                                            cotise["reponse"] ==
                                                                false)) {
                                                      return ContenteValidation(
                                                        size: size,
                                                        errorResp: 1,
                                                        textValidate:
                                                            "VOUS ETES MEMBRE DE LA TONTINE",
                                                        loading: true,
                                                      );
                                                    }

                                                    if (cotise["access"] ==
                                                        false) {
                                                      return ContenteValidation(
                                                        size: size,
                                                        errorResp: 1,
                                                        textValidate:
                                                            cotise["message"],
                                                        loading: false,
                                                      );
                                                    }

                                                    return ContenteValidation(
                                                      size: size,
                                                      errorResp: 0,
                                                      textValidate:
                                                          "VOUS ETES MEMBRE DE LA TONTINE",
                                                      loading: false,
                                                    );
                                                  }));
                                            });
                                      }),
                                      child: Text("OUI")),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ));
        }));
  }
}
