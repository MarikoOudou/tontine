import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:tontino/services/Colors.dart';

class InfoTontineScreen extends StatelessWidget {
  const InfoTontineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('INFORMATION '),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: size.height - kToolbarHeight - 24,
        decoration: BoxDecoration(color: ColorTheme.primaryColorBlue),

        // height: size.height * 2,
        child: informationApp(context, size),

        // Column(
        //   children: [
        //     SizedBox(
        //       // height: (size.height - kToolbarHeight - 24) * 0.8,
        //       child: informationApp(context, size),
        //     ),
        //     // Container(
        //     //     // height: (size.height - kToolbarHeight - 24) * 0.2,
        //     //     child: Container(
        //     //   // width: double.infinity,
        //     //   height: size.height * 0.08,

        //     //   padding: EdgeInsets.only(right: 15, left: 15, bottom: 15),

        //     //   child: Align(
        //     //     alignment: Alignment.topRight,
        //     //     child: SizedBox(
        //     //       width: 130,
        //     //       child: TextButton(
        //     //         style: ButtonStyle(
        //     //             backgroundColor: MaterialStateProperty.all(
        //     //                 ColorTheme.primaryColorYellow)),
        //     //         onPressed: (() {
        //     //           Navigator.pushReplacementNamed(
        //     //             context,
        //     //             "/createtontine",
        //     //           );
        //     //         }),
        //     //         child: Row(
        //     //           crossAxisAlignment: CrossAxisAlignment.center,
        //     //           mainAxisAlignment: MainAxisAlignment.center,
        //     //           children: [
        //     //             Text("Continer"),
        //     //             Icon(Icons.skip_next_sharp)
        //     //           ],
        //     //         ),
        //     //       ),
        //     //     ),
        //     //   ),
        //     // ))
        //   ],
        // )

        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     informationApp(context, size),
        //     // Container(
        //     //   // width: double.infinity,
        //     //   height: size.height * 0.08,

        //     //   padding: EdgeInsets.only(right: 15, left: 15, bottom: 15),

        //     //   child: Align(
        //     //     alignment: Alignment.topRight,
        //     //     child: SizedBox(
        //     //       width: 130,
        //     //       child: TextButton(
        //     //         style: ButtonStyle(
        //     //             backgroundColor: MaterialStateProperty.all(
        //     //                 ColorTheme.primaryColorYellow)),
        //     //         onPressed: (() {
        //     //           Navigator.pushReplacementNamed(
        //     //             context,
        //     //             "/createtontine",
        //     //           );
        //     //         }),
        //     //         child: Row(
        //     //           crossAxisAlignment: CrossAxisAlignment.center,
        //     //           mainAxisAlignment: MainAxisAlignment.center,
        //     //           children: [Text("Continer"), Icon(Icons.skip_next_sharp)],
        //     //         ),
        //     //       ),
        //     //     ),
        //     //   ),
        //     // )
        //   ],
        // )
      ),
    );
  }

  informationApp(BuildContext context, Size size) {
    return Scrollbar(
      isAlwaysShown: true, //always show scrollbar
      thickness: 10, //width of scrollbar
      radius: Radius.circular(20), //corner radius of scrollbar
      scrollbarOrientation: ScrollbarOrientation.right,
      child: Column(
        children: [
          Container(
            // height: 200,
            height: (size.height - kToolbarHeight - 24) * 0.91,

            child: SingleChildScrollView(
              child: Container(
                // height: (size.height - kToolbarHeight - 24) * 0.2,
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                child: DefaultTextStyle(
                  style: TextStyle(
                      color: ColorTheme.primaryColorWhite,
                      fontSize: 15,
                      decorationStyle: TextDecorationStyle.solid,
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
                      if (element.attributes['foo'] == 'bar') {
                        return null;
                      }

                      return null;
                    },

                    // turn on selectable if required (it's disabled by default)
                    isSelectable: true,

                    // these callbacks are called when a complicated element is loading
                    // or failed to render allowing the app to render progress indicator
                    // and fallback widget
                    onErrorBuilder: (context, element, error) =>
                        Text('$element error: $error'),
                    onLoadingBuilder: (context, element, loadingProgress) =>
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
              ),
            ),
          ),
          Container(
            // width: double.infinity,
            // height: size.height * 0,
            alignment: Alignment.center,
            padding: EdgeInsets.all(3),

            child: Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                width: 130,
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          ColorTheme.primaryColorYellow)),
                  onPressed: (() {
                    Navigator.pushReplacementNamed(
                      context,
                      "/createtontine",
                    );
                  }),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("Continer"), Icon(Icons.skip_next_sharp)],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
