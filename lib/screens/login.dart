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
  void _showToast(BuildContext context, String text) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(text.toString()),
        action: SnackBarAction(
            label: 'Fermer', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

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
          elevation: 0,
          title: const Text(''),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          width: size.width,
          height: size.height - 24,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ColorTheme.primaryColorBlue,
          ),
          child: SizedBox(
            child: Form(
                key: _formKey,
                child: loading
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              const Text(
                                "Connexion",
                                style: optionStyle,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40)),
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
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
                              SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        // Validate returns true if the form is valid, or false otherwise.
                                        // print(_contentFrequencePersonnaliser.switchPeriode);
                                        // print(valueForm.toString());
                                        print(
                                            "valeur : ${valueForm.toJsonMap()}");

                                        if (_formKey.currentState!.validate()) {
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
                                            _showToast(context,
                                                "MOT DE PASSE INCORRECT");
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
                                              MaterialStateProperty.all<Color>(
                                                  ColorTheme
                                                      .primaryColorYellow),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                                side: BorderSide(
                                                    color: ColorTheme
                                                        .primaryColorYellow)),
                                          )))),
                              SizedBox(
                                  width: double.infinity,
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
                                              MaterialStateProperty.all<Color>(
                                                  ColorTheme.primaryColorBlue),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                                side: BorderSide(
                                                    color: ColorTheme
                                                        .primaryColorYellow)),
                                          ))))
                            ],
                          ),
                        ],
                      )),
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

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Added to favorite'),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

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
                    _showToast(context);

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
