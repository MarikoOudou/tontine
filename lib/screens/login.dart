import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tontino/models/user.dart';
import 'package:tontino/screens/SingUp.dart';
import 'package:tontino/screens/home.dart';
import 'package:tontino/screens/loading.dart';
import 'package:tontino/services/Colors.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  //static

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);

  List<String> textValidate = ["Le champs n'est pas correct", ""];
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> param = {
    "message": {"isMessage": false, "text": "L'UTILISATEUR N'EXISTE PAS"}
  };
  User valueForm = User();

  bool loading = false;

  SharedAppData? sharedAppData;



  List<String> label = [
    "Numéro de téléphone",
    "Mot de passe",
  ];
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
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(15),
          width: size.width,
          height: size.height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: ColorTheme.primaryColorBlue,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: ColorTheme.primaryColorBlack.withOpacity(0.8),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ]),
          child: Stack(
            children: [
              Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      loading
                          ? Container(
                              color: ColorTheme.primaryColorBlue,
                              child: Center(
                                child: LoadingAnimationWidget.staggeredDotsWave(
                                  color: ColorTheme.primaryColorYellow,
                                  size: 200,
                                ),
                              ),
                            )
                          : Column(
                              children: [
                                Container(
                                  child: Text(
                                    "Connexion",
                                    style: optionStyle,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: TextFormField(
                                    keyboardType: TextInputType.phone,
                                    // The validator receives the text that the user has entered.
                                    validator: (value) {
                                      print("Telephone : ${value}");
                                      if (value == null || value.isEmpty) {
                                        return '${textValidate[0]}';
                                      }
                                      valueForm.username = value;
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
                                              color:
                                                  ColorTheme.primaryColorYellow,
                                            )),
                                        contentPadding: EdgeInsets.all(10),
                                        filled: false,
                                        fillColor:
                                            ColorTheme.primaryColorYellow,
                                        focusColor:
                                            ColorTheme.primaryColorYellow,
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
                                            color: ColorTheme.primaryColorWhite,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: TextFormField(
                                    keyboardType: TextInputType.visiblePassword,
                                    keyboardAppearance: Brightness.dark,
                                    // The validator receives the text that the user has entered.
                                    validator: (value) {
                                      print("mot de passe : ${value}");
                                      if (value == null || value.isEmpty) {
                                        return '${textValidate[0]}';
                                      }
                                      valueForm.password = value;

                                      return null;
                                    },
                                    // autofocus: false,
                                    obscureText: true,
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
                                              color:
                                                  ColorTheme.primaryColorYellow,
                                            )),
                                        contentPadding: EdgeInsets.all(10),
                                        filled: false,
                                        fillColor:
                                            ColorTheme.primaryColorYellow,
                                        focusColor:
                                            ColorTheme.primaryColorYellow,
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
                                                color: ColorTheme
                                                    .primaryColorWhite),
                                            borderRadius:
                                                const BorderRadius.all(
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
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          // Validate returns true if the form is valid, or false otherwise.
                                          // print(_contentFrequencePersonnaliser.switchPeriode);
                                          // print(valueForm.toString());

                                          print(
                                              "valeur : ${valueForm.toJsonMap()}");

                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              loading = true;
                                            });

                                            Map<String, dynamic> resp =
                                                await valueForm.login();

                                            print("loading true");
                                            print("Response ${resp}");
                                            if (!resp["reponse"]) {
                                              print("loading false");
                                              setState(() {
                                                loading = false;
                                                param = {
                                                  "message": {
                                                    "isMessage": true,
                                                    "text":
                                                        "L'UTILISATEUR N'EXISTE PAS"
                                                  }
                                                };
                                              });
                                            } else {
                                              print("loading false");
                                              setState(() {
                                                loading = false;
                                              });
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: ((context) =>
                                                          Home())));
                                            }
                                            /*FutureBuilder(
                        future: valueForm.login(),
                        builder: ((context, snapshot) {
                          if (snapshot.data == null) {
                            return Loading();
                          } else if (snapshot.data!["reponse"]) {
                            return Home();
                          }

                          return Login(param: {
                            "message": {
                              "isMessage": true,
                              "text": "L'UTILISATEUR N'EXISTE PAS"
                            }
                          });
                        }),
                      );*/
                                            /*showDialog(
                        context: context,
                        useSafeArea: false,
                        builder: (BuildContext context) => FutureBuilder(
                          future: valueForm.login(),
                          builder: ((context, snapshot) {
                            if (snapshot.data == null) {
                              return Loading();
                            } else if (snapshot.data!["reponse"]) {
                              return Home();
                            }

                            return Login(param: {
                              "message": {
                                "isMessage": true,
                                "text": "L'UTILISATEUR N'EXISTE PAS"
                              }
                            });
                          }),
                        ),
                      );*/
                                            // loadingPage(size, context);

                                            //  await valueForm.login();

                                            // Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                                          }
                                        },
                                        child: Text(
                                          "Connexion",
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
                                Container(
                                    child: ElevatedButton(
                                        onPressed: () {
                                          // Validate returns true if the form is valid, or false otherwise.
                                          // print(_contentFrequencePersonnaliser.switchPeriode);

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      SingUp())));
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
                                                MaterialStateProperty
                                                    .all<Color>(ColorTheme
                                                        .primaryColorBlue),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.0),
                                                  side: BorderSide(
                                                      color: ColorTheme
                                                          .primaryColorYellow)),
                                            ))))
                              ],
                            )
                    ],
                  ),
                ),
              ),
              param!["message"]!["isMessage"]
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
                        param["message"]["text"],
                        style: TextStyle(
                            color: ColorTheme.primaryColorWhite,
                            fontWeight: FontWeight.bold),
                      )),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class Formulaire extends StatefulWidget {
  const Formulaire({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.optionStyle,
    required this.textValidate,
    required this.label,
    required this.size,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextStyle optionStyle;
  final List<String> textValidate;
  final List<String> label;
  final Size size;

  @override
  State<Formulaire> createState() => _FormulaireState();
}

class _FormulaireState extends State<Formulaire> {
  User valueForm = User();

  SharedAppData? sharedAppData;

  loadingPage(Size size, BuildContext context) {
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 2),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: ((context, animation, secondaryAnimation) {
          return Container(
            child: SafeArea(
                child: SizedBox(
                    child: FutureBuilder(
              future: valueForm.login(),
              builder: ((context, snapshot) {
                if (snapshot.data == null || snapshot.data!["reponse"]) {
                  return Loading();
                }
                return Container();
              }),
            ))),
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Text(
              "Connexion",
              style: widget.optionStyle,
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              keyboardType: TextInputType.phone,
              // The validator receives the text that the user has entered.
              validator: (value) {
                print("Telephone : ${value}");
                if (value == null || value.isEmpty) {
                  return '${widget.textValidate[0]}';
                }
                valueForm.username = value;
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
                          const BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        width: 2,
                        color: ColorTheme.primaryColorYellow,
                      )),
                  contentPadding: EdgeInsets.all(10),
                  filled: false,
                  fillColor: ColorTheme.primaryColorYellow,
                  focusColor: ColorTheme.primaryColorYellow,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      width: 2,
                      color: ColorTheme.primaryColorWhite,
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: ColorTheme.primaryColorWhite),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0))),

                  // labelText: label[0],
                  label: Text("${widget.label[0]}"),
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
              keyboardType: TextInputType.visiblePassword,
              keyboardAppearance: Brightness.dark,
              // The validator receives the text that the user has entered.
              validator: (value) {
                print("mot de passe : ${value}");
                if (value == null || value.isEmpty) {
                  return '${widget.textValidate[0]}';
                }
                valueForm.password = value;

                return null;
              },
              // autofocus: false,
              obscureText: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 18,
                  color: ColorTheme.primaryColorWhite,
                  fontWeight: FontWeight.w700),
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        width: 2,
                        color: ColorTheme.primaryColorYellow,
                      )),
                  contentPadding: EdgeInsets.all(10),
                  filled: false,
                  fillColor: ColorTheme.primaryColorYellow,
                  focusColor: ColorTheme.primaryColorYellow,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      width: 2,
                      color: ColorTheme.primaryColorWhite,
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: ColorTheme.primaryColorWhite),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0))),

                  // labelText: label[0],
                  label: Text("${widget.label[1]}"),
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
                    // print(valueForm.toString());

                    print("valeur : ${valueForm.toJsonMap()}");

                    if (widget._formKey.currentState!.validate()) {
                      /*ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );*/

                      Map<String, dynamic> resp = await valueForm.login();

                      print("loading true");
                      if (resp["reponse"]) {
                        print("loading false");
                      } else {
                        print("loading false");
                        Navigator.push(context,
                            MaterialPageRoute(builder: ((context) => Home())));
                      }
                      /*FutureBuilder(
                        future: valueForm.login(),
                        builder: ((context, snapshot) {
                          if (snapshot.data == null) {
                            return Loading();
                          } else if (snapshot.data!["reponse"]) {
                            return Home();
                          }

                          return Login(param: {
                            "message": {
                              "isMessage": true,
                              "text": "L'UTILISATEUR N'EXISTE PAS"
                            }
                          });
                        }),
                      );*/
                      /*showDialog(
                        context: context,
                        useSafeArea: false,
                        builder: (BuildContext context) => FutureBuilder(
                          future: valueForm.login(),
                          builder: ((context, snapshot) {
                            if (snapshot.data == null) {
                              return Loading();
                            } else if (snapshot.data!["reponse"]) {
                              return Home();
                            }

                            return Login(param: {
                              "message": {
                                "isMessage": true,
                                "text": "L'UTILISATEUR N'EXISTE PAS"
                              }
                            });
                          }),
                        ),
                      );*/
                      // loadingPage(widget.size, context);

                      //  await valueForm.login();

                      // Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                    }
                  },
                  child: Text(
                    "Connexion",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: widget.size.width * 0.04,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          ColorTheme.primaryColorYellow),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            side: BorderSide(
                                color: ColorTheme.primaryColorYellow)),
                      )))),
          Container(
              child: ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    // print(_contentFrequencePersonnaliser.switchPeriode);

                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => SingUp())));
                  },
                  child: Text(
                    "Inscription",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: widget.size.width * 0.04,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          ColorTheme.primaryColorBlue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            side: BorderSide(
                                color: ColorTheme.primaryColorYellow)),
                      ))))
        ],
      ),
    );
  }
}
