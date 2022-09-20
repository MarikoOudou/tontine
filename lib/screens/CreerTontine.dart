import 'package:flutter/material.dart';
import 'package:tontino/models/Tontine.dart';
import 'package:tontino/screens/ContentVlider.dart';
import 'package:tontino/screens/home.dart';
import 'package:tontino/screens/login.dart';
import 'package:tontino/screens/mes_tontine/MesTontine.dart';
import 'package:tontino/services/Colors.dart';

class CreerTontine extends StatefulWidget {
  const CreerTontine({Key? key, required this.size}) : super(key: key);
  final Size size;

  @override
  _CreerTontineState createState() => _CreerTontineState();
}

class _CreerTontineState extends State<CreerTontine> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);
  List<String> textValidate = ["Le champs n'est pas correct", ""];
  final _formKey = GlobalKey<FormState>();

  List<String> label = [
    "Nom de la tontine",
  ];

  Map<String, dynamic> dataToSend = {};

  int valeurPeriode = 1;
  int valeurMontant = 1;
  int valeurType = 1;

  List<Map<String, dynamic>> periodes = [
    {
      "id": 1,
      "value": "Hebdomadaire",
      "createdAt": "2022-09-17T20:22:31+00:00",
      "updatedAt": "2022-09-17T20:22:31+00:00"
    },
    {
      "id": 2,
      "value": "Mensuelle",
      "createdAt": "2022-09-17T20:22:31+00:00",
      "updatedAt": "2022-09-17T20:22:31+00:00"
    },
    {
      "id": 3,
      "value": "Trimestrielle",
      "createdAt": "2022-09-17T20:22:31+00:00",
      "updatedAt": "2022-09-17T20:22:31+00:00"
    }
  ];

  List<Map<String, dynamic>> montants = [
    {
      "id": 1,
      "valeur": 1000,
      "createdAt": "2022-09-17T20:22:31+00:00",
      "updatedAt": "2022-09-17T20:22:31+00:00"
    },
    {
      "id": 2,
      "valeur": 2000,
      "createdAt": "2022-09-17T20:22:31+00:00",
      "updatedAt": "2022-09-17T20:22:31+00:00"
    },
    {
      "id": 3,
      "valeur": 5000,
      "createdAt": "2022-09-17T20:22:31+00:00",
      "updatedAt": "2022-09-17T20:22:31+00:00"
    }
  ];

  List<Map<String, dynamic>> types = [
    {"id": 1, "value": "Tontine avec intérêt"},
    {"id": 2, "value": "Tontine ordinaire"}
  ];
  bool error = false;
  bool create = false;
  bool loading = false;
  Tontine valueForm = Tontine();

  Map<String, dynamic> param = {};

  @override
  Widget build(BuildContext context) {
    dataToSend["type"] = valeurType;
    dataToSend["montant"] = valeurMontant;
    dataToSend["periodicite"] = valeurPeriode;

    Size size = MediaQuery.of(context).size;
    return loading
        ? SingleChildScrollView(
            child: Container(
            height: size.height,
            color: ColorTheme.primaryColorBlue,
            child: ContenteValidation(
              textBoutton: "",
              page: Home(),
              size: size,
              errorResp: 1,
              textValidate: "",
              loading: true,
            ),
          ))
        : error
            ? SingleChildScrollView(
                child: Container(
                height: size.height,
                color: ColorTheme.primaryColorBlue,
                child: ContenteValidation(
                  textBoutton: "RETOUR",
                  page: CreerTontine(
                    size: size,
                  ),
                  size: size,
                  errorResp: 1,
                  textValidate: "ERREUR DE CREATION DE LA TONTINE",
                  loading: false,
                ),
              ))
            : create
                ? SingleChildScrollView(
                    child: Container(
                    height: size.height,
                    color: ColorTheme.primaryColorBlue,
                    child: ContenteValidation(
                      textBoutton: "RETOUR",
                      page: Home(),
                      size: size,
                      errorResp: 0,
                      textValidate: "VOTRE TONTINE A ETE CREER",
                      loading: false,
                    ),
                  ))
                : Scaffold(
                    appBar: AppBar(
                      elevation: 0,
                      title: const Text(
                        'CREER UNE TONTINE',
                        textAlign: TextAlign.center,
                      ),
                      centerTitle: true,
                      titleTextStyle: TextStyle(fontSize: 18),
                    ),
                    body: SingleChildScrollView(
                        child: Container(
                      padding: EdgeInsets.all(20),
                      color: ColorTheme.primaryColorBlue,
                      height: (size.height - kToolbarHeight - 24),
                      width: size.width,
                      // alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(bottom: 15, top: 10),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return '${textValidate[0]}';
                                          }
                                          dataToSend["nom"] = value;
                                          return null;
                                        },
                                        autofocus: false,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 18,
                                            color: ColorTheme.primaryColorWhite,
                                            fontWeight: FontWeight.w700),
                                        decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10.0)),
                                                borderSide: BorderSide(
                                                  width: 2,
                                                  color: ColorTheme
                                                      .primaryColorYellow,
                                                )),
                                            contentPadding: EdgeInsets.all(10),
                                            filled: false,
                                            fillColor:
                                                ColorTheme.primaryColorYellow,
                                            focusColor:
                                                ColorTheme.primaryColorYellow,
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10.0)),
                                              borderSide: BorderSide(
                                                width: 2,
                                                color: ColorTheme
                                                    .primaryColorWhite,
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: ColorTheme
                                                        .primaryColorWhite),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10.0))),

                                            // labelText: label[0],
                                            label: Text("${label[0]}"),
                                            labelStyle: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize: 15,
                                                color: ColorTheme
                                                    .primaryColorWhite,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Periodicite",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "RobotoMono",
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            child: Divider(
                                              thickness: 1,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        height: 50,
                                        width: size.width,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: periodes.length,
                                          itemBuilder: ((context, index) {
                                            Map<String, dynamic> periode =
                                                periodes[index];
                                            return Card(
                                              color:
                                                  valeurPeriode == periode["id"]
                                                      ? ColorTheme
                                                          .primaryColorYellow
                                                          .shade400
                                                      : ColorTheme
                                                          .primaryColorBlue
                                                          .shade400,
                                              child: InkWell(
                                                onTap: (() {
                                                  setState(() {
                                                    valeurPeriode =
                                                        periode["id"];
                                                    dataToSend["periodicite"] =
                                                        valeurPeriode;
                                                  });
                                                }),
                                                child: Container(
                                                  width: size.width * 0.4,
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.all(5),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "${periode['value']}"
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: ColorTheme
                                                                .primaryColorWhite),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                        )),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Montant",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "RobotoMono",
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            child: Divider(
                                              thickness: 1,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        height: 50,
                                        width: size.width,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: montants.length,
                                          itemBuilder: ((context, index) {
                                            Map<String, dynamic> montant =
                                                montants[index];
                                            return Card(
                                              color:
                                                  valeurMontant == montant["id"]
                                                      ? ColorTheme
                                                          .primaryColorYellow
                                                          .shade400
                                                      : ColorTheme
                                                          .primaryColorBlue
                                                          .shade400,
                                              child: InkWell(
                                                onTap: (() {
                                                  setState(() {
                                                    valeurMontant =
                                                        montant["id"];
                                                    dataToSend["montant"] =
                                                        montant["id"];
                                                  });
                                                }),
                                                child: Container(
                                                  width: size.width * 0.4,
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.all(5),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "${montant['valeur']} FCFA",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: ColorTheme
                                                                .primaryColorWhite),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                        )),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Types",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "RobotoMono",
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            child: Divider(
                                              thickness: 1,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        height: 50,
                                        width: size.width,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: types.length,
                                          itemBuilder: ((context, index) {
                                            Map<String, dynamic> type =
                                                types[index];
                                            return Card(
                                              color: valeurType == type["id"]
                                                  ? ColorTheme
                                                      .primaryColorYellow
                                                      .shade400
                                                  : ColorTheme.primaryColorBlue
                                                      .shade400,
                                              child: InkWell(
                                                onTap: (() {
                                                  setState(() {
                                                    valeurType = type["id"];
                                                    dataToSend["type"] =
                                                        type["id"];
                                                  });
                                                }),
                                                child: Container(
                                                  width: size.width * 0.4,
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.all(5),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "${type['value']}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: ColorTheme
                                                                .primaryColorWhite),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                        )),
                                  ],
                                ),
                                Container(
                                    child: ElevatedButton(
                                        onPressed: (() async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              loading = true;
                                            });

                                            print("Data to send ${dataToSend}");

                                            setState(() {
                                              loading = true;
                                            });

                                            Map<String, dynamic> resp =
                                                await valueForm
                                                    .create(dataToSend);

                                            // print("loading true");
                                            print("REPONSE ${resp}");

                                            if (!resp["reponse"]) {
                                              // print("loading false");
                                              setState(() {
                                                loading = false;
                                                error = true;
                                              });
                                            } else {
                                              setState(() {
                                                loading = false;
                                                create = true;
                                              });
                                            }

                                            // Map<String, dynamic> resp =
                                            //     await valueForm.create(dataToSend);

                                            // showModalBottomSheet(
                                            //     backgroundColor: ColorTheme.primaryColorBlue,
                                            //     context: context,
                                            //     isDismissible: false,
                                            //     enableDrag: false,
                                            //     shape: const RoundedRectangleBorder(
                                            //       borderRadius: BorderRadius.vertical(
                                            //         top: Radius.circular(30.0),
                                            //       ),
                                            //     ),
                                            //     builder: (context) {
                                            //       print("DataSend      ${dataToSend}");

                                            //       return FutureBuilder(
                                            //           future: valueForm.create(dataToSend),
                                            //           builder: ((context, snapshot) {
                                            //             dynamic resp = snapshot.data;

                                            //             print("resp ....... ${resp}");

                                            //             if (resp == null) {
                                            //               return ContenteValidation(
                                            //                 textBoutton: "RETOUR AU MENU",
                                            //                 page: CreerTontine(size: size),
                                            //                 size: size,
                                            //                 errorResp: 1,
                                            //                 textValidate:
                                            //                     "VOUS ETES MEMBRE DE LA TONTINE",
                                            //                 loading: true,
                                            //               );
                                            //             } else if (resp["code"] >= 400) {
                                            //               return ContenteValidation(
                                            //                 textBoutton: "RETOUR",
                                            //                 page: CreerTontine(size: size),
                                            //                 size: size,
                                            //                 errorResp: 1,
                                            //                 textValidate:
                                            //                     "ERREUR DE CREATION",
                                            //                 loading: false,
                                            //               );
                                            //             }

                                            //             return ContenteValidation(
                                            //               textBoutton: "VOIR MES TONTINES",
                                            //               page: MesTontine(),
                                            //               size: size,
                                            //               errorResp: 0,
                                            //               textValidate:
                                            //                   "VOTRE TONTINE A ETE CREER AVEC SUCCES",
                                            //               loading: false,
                                            //             );
                                            //           }));
                                            //     });
                                          }
                                        }),
                                        child: Text(
                                          "Créer la tontine",
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: size.width * 0.04,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty
                                                    .all<Color>(ColorTheme
                                                        .primaryColorYellow),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.0),
                                                  side: BorderSide(
                                                      color: ColorTheme
                                                          .primaryColorYellow)),
                                            )))),
                              ],
                            ),
                          ),
                          param!["message"] != null
                              ? Container(
                                  width: size.width,
                                  height: 50,
                                  clipBehavior: Clip.hardEdge,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: ColorTheme.primaryColorYellow,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Center(
                                      child: Text(
                                    param["message"]!["text"],
                                    style: TextStyle(
                                        color: ColorTheme.primaryColorWhite,
                                        fontWeight: FontWeight.bold),
                                  )),
                                )
                              : Container(),
                        ],
                      ),
                    )),
                  );
  }
}
