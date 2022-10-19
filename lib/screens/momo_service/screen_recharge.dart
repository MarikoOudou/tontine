import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tontino/services/Colors.dart';

class ScreenRecharge extends StatefulWidget {
  const ScreenRecharge({Key? key, required this.tel}) : super(key: key);

  final String tel;

  @override
  _ScreenRechargeState createState() => _ScreenRechargeState();
}

class _ScreenRechargeState extends State<ScreenRecharge> {
  int montantEnvoyer = 0;
  double frais = 0.01;
  int montantfrais = 0;
  bool _validate = true;
  sendMoney(int montantEnvoyer) {
    print("montantEnvoyer");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          width: 50,
          height: 50,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(60)),
          child: SvgPicture.asset(
            "assets/images/mtnmomo.svg",
            width: 300,
          ),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Column(
                children: [
                  const Text(
                    "À : ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const Text("(0757351113)",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: ListTile(
                      // leading: Text("Solde 0 FCFA"),
                      title: Container(
                        child: TextFormField(
                          keyboardType: TextInputType.numberWithOptions(
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
                                  ? 'Le montant doit etre superieur a 100'
                                  : null,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
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
                      Text("$montantfrais CFA"),
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
                                  sendMoney(montantEnvoyer);
                                },
                          style: ButtonStyle(),
                          child: Text("Confirmé"))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
