import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tontino/models/Tontine.dart';
import 'package:tontino/screens/CodeQr.dart';
import 'package:tontino/screens/ContentVlider.dart';
import 'package:tontino/screens/CreerTontine.dart';
import 'package:tontino/screens/ScreenQrcode.dart';
import 'package:tontino/screens/home.dart';
import 'package:tontino/screens/mes_tontine/Depot.dart';
import 'package:tontino/screens/mes_tontine/MesContacts.dart';
import 'package:tontino/screens/mes_tontine/MesTontine.dart';
import 'package:tontino/screens/mes_tontine/retardPaye.dart';
import 'package:tontino/screens/mes_tontine/tchatTontine.dart';
import 'package:tontino/screens/notification/notifications.dart';
import 'package:tontino/services/Colors.dart';

class DetailTontine extends StatefulWidget {
  const DetailTontine({Key? key, required this.objetTontine}) : super(key: key);
  final Tontine objetTontine;

  @override
  _DetailTontineState createState() => _DetailTontineState();
}

class _DetailTontineState extends State<DetailTontine> {
  // menu: ajouter une personne; tchat; scanner le qrcod
  // historique des trqnsaction
  // nom de la tontine
  // montant a verser
  // periode

  bool error = false;
  bool create = false;
  bool loading = false;

  String qrcodeEnco = "";

