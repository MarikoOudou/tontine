import 'package:flutter/material.dart';
import 'package:tontino/models/Tontine.dart';
import 'package:tontino/screens/mes_tontine/MesTontine.dart';
import 'package:tontino/screens/notification/notifications.dart';
import 'package:tontino/services/Colors.dart';

import '../../services/ServiceHttp.dart';
import '../ContentVlider.dart';

class MesContacts extends StatefulWidget {
  const MesContacts({Key? key, required this.tontine}) : super(key: key);

  final Tontine tontine;

  @override
  _MesContactsState createState() => _MesContactsState();
}

class _MesContactsState extends State<MesContacts> {
  Map<String, dynamic> dataMember = {};

  Tontine delectMember = Tontine();

  ServiceHttp serviceHttp = ServiceHttp();

  String telUser = "";
  getTel() async {
    return await serviceHttp.getTel();
  }

  RemoveMember(Map<String, dynamic> dataMember) async {
    return await delectMember.removeMember(dataMember);
  }

  final TextStyle textStyleTitle = TextStyle(
      color: Colors.white,
      fontFamily: "RobotoMono",
      fontSize: 16,
      fontWeight: FontWeight.w500);

  final TextStyle textStyleSub = TextStyle(
      color: ColorTheme.primaryColorYellow,
      fontFamily: "RobotoMono",
      fontSize: 14,
      fontWeight: FontWeight.w500);

  final TextStyle textStyleTrailling = TextStyle(
      color: Colors.white,
      fontFamily: "RobotoMono",
      fontSize: 16,
      fontWeight: FontWeight.w500);

  List<dynamic> dataTontins = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    dataTontins = widget.tontine.members!;
    print("Members .................................. : ${dataTontins}");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Les Membres'),
        centerTitle: true,
        // actions: [IconButton(onPressed: (() {}), icon: Icon(Icons.search))],
      ),
      body: FutureBuilder(
          future: getTel(),
          builder: ((context, snapshot) {
            telUser = snapshot.data.toString();

            if (snapshot.data == null) {
              return CircularProgressIndicator();
            }
            print(
                "CREATEUR DE LA TONTINE .................................. : ${telUser}");

            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(10),
                height: size.height * 0.9,
                child: Container(
                  width: size.width,
                  color: ColorTheme.primaryColorWhite[400],
                  margin: EdgeInsets.only(top: 0, bottom: 10),
                  child: ListView.builder(
                    itemCount: dataTontins.length,
                    itemBuilder: ((context, index) {
                      dynamic tontine = dataTontins[index];
                      return Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                            color: ColorTheme.primaryColorBlue,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                color: ColorTheme.primaryColorBlack
                                    .withOpacity(0.8),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset:
                                    Offset(0, 1), // changes position of shadow
                              ),
                            ]),
                        child: ListTile(
                          title: Text(
                            "${tontine["user"]["nom"]} ${tontine["user"]["prenom"]}",
                            style: textStyleTitle,
                          ),
                          subtitle: telUser == tontine["user"]["tel"]
                              ? Text(
                                  "Cr??ateur de la tontine",
                                  style: TextStyle(
                                      color: ColorTheme.primaryColorWhite),
                                )
                              : Text(
                                  "Participant",
                                  style: TextStyle(
                                      color: ColorTheme.primaryColorYellow),
                                ),
                          trailing: IconButton(
                              enableFeedback: telUser != tontine["user"]["tel"],
                              onPressed: telUser == tontine["user"]["tel"]
                                  ? null
                                  : (() {
                                      if (telUser == widget.tontine.createdBy) {
                                        setState(() {
                                          dataMember["tontine"] =
                                              widget.tontine.id;
                                          dataMember["tel"] =
                                              tontine["user"]["tel"];
                                        });

                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: const Text(
                                                "Suppression d'un membre"),
                                            content: const Text(
                                                'Vous voulez retir?? cette personne'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'Cancel'),
                                                child: const Text('Non'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  // Navigator.pop(context, 'Cancel');

                                                  showModalBottomSheet(
                                                      backgroundColor:
                                                          ColorTheme
                                                              .primaryColorBlue,
                                                      context: context,
                                                      isDismissible: false,
                                                      enableDrag: false,
                                                      shape:
                                                          const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .vertical(
                                                          top: Radius.circular(
                                                              30.0),
                                                        ),
                                                      ),
                                                      builder: (context) {
                                                        return FutureBuilder(
                                                            future:
                                                                RemoveMember({
                                                              "tontine":
                                                                  dataMember[
                                                                      "tontine"],
                                                              "tel": dataMember[
                                                                  "tel"]
                                                            }),
                                                            builder: ((context,
                                                                snapshot) {
                                                              print(snapshot
                                                                  .data);
                                                              dynamic cotise =
                                                                  snapshot.data;

                                                              if (cotise ==
                                                                  null) {
                                                                return ContenteValidation(
                                                                  textBoutton:
                                                                      "RETOUR",
                                                                  page: MesContacts(
                                                                      tontine:
                                                                          widget
                                                                              .tontine),
                                                                  size: size,
                                                                  errorResp: 1,
                                                                  textValidate:
                                                                      "",
                                                                  loading: true,
                                                                );
                                                              } else if (cotise[
                                                                      'code'] >=
                                                                  400) {
                                                                ContenteValidation(
                                                                  textBoutton:
                                                                      "RETOUR",
                                                                  page:
                                                                      MesTontine(),
                                                                  size: size,
                                                                  errorResp: 1,
                                                                  textValidate:
                                                                      "ERREUR",
                                                                  loading:
                                                                      false,
                                                                );
                                                              }

                                                              return ContenteValidation(
                                                                textBoutton:
                                                                    "RETOUR",
                                                                page:
                                                                    MesTontine(),
                                                                size: size,
                                                                errorResp: 0,
                                                                textValidate:
                                                                    "",
                                                                loading: false,
                                                              );
                                                            }));
                                                      });
                                                },
                                                child: const Text('Oui'),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return null;
                                      }
                                    }),
                              icon: telUser != tontine["user"]["tel"]
                                  ? Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )
                                  : Icon(
                                      Icons.delete,
                                      color: Colors.grey,
                                    )),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            );
          })),
    );
  }
}
