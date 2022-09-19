import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tontino/models/user.dart';
import 'package:tontino/screens/ContentVlider.dart';
import 'package:tontino/services/Colors.dart';

class Transfert extends StatefulWidget {
  const Transfert({Key? key, required this.user}) : super(key: key);

  final String user;

  @override
  _TransfertState createState() => _TransfertState();
}

class _TransfertState extends State<Transfert> {
  String tel =
      "{\"id\":2,\"username\":null,\"nom\":\"Mariko\",\"prenom\":\"Oudou\",\"tel\":\"0757351113\",\"password\":null}";
  int montant = 0;
  double frais = 0;
  double montantTotal = 0;

  User user = User();
  tranfert(Map<String, dynamic> data) {
    return user!.transfert(data);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 25) / 2;
    final double itemWidth = size.width / 2;
    // jsonEncode(object)
    // jsonDecode(source)
    print("String ${widget.user.toString()}");
    print("jsonDecode ${jsonDecode(widget.user.toString())}");

    user = User.fromJsonMap(jsonDecode(widget.user.toString()));
    tel = user.tel.toString();
    print(user);

    // tel = widget.user;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("Transfert"),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 5, bottom: 10, left: 20, right: 20),
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                ListTile(
                  leading: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: ColorTheme.primaryColorBlue.shade200,
                        boxShadow: [
                          BoxShadow(
                              color: ColorTheme.primaryColorBlue,
                              spreadRadius: 1),
                        ],
                      ),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        alignment: Alignment.center,
                        child: Text(
                          tel!.substring(0, 2),
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                      )),
                  // title: Text("Abou Koné",
                  //     style: TextStyle(
                  //         fontFamily: "Montserrat",
                  //         fontSize: 25,
                  //         color: ColorTheme.primaryColorBlack,
                  //         fontWeight: FontWeight.bold)),
                  title: Text(tel,
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 15,
                          color: ColorTheme.primaryColorBlack,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: size.height * 0.06,
                  width: size.width,
                  constraints: BoxConstraints(maxHeight: 100),
                  child: TextField(
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        print(value);
                        if (value == null || value == "") {
                          montant = 0;
                        } else {
                          montant = int.tryParse(value)!.toInt();
                        }

                        frais = montant * 0.01;

                        montantTotal = montant + frais;
                      });
                    },
                    style: TextStyle(fontSize: 15.0, color: Colors.black),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      floatingLabelStyle: TextStyle(color: Colors.black),
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      hintStyle: TextStyle(color: Colors.white),
                      suffixIconColor: Colors.white,
                      iconColor: Colors.black,
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6.0)),
                          borderSide: BorderSide(
                            width: 1,
                            color: ColorTheme.primaryColorYellow,
                          )),
                      contentPadding: EdgeInsets.all(10),
                      filled: true,
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6.0)),
                        borderSide: BorderSide(
                          width: 2,
                          color: ColorTheme.primaryColorBlue,
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.white),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6.0))),
                      labelText: 'Montant',
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Frais",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w500)),
                    Text("${frais} FCFA",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Total à envoyer",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w500)),
                    Text("${montantTotal} FCFA",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            ),
            Container(
              child: ElevatedButton(
                  onPressed: (() => {
                        if (montant != 0)
                          {
                            showModalBottomSheet(
                                backgroundColor: ColorTheme.primaryColorBlue,
                                context: context,
                                isDismissible: false,
                                enableDrag: false,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30.0),
                                  ),
                                ),
                                builder: (context) {
                                  return FutureBuilder(
                                      future: tranfert({
                                        "receiverTel": tel,
                                        "montant": montantTotal
                                      }),
                                      builder: ((context, snapshot) {
                                        dynamic cotise = snapshot.data;

                                        if (cotise == null ||
                                            (cotise["reponse"] == null ||
                                                cotise["reponse"] == false)) {
                                          return ContenteValidation(
                                            size: size,
                                            errorResp: 1,
                                            textValidate:
                                                "LE DEPOT A ETE EFFECTUER AVEC SUCCES",
                                            loading: true,
                                          );
                                        }

                                        return ContenteValidation(
                                          size: size,
                                          errorResp: 0,
                                          textValidate:
                                              "LE DEPOT A ETE EFFECTUER AVEC SUCCES",
                                          loading: false,
                                        );
                                      }));
                                })
                          }
                      }),
                  child: Text(
                    "Envoyer",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: size.width * 0.04,
                        fontWeight: FontWeight.bold,
                        color: ColorTheme.primaryColorWhite),
                  ),
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(Size(
                          size.width * 0.9,
                          (size.height - kToolbarHeight) * 0.07)),
                      maximumSize: MaterialStateProperty.all<Size>(Size(
                          size.width * 0.9,
                          (size.height - kToolbarHeight) * 0.07)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          ColorTheme.primaryColorBlue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(
                                color: ColorTheme.primaryColorYellow)),
                      ))),
            )
          ],
        ),
      ),
    );
  }
}