import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tontino/models/Tontine.dart';
import 'package:tontino/models/user.dart';
import 'package:tontino/screens/loading.dart';
import 'package:tontino/screens/mes_tontine/DetailTontine.dart';
import 'package:tontino/screens/notification/notifications.dart';
import 'package:tontino/services/Colors.dart';

class MesTontine extends StatefulWidget {
  const MesTontine({Key? key}) : super(key: key);

  @override
  _MesTontineState createState() => _MesTontineState();
}

class _MesTontineState extends State<MesTontine> {
  Tontine tontines = Tontine();
  List<Tontine> listTontine = [];
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

  List<Map<String, dynamic>> dataTontins = [];

  bool loading = true;

  loadingMyTontine() async {
    ModelReponse tontine = await tontines.mesTontine();

    print("tontine info  ${tontine.data}");

    listTontine = [];

    if (tontine.reponse) {
      (tontine.data as List).forEach((ton) {
        print(ton["id"]);
        listTontine.add(Tontine.fromJsonMap({
          "id": ton["id"],
          "nom": ton["nom"],
          "montant": ton["montant"],
          "solde": ton["solde"],
          "periodicite": ton["periodicite"],
          "createdBy": ton["createdBy"],
          "members": ton["members"],
          "type": ton["type"],
          "isActive": ton["isActive"],
          "avancement": ton["avancement"],
          "stateCotisation": ton["stateCotisation"],
          "compteur": ton["compteur"],
          "history": ton["history"],
        }));
      });

      return listTontine;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // loadingUser();
    // // print(dataTontins[0]["nom"]);
    // setState(() {
    //   if (listTontine == null || listTontine.length == 0) {
    //     loading = true;
    //   } else {
    //     loading = false;
    //   }
    // });
    return FutureBuilder(
        future: loadingMyTontine(),
        builder: ((context, snapshot) {
          if (snapshot.data == null) {
            return Container(
              color: ColorTheme.primaryColorBlue,
              child: Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: ColorTheme.primaryColorYellow,
                  size: 200,
                ),
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('Mes Tontines'),
              centerTitle: true,
              // actions: [
              //   IconButton(onPressed: (() {}), icon: Icon(Icons.search))
              // ],
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(10),
                height: size.height * 0.9,
                child: Container(
                  width: size.width,
                  color: ColorTheme.primaryColorWhite[400],
                  margin: EdgeInsets.only(top: 0, bottom: 10),
                  child: RefreshIndicator(
                    onRefresh: () {
                      return Future.delayed(Duration(seconds: 6));
                      // loadingUser();
                    },
                    child: ListView.builder(
                      itemCount:
                          listTontine.length != null ? listTontine.length : 0,
                      itemBuilder: ((context, index) {
                        Tontine tontine = listTontine[index];
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
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ]),
                          child: ListTile(
                            onTap: (() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => DetailTontine(
                                            objetTontine: tontine,
                                          ))));
                            }),
                            title: Text(
                              "${tontine.nom}",
                              style: textStyleTitle,
                            ),
                            subtitle: Text(
                              "${tontine.periodicite}",
                              style: textStyleSub,
                            ),
                            trailing: Column(
                              children: [
                                Container(
                                  child: Text(
                                    "${tontine.montant} FCFA",
                                    style: textStyleTrailling,
                                  ),
                                ),
                                Container(
                                  child: tontine.compteur == null ||
                                          tontine.compteur == 0
                                      ? Text(
                                          'Inactif',
                                          style: textStyleSub,
                                        )
                                      : Text("Actif",
                                          style: TextStyle(
                                              color:
                                                  ColorTheme.primaryColorWhite,
                                              fontFamily: "RobotoMono",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500)),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
