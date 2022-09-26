import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tontino/models/user.dart';
import 'package:tontino/screens/ContentVlider.dart';
import 'package:tontino/screens/home.dart';
import 'package:tontino/screens/loading.dart';
import 'package:tontino/screens/login.dart';
import 'package:tontino/services/Colors.dart';

class SingUp extends StatefulWidget {
  const SingUp({Key? key, this.param}) : super(key: key);

  final dynamic param;

  @override
  _SingUpState createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);

  List<String> textValidate = ["Le champs n'est pas correct", ""];
  final _formKey = GlobalKey<FormState>();

  User user = User();

  List<String> label = [
    // "Nom d'utilisateur",
    "Nom",
    "Prénom (s)",
    "Telephone",
    "Mot de passe",
  ];
  bool loading = false;
  bool error = false;
  bool create = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(''),
      ),
      body: SingleChildScrollView(
        child: loading
            ? SingleChildScrollView(
                child: Container(
                height: size.height,
                color: ColorTheme.primaryColorBlue,
                child: ContenteValidation(
                  textBoutton: "ERREUR DE CREATION DE COMPTE",
                  page: SingUp(),
                  size: size,
                  errorResp: 1,
                  textValidate: "ERREUR DE CREATION DU COMPTE",
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
                      size: size,
                      errorResp: 1,
                      textValidate:
                          "ERREUR DE CREATION DE COMPTE, veuillez ressayer a nouveau "
                              .toUpperCase(),
                      loading: false,
                    ),
                  ))
                : create
                    ? SingleChildScrollView(
                        child: Container(
                        height: size.height - 24,
                        color: ColorTheme.primaryColorBlue,
                        child: ContenteValidation(
                          textBoutton: "RETOUR",
                          page: Home(),
                          size: size,
                          errorResp: 0,
                          textValidate: "VOTRE COMPTE A été CRée".toLowerCase(),
                          loading: false,
                        ),
                      ))
                    : Container(
                        padding: EdgeInsets.all(20),
                        color: ColorTheme.primaryColorBlue,
                        height: size.height - kToolbarHeight,
                        width: size.width,
                        alignment: Alignment.center,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  const Text(
                                    "Inscription",
                                    style: optionStyle,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    child: Image.asset(
                                      "assets/images/logo.png",
                                      width: 150,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                // The validator receives the text that the user has entered.
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '${textValidate[0]}';
                                  }
                                  user.nom = value;
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
                                        color: ColorTheme.primaryColorWhite,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color:
                                                ColorTheme.primaryColorWhite),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0))),

                                    // labelText: label[0],
                                    label: Text("${label[0]}"),
                                    labelStyle: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 15,
                                        color: ColorTheme.primaryColorWhite,
                                        fontWeight: FontWeight.w500)),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                // The validator receives the text that the user has entered.
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '${textValidate[0]}';
                                  }
                                  user.prenom = value;
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
                                        color: ColorTheme.primaryColorWhite,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color:
                                                ColorTheme.primaryColorWhite),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0))),

                                    // labelText: label[0],
                                    label: Text("${label[1]}"),
                                    labelStyle: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 15,
                                        color: ColorTheme.primaryColorWhite,
                                        fontWeight: FontWeight.w500)),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        signed: true, decimal: true),
                                // controller: _montantcontroller,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[0-9.,]')),
                                ],
                                // The validator receives the text that the user has entered.
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '${textValidate[0]}';
                                  }
                                  user.tel = value;
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
                                        color: ColorTheme.primaryColorWhite,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color:
                                                ColorTheme.primaryColorWhite),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0))),

                                    // labelText: label[0],
                                    label: Text("${label[2]}"),
                                    labelStyle: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 15,
                                        color: ColorTheme.primaryColorWhite,
                                        fontWeight: FontWeight.w500)),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                // The validator receives the text that the user has entered.
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '${textValidate[0]}';
                                  }
                                  user.password = value;
                                  return null;
                                },
                                obscureText: true,
                                autofocus: false,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 18,
                                    color: ColorTheme.primaryColorWhite,
                                    fontWeight: FontWeight.w700),
                                decoration: InputDecoration(
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
                                        color: ColorTheme.primaryColorWhite,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color:
                                                ColorTheme.primaryColorWhite),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0))),

                                    // labelText: label[0],
                                    label: Text("${label[3]}"),
                                    labelStyle: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 15,
                                        color: ColorTheme.primaryColorWhite,
                                        fontWeight: FontWeight.w500)),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      // Validate returns true if the form is valid, or false otherwise.
                                      // print(_contentFrequencePersonnaliser.switchPeriode);

                                      if (_formKey.currentState!.validate()) {
                                        // If the form is valid, display a snackbar. In the real world,
                                        // you'd often call a server or save the information in a database.
                                        print(user.toJsonMap());

                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            loading = true;
                                          });

                                          Map<String, dynamic> resp =
                                              await user.create();

                                          // print("loading true");
                                          print("Response ${resp}");

                                          if (!resp["reponse"]) {
                                            // print("loading false");
                                            setState(() {
                                              loading = false;
                                              error = true;
                                            });
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text("Sending Message"),
                                            ));
                                          } else {
                                            await user.login(
                                                telephone: user.tel,
                                                motDpass: user.password);
                                            setState(() {
                                              loading = false;
                                              create = true;
                                            });
                                          }
                                        }
                                      }
                                    },
                                    child: Text(
                                      "Inscription",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: size.width * 0.04,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                ColorTheme.primaryColorYellow),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6.0),
                                              side: BorderSide(
                                                  color: ColorTheme
                                                      .primaryColorYellow)),
                                        )),
                                  )),
                            ],
                          ),
                        ),
                      ),
      ),
    );
  }

  loadingWi(BuildContext context) {
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
                opacity: a1.value,
                child: Container(
                  height: 50,
                  width: 50,
                  padding: EdgeInsets.only(
                      top: 200, bottom: 200, left: 60, right: 60),
                  child: CircularProgressIndicator(
                    strokeWidth: 10,
                    color: ColorTheme.primaryColorYellow,
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
