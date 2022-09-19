import 'package:flutter/material.dart';
import 'package:tontino/models/Tontine.dart';
import 'package:tontino/screens/ContentVlider.dart';
import 'package:tontino/services/Colors.dart';

class Depot extends StatefulWidget {
  const Depot({Key? key, required this.tontine}) : super(key: key);

  final dynamic tontine;

  @override
  _DepotState createState() => _DepotState();
}

class _DepotState extends State<Depot> {
  dynamic dataTontine;

  Tontine cotisation = Tontine();

  CotisationSend(Map<String, dynamic> data) {
    return cotisation.cotisation(data);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 25) / 2;
    final double itemWidth = size.width / 2;

    dataTontine = widget.tontine;

    print(
        "......................................................................${dataTontine}");

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("Cotisation Tontine"),
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
                  title: Text(dataTontine!.nom,
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 25,
                          color: ColorTheme.primaryColorBlack,
                          fontWeight: FontWeight.bold)),
                  subtitle: Text("Numero de dépôt: ${dataTontine.createdBy}",
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 15,
                          color: ColorTheme.primaryColorYellow,
                          fontWeight: FontWeight.bold)),
                  trailing: Text(
                    "${dataTontine.montant} FCFA",
                    style: TextStyle(
                        color: ColorTheme.primaryColorBlue,
                        fontWeight: FontWeight.bold),
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
                    Text("${dataTontine.montant * 0.01} FCFA",
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
                    Text(
                        "${dataTontine.montant + (dataTontine.montant * 0.01)} FCFA",
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
                  onPressed: (() async {
                    // Map<String, dynamic> cotise = await CotisationSend({
                    //   "idTontine": dataTontine.id,
                    //   "montant":
                    //       (dataTontine.montant + (dataTontine.montant * 0.01))
                    // });

                    // print("COTISATION ......................  ${cotise}");

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
                              future: CotisationSend({
                                "idTontine": dataTontine.id,
                                "montant": (dataTontine.montant +
                                    (dataTontine.montant * 0.01))
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
                        });
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
