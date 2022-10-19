import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tontino/logic/cubit/app_cubit.dart';
import 'package:tontino/logic/cubit/service_momo_cubit.dart';
import 'package:tontino/models/MomoService.dart';
import 'package:tontino/screens/ContentVlider.dart';
import 'package:tontino/services/Colors.dart';

class ScreenDepot extends StatefulWidget {
  const ScreenDepot({Key? key, required this.tel}) : super(key: key);

  final String tel;

  @override
  _ScreenDepotState createState() => _ScreenDepotState();
}

class _ScreenDepotState extends State<ScreenDepot> {
  TextEditingController _montantcontroller = TextEditingController();

  int montantEnvoyer = 0;
  double frais = 0.01;
  int montantfrais = 0;
  bool _validate = false;
  bool loading = false;
  bool create = false;
  bool error = false;
  String message = "";
  MomoService momoService = MomoService();

  sendMoney(int montantEnvoyer, BuildContext context) {
    if (montantEnvoyer > 0) {
      BlocProvider.of<ServiceMomoCubit>(context).rechargement(montantEnvoyer);

      // setState(() {
      //   loading = true;
      // });

      // setState(() {
      //   loading = true;
      // });

      // Map<String, dynamic> resp =
      //     await momoService.rechargement(montantEnvoyer);

      // // print("loading true");
      // print("REPONSE ${resp}");

      // message = resp['message'];

      // if (!resp["reponse"]) {
      //   // print("loading false");
      //   setState(() {
      //     loading = false;
      //     error = true;
      //   });
      // } else {
      //   setState(() {
      //     loading = false;
      //     create = true;
      //   });
      // }
    }
  }

  String tel = "";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    tel = widget.tel;
    return BlocConsumer<ServiceMomoCubit, ServiceMomoState>(
      listener: (appStateContext, state) {
        // TODO: implement listener
        if (state is ServiceMomoError) {
          // Find the ScaffoldMessenger in the widget tree
          // and use it to show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('ERREUR '),
            // action: SnackBarAction(
            //   label: 'Undo',
            //   onPressed: () {
            //     // Some code to undo the change.
            //   },
            // ),
          ));
        }
      },
      builder: (appStateContext, state) {
        if (state is ServiceMomoLoading) {
          print("Loading sate");

          return SingleChildScrollView(
              child: Container(
            height: size.height,
            color: ColorTheme.primaryColorBlue,
            child: ContenteValidation(
              textBoutton: "",
              // page: Home(),
              size: size,
              errorResp: 1,
              textValidate: message,
              loading: true,
            ),
          ));
        }

        if (state is ServiceMomoSuccess) {
          return SingleChildScrollView(
              child: Container(
            height: size.height,
            color: ColorTheme.primaryColorBlue,
            child: ContenteValidation(
              textBoutton: "RETOUR",
              // page: Home(),
              size: size,
              errorResp: 0,
              fonctionValue: 0,
              textValidate:
                  "Votre transaction est en cours de traitement".toUpperCase(),
              loading: false,
            ),
          ));
        }

        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              width: 50,
              height: 50,
              padding: EdgeInsets.all(5),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(60)),
              child: SvgPicture.asset(
                "assets/images/mtnmomo.svg",
                width: 300,
              ),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Column(
                  children: [
                    const Text(
                      "Débiter le numéro: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text("(${tel})",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(
                      height: 30,
                    ),
                    ListTile(
                      // leading: Text("Solde 0 FCFA"),
                      title: Container(
                        child: TextFormField(
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          // controller: _montantcontroller,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            FilteringTextInputFormatter.allow(
                                RegExp('[0-9.,]')),
                          ],
                          // initialValue: "0",
                          onChanged: (value) {
                            setState(() {
                              _validate = true;

                              if (value == null || value.isEmpty) {
                                _validate = true;
                                montantfrais = 0;
                              } else if (int.parse(value) == 0 ||
                                  int.parse(value) < 0 ||
                                  int.parse(value) < 99) {
                                _validate = true;
                                montantfrais = 0;
                              } else if (int.parse(value) > 100) {
                                _validate = false;
                                montantEnvoyer = (int.parse(value) -
                                        (int.parse(value) * frais).toInt())
                                    .toInt();
                                montantfrais =
                                    (int.parse(value) * frais).toInt();
                              }

                              print(_validate);
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              _validate = true;
                              montantfrais = 0;
                            }
                            return null;
                          },
                          autofocus: false,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 18,
                              color: ColorTheme.primaryColorBlack,
                              fontWeight: FontWeight.w700),
                          decoration: InputDecoration(
                              errorText: _validate
                                  ? 'Le montant doit etre superieur a 100 FCFA'
                                  : null,
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              floatingLabelStyle: TextStyle(),
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.center,
                              hintText: "0.00",
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: ColorTheme.primaryColorYellow,
                                  )),
                              contentPadding: EdgeInsets.all(10),
                              filled: false,
                              fillColor: ColorTheme.primaryColorYellow,
                              focusColor: ColorTheme.primaryColorYellow,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0)),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: ColorTheme.primaryColorBlue,
                                ),
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: ColorTheme.primaryColorBlack),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0))),

                              // labelText: label[0],
                              label: Text("Montant"),
                              labelStyle: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 15,
                                  color: ColorTheme.primaryColorBlack,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                      trailing: Text(
                        "FCFA",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 15,
                            color: ColorTheme.primaryColorBlack,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Frais de transfert (1%)"),
                        Text(" CFA"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Montant à recevoir",
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: ColorTheme.primaryColorBlack),
                        ),
                        Text("${montantEnvoyer.toString()} CFA",
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: ColorTheme.primaryColorBlack)),
                      ],
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: _validate
                                ? null
                                : () {
                                    sendMoney(montantEnvoyer, context);
                                  },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        ColorTheme.primaryColorBlue),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: BorderSide(
                                          color: ColorTheme.primaryColorBlue)),
                                )),
                            child: Text("Confirmé"))),
                    Container(
                      child: Text(
                        "L'étape suivant déclanchera une demande de validation par USSD de l'opérateur MTN MoMo.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
