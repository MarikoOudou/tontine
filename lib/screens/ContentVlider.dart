import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tontino/models/Tontine.dart';
import 'package:tontino/screens/home.dart';
import 'package:tontino/services/Colors.dart';

class ContenteValidation extends StatefulWidget {
  const ContenteValidation({
    Key? key,
    required this.size,
    required this.textValidate,
    required this.errorResp,
    required this.textBoutton,
    this.page,
    required this.loading,
  }) : super(key: key);

  //

  final Size size;
  final String textValidate;
  final String textBoutton;
  final Widget? page;
  final int errorResp; // 0: felicitation, 1: error
  final bool loading;

  @override
  State<ContenteValidation> createState() => _ContenteValidationState();
}

class _ContenteValidationState extends State<ContenteValidation> {
  String textValidate =
      'Votre tontine vient d’être créer avec succès ! Vous pouvez y accéder pour la consulter.';

  Widget pageRetour(Widget page) {
    return page;
  }

  @override
  Widget build(BuildContext context) {
    textValidate = widget.textValidate;
    return Container(
      height: widget.size.height * 0.55,
      padding: EdgeInsets.only(left: 20, right: 20, top: 0),
      child: widget.loading
          ? Container(
              child: Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: ColorTheme.primaryColorYellow,
                  size: 200,
                ),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  width: widget.size.width,
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: widget.size.width * 0.4,
                  ),
                ),
                Column(
                  children: [
                    DefaultTextStyle(
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: widget.size.width * 0.056,
                          color: ColorTheme.primaryColorWhite,
                          fontWeight: FontWeight.bold),
                      child: Text(
                          (widget.errorResp == 0 ? "Félicitation" : "ERREUR")
                              .toUpperCase(),
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: widget.size.width * 0.056,
                              color: ColorTheme.primaryColorWhite,
                              fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 10, right: 10, left: 10),
                      child: DefaultTextStyle(
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: widget.size.width * 0.04,
                            color: ColorTheme.primaryColorWhite,
                            fontWeight: FontWeight.w400),
                        child: Text(textValidate.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: widget.size.width * 0.04,
                                color: ColorTheme.primaryColorWhite,
                                fontWeight: FontWeight.w400)),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                    onPressed: (() {
                      if (widget.page == null) {
                        Navigator.pop(context);
                      } else {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Home()), // this mymainpage is your page to refresh
                          (Route<dynamic> route) => false,
                        );
                      }
                    }),
                    child: Text(
                      widget.textBoutton,
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: widget.size.width * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all<Size>(Size(
                            widget.size.width * 0.9,
                            (widget.size.height - kToolbarHeight) * 0.07)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            ColorTheme.primaryColorBlue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: BorderSide(
                                  color: ColorTheme.primaryColorBlue)),
                        )))
              ],
            ),
    );
  }
}