  static const TextStyle optionStyle =
      TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white);
  static Tontine dataToSend = Tontine();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(widget.objetTontine.toJsonMap());
    qrcodeEnco = jsonEncode(jsonEncode((widget.objetTontine.toJsonMap())));

    List<Widget> buttonMenu = widget.objetTontine.compteur != 0
        ? [
            InkWell(
              splashColor: Colors.grey,
              onTap: (() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => MesContacts(
                              tontine: widget.objetTontine,
                            ))));
              }),
              child: Container(
                width: 70,
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff004f71),
                              Color(0xffffc304),
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          )),
                      child: Icon(
                        Icons.list_rounded,
                        // size: 40,
                        color: Colors.white,
                      ),
                    ),
                    Text("Membres",
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: ColorTheme.primaryColorWhite,
                            fontFamily: "RobotoMono",
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            InkWell(
              splashColor: Colors.grey,
              onTap: (() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => RetardPaye(
                              tontine: widget.objetTontine,
                            ))));
              }),
              child: Container(
                width: 70,
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff004f71),
                              Color(0xffffc304),
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          )),
                      child: Icon(
                        Icons.list_rounded,
                        // size: 40,
                        color: Colors.white,
                      ),
                    ),
                    Text("Rétard",
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: ColorTheme.primaryColorWhite,
                            fontFamily: "RobotoMono",
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            // InkWell(
            //   splashColor: Colors.grey,
            //   onTap: (() {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: ((context) => TchatTontine(
            //                   id_tontine: (widget.objetTontine.id),
            //                   size: size,
            //                 ))));
            //   }),
            //   child: Container(
            //     width: 70,
            //     child: Column(
            //       children: [
            //         Container(
            //           height: 40,
            //           width: 40,
            //           padding: EdgeInsets.all(5),
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(10),
            //               gradient: LinearGradient(
            //                 colors: [
            //                   Color(0xff004f71),
            //                   Color(0xffffc304),
            //                 ],
            //                 begin: Alignment.bottomLeft,
            //                 end: Alignment.topRight,
            //               )),
            //           child: Icon(
            //             Icons.chat_sharp,
            //             // size: 40,
            //             color: Colors.white,
            //           ),
            //         ),
            //         Text("Chat",
            //             style: TextStyle(
            //                 color: ColorTheme.primaryColorWhite,
            //                 fontFamily: "RobotoMono",
            //                 fontSize: 15,
            //                 fontWeight: FontWeight.bold)),
            //       ],
            //     ),
            //   ),
            // ),

            InkWell(
              splashColor: Colors.grey,
              onTap: (() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => Depot(
                              tontine: widget.objetTontine,
                            ))));
              }),
              child: Container(
                width: 70,
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff004f71),
                              Color(0xffffc304),
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          )),
                      child: Icon(
                        Icons.send,
                        // size: 40,
                        color: Colors.white,
                      ),
                    ),
                    Text("Cotisation",
                        style: TextStyle(
                            color: ColorTheme.primaryColorWhite,
                            fontFamily: "RobotoMono",
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ]
        : [
            InkWell(
              splashColor: Colors.grey,
              onTap: (() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => MesContacts(
                              tontine: widget.objetTontine,
                            ))));
              }),
              child: Container(
                width: 70,
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff004f71),
                              Color(0xffffc304),
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          )),
                      child: Icon(
                        Icons.list_rounded,
                        // size: 40,
                        color: Colors.white,
                      ),
                    ),
                    Text("Membres",
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: ColorTheme.primaryColorWhite,
                            fontFamily: "RobotoMono",
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            InkWell(
              splashColor: Colors.grey,
              onTap: (() {
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return ScreenQrcode(
                    typeScanner: 1,
                    idTontine: widget.objetTontine.id,
                  );
                })));
              }),
              child: Container(
                width: 70,
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff004f71),
                              Color(0xffffc304),
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          )),
                      child: Icon(
                        Icons.qr_code_scanner_rounded,
                        // size: 40,
                        color: Colors.white,
                      ),
                    ),
                    Text("Inviter",
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: ColorTheme.primaryColorWhite,
                            fontFamily: "RobotoMono",
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ];

    return loading
        ? SingleChildScrollView(
            child: Container(
            height: size.height,
            color: ColorTheme.primaryColorBlue,
            child: ContenteValidation(
              textBoutton: "",
              page: DetailTontine(
                objetTontine: widget.objetTontine,
              ),
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
                  page: DetailTontine(
                    objetTontine: widget.objetTontine,
                  ),
                  size: size,
                  errorResp: 1,
                  textValidate: "ERREUR",
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
                      textValidate: "VOTRE TONTINE A COMMENCER",
                      loading: false,
                    ),
                  ))
                : Scaffold(
                    appBar: AppBar(
                      elevation: 0,
                      title: Container(
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${widget.objetTontine.nom}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "RobotoMono",
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "créer par : ${widget.objetTontine.createdBy}",
                                  style: TextStyle(
                                      color: ColorTheme.primaryColorYellow,
                                      fontFamily: "RobotoMono",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    body: Stack(
                      children: [
                        SingleChildScrollView(
                          child: Container(
                            width: size.width,
                            height: size.height - kToolbarHeight - 25,
                            color: ColorTheme.primaryColorWhite[400],
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 15),
                                  height: (size.height - kToolbarHeight - 25) *
                                      0.25,
                                  padding: EdgeInsets.all(10),
                                  // width: size.width,
                                  decoration: BoxDecoration(
                                    color: ColorTheme.primaryColorBlue,
                                    // gradient: LinearGradient(
                                    //   colors: [Color(0xff004f71), Color(0xffffc304)],
                                    //   begin: Alignment.bottomLeft,
                                    //   end: Alignment.topRight,
                                    // ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: ColorTheme.primaryColorBlack
                                            .withOpacity(0.8),
                                        spreadRadius: 2,
                                        blurRadius: 4,
                                        offset: Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                    // color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          height: ((size.height -
                                                      kToolbarHeight -
                                                      25) *
                                                  0.25) *
                                              0.8,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                        "SOLDE DE LA TONTINE"
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                "RobotoMono",
                                                            fontSize:
                                                                size.width *
                                                                    0.045,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    Text(
                                                        "${widget.objetTontine!.solde} FCFA",
                                                        style: TextStyle(
                                                            color: ColorTheme
                                                                .primaryColorYellow,
                                                            fontFamily:
                                                                "RobotoMono",
                                                            fontSize:
                                                                size.width *
                                                                    0.042,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                      "Somme Cotiser"
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily:
                                                              "RobotoMono",
                                                          fontSize: size.width *
                                                              0.036,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text(
                                                      "${widget.objetTontine.solde} FCFA",
                                                      style: TextStyle(
                                                          color: ColorTheme
                                                              .primaryColorYellow,
                                                          fontFamily:
                                                              "RobotoMono",
                                                          fontSize: size.width *
                                                              0.036,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                      "Progression de la tontine"
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily:
                                                              "RobotoMono",
                                                          fontSize: size.width *
                                                              0.036,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text(
                                                      widget.objetTontine!
                                                                  .avancement ==
                                                              null
                                                          ? "${widget.objetTontine!.avancement!['pourcentage']!.toInt()} %"
                                                          : "0 %",
                                                      style: TextStyle(
                                                          color: ColorTheme
                                                              .primaryColorYellow,
                                                          fontFamily:
                                                              "RobotoMono",
                                                          fontSize: size.width *
                                                              0.036,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                            ],
                                          )
                                          // InkWell(
                                          //   onTap: (() {
                                          //     getCODEQR(context, size, qrcodeEnco);
                                          //   }),
                                          //   child: CodeQr(
                                          //     size: size,
                                          //     dataQR: qrcodeEnco,
                                          //     sizeQRCODE: ((size.height * 0.26) * 0.6) * 0.8,
                                          //     foregroundColor: ColorTheme.primaryColorWhite,
                                          //   ),
                                          // )
                                          ),
                                      // Container(
                                      //   alignment: Alignment.center,
                                      //   child: Column(
                                      //     children: [
                                      //       Text("Solde",
                                      //           textAlign: TextAlign.start,
                                      //           style: TextStyle(
                                      //               color: Colors.white,
                                      //               fontFamily: "RobotoMono",
                                      //               fontSize: 15,
                                      //               fontWeight: FontWeight.bold)),
                                      //       Text("${widget.objetTontine.solde} FCFA",
                                      //           style: TextStyle(
                                      //               color: Colors.white,
                                      //               fontFamily: "RobotoMono",
                                      //               fontSize: 15,
                                      //               fontWeight: FontWeight.bold)),
                                      //     ],
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: ((size.height - kToolbarHeight - 25) *
                                          0.28) *
                                      0.9,
                                  margin: EdgeInsets.only(bottom: 15),
                                  padding: EdgeInsets.all(10),
                                  width: size.width,
                                  decoration: BoxDecoration(
                                      color: ColorTheme.primaryColorBlue,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorTheme.primaryColorBlack
                                              .withOpacity(0.8),
                                          spreadRadius: 2,
                                          blurRadius: 4,
                                          offset: Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ]),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Menu",
                                        style: TextStyle(
                                            color: ColorTheme.primaryColorWhite,
                                            fontFamily: "RobotoMono",
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        child: Divider(
                                          thickness: 1,
                                          color: ColorTheme.primaryColorYellow,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: buttonMenu,
                                      )
                                    ],
                                  ),
                                ),
                                widget.objetTontine.compteur == 1
                                    ? SafeArea(
                                        child: Column(
                                          children: [
                                            Container(
                                              height: ((size.height -
                                                      kToolbarHeight -
                                                      25) *
                                                  0.4),
                                              width: size.width,
                                              decoration: BoxDecoration(
                                                  color: ColorTheme
                                                      .primaryColorBlue,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: ColorTheme
                                                          .primaryColorBlack
                                                          .withOpacity(0.8),
                                                      spreadRadius: 2,
                                                      blurRadius: 4,
                                                      offset: Offset(0,
                                                          1), // changes position of shadow
                                                    ),
                                                  ]),
                                              padding: EdgeInsets.all(10),
                                              margin: EdgeInsets.only(top: 0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Historique des transactions",
                                                    style: TextStyle(
                                                        color: ColorTheme
                                                            .primaryColorWhite,
                                                        fontFamily:
                                                            "RobotoMono",
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Container(
                                                    child: Divider(
                                                      thickness: 1,
                                                      color: ColorTheme
                                                          .primaryColorYellow,
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: SizedBox(
                                                    child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemCount: (widget
                                                                    .objetTontine
                                                                    .history) ==
                                                                null
                                                            ? 0
                                                            : (widget
                                                                    .objetTontine
                                                                    .history)!
                                                                .length,
                                                        itemBuilder:
                                                            ((context, index) {
                                                          Map<String, dynamic>
                                                              history =
                                                              widget.objetTontine
                                                                      .history![
                                                                  index];
                                                          return ListTile(
                                                            leading: Container(
                                                              height: 40,
                                                              width: 40,
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5),
                                                              decoration:
                                                                  BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      gradient:
                                                                          LinearGradient(
                                                                        colors: [
                                                                          Color(
                                                                              0xff004f71),
                                                                          Color(
                                                                              0xffffc304)
                                                                        ],
                                                                        begin: Alignment
                                                                            .bottomLeft,
                                                                        end: Alignment
                                                                            .topRight,
                                                                      )),
                                                              child: Icon(
                                                                Icons.send,
                                                                // size: 40,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            title: Text(
                                                              history["type"] ==
                                                                      "tontine_cotisation"
                                                                  ? "Cotisation Tontine"
                                                                  : "Autre",
                                                              style:
                                                                  optionStyle,
                                                            ),
                                                            // subtitle: Text( "Type de Transaction",
                                                            //   style: TextStyle(
                                                            //       color: ColorTheme.primaryColorYellow,
                                                            //       fontFamily: "RobotoMono",
                                                            //       fontSize: 12,
                                                            //       fontWeight: FontWeight.w500),
                                                            // ),
                                                            trailing: Text(
                                                              "${history['montant']} FCFA",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          );
                                                        })),
                                                  )),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    : Expanded(
                                        child: Container(
                                          child: Center(
                                            child: ElevatedButton(
                                                onPressed: (() async {
                                                  setState(() {
                                                    loading = true;
                                                  });

                                                  setState(() {
                                                    loading = true;
                                                  });

                                                  Map<String, dynamic> resp =
                                                      await dataToSend
                                                          .activeTontine(widget
                                                              .objetTontine!.id
                                                              .toString());

                                                  // print("loading true");
                                                  print("REPONSE ${resp}");

                                                  // if (resp == null) {
                                                  //                ContenteValidation(
                                                  //                 size: size,
                                                  //                 errorResp: 1,
                                                  //                 textValidate:
                                                  //                     "VOUS NE POUVEZ PAS DEMARER LA TONTINE",
                                                  //                 loading: true,
                                                  //                 page: DetailTontine(
                                                  //                     objetTontine: widget
                                                  //                         .objetTontine),
                                                  //                 textBoutton: '',
                                                  //               );
                                                  //             } else if (resp['code'] >=
                                                  //                 400) {
                                                  //                ContenteValidation(
                                                  //                 size: size,
                                                  //                 errorResp: 1,
                                                  //                 textValidate: "ERREUR",
                                                  //                 loading: false,
                                                  //                 page: MesTontine(),
                                                  //                 textBoutton: 'RETOUR',
                                                  //               );
                                                  //             }
                                                  //              ContenteValidation(
                                                  //               page: MesTontine(),
                                                  //               textBoutton: 'RETOUR',
                                                  //               size: size,
                                                  //               errorResp: 0,
                                                  //               textValidate:
                                                  //                   "VOUS AVEZ DEMARER LA TONTINE",
                                                  //               loading: false,
                                                  //             );

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

                                                  // showModalBottomSheet(
                                                  //     backgroundColor:
                                                  //         ColorTheme.primaryColorBlue,
                                                  //     context: context,
                                                  //     isDismissible: false,
                                                  //     enableDrag: false,
                                                  //     shape: const RoundedRectangleBorder(
                                                  //       borderRadius: BorderRadius.vertical(
                                                  //         top: Radius.circular(30.0),
                                                  //       ),
                                                  //     ),
                                                  //     builder: (context) {
                                                  //       dataToSend = widget.objetTontine;

                                                  //       print("DataSend      ${dataToSend}");

                                                  //       return FutureBuilder(
                                                  //           future:
                                                  //               dataToSend.activeTontine(),
                                                  //           builder: ((context, snapshot) {
                                                  //             dynamic resp = snapshot.data;

                                                  //             print("resp ....... ${resp}");

                                                  //             if (resp == null) {
                                                  //               return ContenteValidation(
                                                  //                 size: size,
                                                  //                 errorResp: 1,
                                                  //                 textValidate:
                                                  //                     "VOUS NE POUVEZ PAS DEMARER LA TONTINE",
                                                  //                 loading: true,
                                                  //                 page: DetailTontine(
                                                  //                     objetTontine: widget
                                                  //                         .objetTontine),
                                                  //                 textBoutton: '',
                                                  //               );
                                                  //             } else if (resp['code'] >=
                                                  //                 400) {
                                                  //               return ContenteValidation(
                                                  //                 size: size,
                                                  //                 errorResp: 1,
                                                  //                 textValidate: "ERREUR",
                                                  //                 loading: false,
                                                  //                 page: MesTontine(),
                                                  //                 textBoutton: 'RETOUR',
                                                  //               );
                                                  //             }
                                                  //             return ContenteValidation(
                                                  //               page: MesTontine(),
                                                  //               textBoutton: 'RETOUR',
                                                  //               size: size,
                                                  //               errorResp: 0,
                                                  //               textValidate:
                                                  //                   "VOUS AVEZ DEMARER LA TONTINE",
                                                  //               loading: false,
                                                  //             );
                                                  //           })
                                                  //         );
                                                  //     }
                                                  //   );
                                                }),
                                                child:
                                                    Text("DEMARER LA TONTINE")),
                                          ),
                                        ),
                                      )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
  }

  getCODEQR(BuildContext context, Size size, String dataQR) {
    print("QRCODE GEN ............................ ${dataQR}");
    print(
        "QRCODE GEN jsonDecode ............................ ${jsonDecode(dataQR)}");

    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
                opacity: a1.value,
                child: Container(
                  height: size.height,
                  width: size.width,
                  padding: EdgeInsets.only(
                      left: 30, right: 30, top: 100, bottom: 100),
                  color: ColorTheme.primaryColorWhite,
                  child: Container(
                    height: size.height * 0.6,
                    width: size.width * 0.5,
                    decoration: BoxDecoration(
                        color: ColorTheme.primaryColorBlue,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Stack(
                      children: [
                        Container(
                          child: ElevatedButton(
                            style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all<Color>(
                                    Colors.transparent),
                                elevation: MaterialStateProperty.all<double>(0),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      side: BorderSide(
                                          color: Colors.transparent)),
                                )),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close,
                              size: 50,
                              color: ColorTheme.primaryColorWhite,
                            ),
                          ),
                        ),
                        CodeQr(
                          size: size,
                          dataQR: dataQR,
                          sizeQRCODE: 150,
                          foregroundColor: ColorTheme.primaryColorWhite,
                        ),
                      ],
                    ),
                  ),
                )),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: ((context, animation, secondaryAnimation) {
          return Container(
            child: Text("data"),
          );
        }));
  }
}
