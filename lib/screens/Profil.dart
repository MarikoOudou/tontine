import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:tontino/logic/cubit/app_cubit.dart';
import 'package:tontino/models/user.dart';
import 'package:tontino/screens/CodeQr.dart';
import 'package:tontino/screens/ContentVlider.dart';
import 'package:tontino/screens/login.dart';
import 'package:tontino/services/Colors.dart';

class Profil extends StatefulWidget {
  const Profil({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  informationApp(BuildContext context, Size size) {
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
                opacity: a1.value,
                child: Container(
                  // height: size.height,
                  width: size.width,
                  padding:
                      EdgeInsets.only(left: 30, right: 30, top: 50, bottom: 50),
                  color: ColorTheme.primaryColorWhite,
                  child: Container(
                    height: size.height * 0.6,
                    width: size.width * 0.5,
                    decoration: BoxDecoration(
                        color: ColorTheme.primaryColorBlue,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Column(
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
                        Container(
                          height: (size.height * 0.6) * 1.2,
                          child: ListView(
                            children: [
                              Container(
                                width: size.width,
                                padding: EdgeInsets.all(15),
                                child: SingleChildScrollView(
                                  child: DefaultTextStyle(
                                    style: TextStyle(
                                        color: ColorTheme.primaryColorWhite,
                                        fontSize: 15,
                                        decorationStyle:
                                            TextDecorationStyle.solid,
                                        fontWeight: FontWeight.bold),
                                    child: HtmlWidget(
                                      // the first parameter (`html`) is required
                                      '''

<div>
    <h2>
        Informations necessaires
    </h2>
    <p>
        Nous avons besoin d'informations pour la creation de votre tontine.
    
    </p>
</div>

<div>
    <h2>
        Nom de votre tontine

    </h2>
    <p>
        Vous pouvez choisir le nom de votre tontine. Choisir un nom qui vous ressemble. Pourquoi pas " Tontine de la famille" ou "Tontine de la classe" ?
    
    </p>
</div>


<div>
    <h2>
        Type de votre tontine


    </h2>
    <p>
        Choisissez le type de votre tontine. Vous pouvez choisir entre une tontine de type "Ordinaire" ou "Avec interet". La tontine de type "Avec interet" est une tontine ou les interets sont partagés entre les membres de la tontine. La tontine de type "Ordinaire" est une tontine ou la somme totale est partagée entre les membres de la tontine.

    </p>
</div>

<div>
    <h2>
        Montant de la tontine

    </h2>
    <p>
        Choisissez le montant de votre tontine. Selectionnez le montant que vous souhaitez mettre dans la tontine.

    </p>
</div>

<div>
    <h2>
        Periodicite de la tontine


    </h2>
    <p>
        La periodicite de la tontine est le nombre de jours entre chaque versement.

    </p>
</div>

<div>
    <h2>
        Participants

    </h2>
    <p>
        Ajoutez autant de participants que vous le souhaitez, des personnes qui vous ressemble, des personnes que vous connaissez. Vous pouvez ajouter des amis, collègues, famille, voisins, etc. Vous ne pouvez pas ajouter des participants qui ne sont pas inscrits sur la plateforme. Pour integrer des participants, invitez les a scanner le QR code de la tontine.


    </p>
</div>
  ''',

                                      // all other parameters are optional, a few notable params:

                                      // specify custom styling for an element
                                      // see supported inline styling below
                                      customStylesBuilder: (element) {
                                        if (element.classes.contains('foo')) {
                                          return {'color': 'red'};
                                        }

                                        return null;
                                      },

                                      // render a custom widget
                                      customWidgetBuilder: (element) {
                                        if (element.attributes['foo'] ==
                                            'bar') {
                                          return null;
                                        }

                                        return null;
                                      },

                                      // turn on selectable if required (it's disabled by default)
                                      isSelectable: true,

                                      // these callbacks are called when a complicated element is loading
                                      // or failed to render allowing the app to render progress indicator
                                      // and fallback widget
                                      onErrorBuilder:
                                          (context, element, error) =>
                                              Text('$element error: $error'),
                                      onLoadingBuilder:
                                          (context, element, loadingProgress) =>
                                              CircularProgressIndicator(),

                                      // this callback will be triggered when user taps a link
                                      // onTapUrl: (url) => print('tapped $url'),

                                      // select the render mode for HTML body
                                      // by default, a simple `Column` is rendered
                                      // consider using `ListView` or `SliverList` for better performance
                                      renderMode: RenderMode.column,

                                      // set the default styling for text
                                      textStyle: TextStyle(fontSize: 14),

                                      // turn on `webView` if you need IFRAME support (it's disabled by default)
                                      webView: true,
                                    ),
                                  ),

                                  //  DefaultTextStyle(
                                  //   style: TextStyle(
                                  //       color: ColorTheme.primaryColorWhite,
                                  //       fontSize: 15,
                                  //       decorationStyle:
                                  //           TextDecorationStyle.solid,
                                  //       fontWeight: FontWeight.bold),
                                  //   child:

                                  //   Text(
                                  //     "Ex duis quis aute est occaecat aliqua laborum qui consectetur ea amet quis officia quis. Ad nostrud ullamco do est aliquip duis veniam culpa proident ullamco Lorem. Qui ipsum consectetur do sunt. Sunt aute occaecat consectetur laboris eu sunt proident ullamco veniam in amet magna. Eu sit amet fugiat irure veniam elit laborum exercitation nostrud. Et eiusmod nostrud voluptate nostrud id. Proident elit cupidatat aliquip nisi." +
                                  //         "Enim adipisicing nulla nostrud eiusmod nulla commodo aliquip voluptate eiusmod amet. Aliqua minim excepteur veniam proident occaecat occaecat anim aute. Enim magna occaecat culpa consequat labore quis esse consequat nostrud ut sint irure nostrud. Do in veniam minim sunt magna aute. Cillum proident commodo consequat labore." +
                                  //         "Ullamco aliqua cillum minim in commodo et sit commodo. Laborum minim dolore laborum tempor enim qui deserunt reprehenderit est irure laborum. Et magna nulla sit ullamco voluptate dolor non laborum ut exercitation dolor non duis do. Adipisicing esse est sit anim laborum consequat ut qui consectetur duis incididunt consequat. Lorem nulla culpa mollit ut commodo excepteur Lorem quis labore nisi. Esse voluptate deserunt nisi aute magna nostrud non.",
                                  //     style: TextStyle(
                                  //         color: ColorTheme.primaryColorWhite,
                                  //         fontSize: 15,
                                  //         decorationStyle:
                                  //             TextDecorationStyle.solid,
                                  //         fontWeight: FontWeight.bold),
                                  //   ),
                                  // ),
                                ),
                              )
                            ],
                          ),
                        ),

                        // CodeQr(
                        //   size: size,
                        //   dataQR: dataQR,
                        //   sizeQRCODE: 150,
                        //   foregroundColor: ColorTheme.primaryColorWhite,
                        // ),
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

  @override
  Widget build(BuildContext context) {
    print(widget.user.id);

    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit, AppState>(
      listener: (appStatecontext, state) {
        // TODO: implement listener

        if (state is AppError) {}

        if (state is AppDeconnexion) {
          Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
        }
      },
      builder: (context, state) {
        if (state is AppLoading) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  height: 220,
                  padding: EdgeInsets.all(10),
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    boxShadow: [
                      BoxShadow(
                        color: ColorTheme.primaryColorYellow.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (() {
                          // getCODEQR(context, size, "Home");
                        }),
                        child: Container(
                            clipBehavior: Clip.hardEdge,
                            height: 100,
                            width: 100,
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorTheme.primaryColorYellow),
                            child: Image.asset("assets/images/user.png")),
                      ),
                      Container(
                          alignment: Alignment.center,
                          child: Text(
                            "${widget.user.nom.toString()} ${widget.user.prenom.toString()}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: (() {
                    informationApp(context, size);
                  }),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Informations Nécessaires",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: ColorTheme.primaryColorWhite)),
                      Icon(
                        Icons.arrow_right_alt_outlined,
                        color: ColorTheme.primaryColorWhite,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                ElevatedButton(
                  onPressed: (() {
                    BlocProvider.of<AppCubit>(context).deconnexion();
                  }),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Déconnexion",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: ColorTheme.primaryColorWhite)),
                        Icon(
                          Icons.arrow_right_alt_outlined,
                          color: ColorTheme.primaryColorWhite,
                        ),
                      ]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
