import 'package:flutter/material.dart';
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
    "Nom d'utilisateur",
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
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: AppBar(
          title: const Text(''),
        ),
      ),
      body: SingleChildScrollView(
        child: loading
            ? SingleChildScrollView(
                child: ContenteValidation(
                size: size,
                errorResp: 1,
                textValidate: "ERREUR DE CREATION DU COMPTE",
                loading: true,
              ))
            : error
                ? SingleChildScrollView(
                    child: ContenteValidation(
                    size: size,
                    errorResp: 1,
                    textValidate: "ERREUR DE CREATION DU COMPTE",
                    loading: false,
                  ))
                : create
                    ? SingleChildScrollView(
                        child: ContenteValidation(
                        size: size,
                        errorResp: 0,
                        textValidate: "VOTRE COMPTE A ETE CREER",
                        loading: false,
                      ))
                    : Container(
                        padding: EdgeInsets.only(
                            top: 50, left: 20, right: 20, bottom: 50),
                        color: ColorTheme.primaryColorBlue,
                        height: size.height,
                        width: size.width,
                        alignment: Alignment.center,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(
                                  "Inscription",
                                  style: optionStyle,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                child: TextFormField(
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '${textValidate[0]}';
                                    }
                                    user.username = value;
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
                                            color:
                                                ColorTheme.primaryColorYellow,
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
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                child: TextFormField(
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
                                            color:
                                                ColorTheme.primaryColorYellow,
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
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                child: TextFormField(
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
                                            color:
                                                ColorTheme.primaryColorYellow,
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
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                child: TextFormField(
                                  keyboardType: TextInputType.phone,
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
                                            color:
                                                ColorTheme.primaryColorYellow,
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
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                child: TextFormField(
                                  obscureText: true,
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '${textValidate[0]}';
                                    }
                                    user.password = value;
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
                                            color:
                                                ColorTheme.primaryColorYellow,
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
                                      label: Text("${label[4]}"),
                                      labelStyle: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 15,
                                          color: ColorTheme.primaryColorWhite,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ),
                              Container(
                                  child: ElevatedButton(
                                onPressed: () async {
                                  // Validate returns true if the form is valid, or false otherwise.
                                  // print(_contentFrequencePersonnaliser.switchPeriode);

                                  if (_formKey.currentState!.validate()) {
                                    // If the form is valid, display a snackbar. In the real world,
                                    // you'd often call a server or save the information in a database.
                                    print(user.toJsonMap());

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
                                    //       print("DataSend      ${user}");

                                    //       return FutureBuilder(
                                    //           future: user.create(),
                                    //           builder: ((context, snapshot) {
                                    //             dynamic resp = snapshot.data;

                                    //             print("resp ....... ${resp}");

                                    //             if (resp == null ||
                                    //                 (resp["reponse"] == null ||
                                    //                     resp["reponse"] == false)) {
                                    //               return ContenteValidation(
                                    //                 size: size,
                                    //                 errorResp: 1,
                                    //                 textValidate:
                                    //                     "ERREUR DE CREATION DU COMPTE",
                                    //                 loading: true,
                                    //               );
                                    //             }

                                    //             // if (resp["access"] == false) {
                                    //             //   return ContenteValidation(
                                    //             //     size: size,
                                    //             //     errorResp: 1,
                                    //             //     textValidate: resp["message"],
                                    //             //     loading: false,
                                    //             //   );
                                    //             // }

                                    //             user.login(
                                    //                 telephone: user.tel,
                                    //                 motDpass: user.password);

                                    //             return ContenteValidation(
                                    //               size: size,
                                    //               errorResp: 0,
                                    //               textValidate:
                                    //                   "VOTRE COMPTE A ETE CREER",
                                    //               loading: false,
                                    //             );
                                    //           }));
                                    //     });

                                    //  print(
                                    //                   "valeur : ${valueForm.toJsonMap()}");

                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        loading = true;
                                      });

                                      Map<String, dynamic> resp =
                                          await user.create();

                                      print("loading true");
                                      print("Response ${resp}");
                                      if (!resp["reponse"]) {
                                        print("loading false");

                                        setState(() {
                                          loading = false;
                                          error = true;
                                          // param = {
                                          //   "message": {
                                          //     "isMessage": true,
                                          //     "text":
                                          //         "L'UTILISATEUR N'EXISTE PAS"
                                          //   }
                                          // };
                                        });
                                      } else {
                                        // print("loading false");
                                        await user.login(
                                            telephone: user.tel,
                                            motDpass: user.password);
                                        setState(() {
                                          loading = false;
                                          create = true;
                                        });
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: ((context) => Home())));
                                      }

                                      // loading(context);
                                      // showDialog(
                                      //   context: context,
                                      //   useSafeArea: false,
                                      //   builder: (BuildContext context) => FutureBuilder(
                                      //     future: user.create(),
                                      //     builder: ((context, snapshot) {
                                      //       print(snapshot.data);

                                      //       if (snapshot.data == null) {
                                      //         return Loading();
                                      //       } else if (snapshot.data!["reponse"]) {
                                      //         return Home();
                                      //       }

                                      //       return SingUp(param: {
                                      //         "message": {
                                      //           "isMessage": true,
                                      //           "text": "L'UTILISATEUR existe deja"
                                      //         }
                                      //       });
                                      //     }),
                                      //   ),
                                      // );
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
