import 'package:flutter/material.dart';
import 'package:tontino/models/Tontine.dart';
import 'package:tontino/screens/ContentVlider.dart';
import 'package:tontino/services/Colors.dart';

class RetardPaye extends StatefulWidget {
  const RetardPaye({Key? key, required this.tontine}) : super(key: key);

  final Tontine tontine;
  @override
  _RetardPayeState createState() => _RetardPayeState();
}

class _RetardPayeState extends State<RetardPaye> {
  Map<String, dynamic> dataMember = {};

  Tontine delectMember = Tontine();

  RemoveMember(Map<String, dynamic> dataMember) async {
    return await delectMember.removeMember(dataMember);
  }

  final TextStyle textStyleTitle = TextStyle(
      color: Colors.white,
      fontFamily: "RobotoMono",
      fontSize: 16,
      fontWeight: FontWeight.w500);

  final TextStyle textStyleSub = TextStyle(
      color: ColorTheme.primaryColorYellow,
      fontFamily: "RobotoMono",
      fontSize: 14,
      fontWeight: FontWeight.w500);

  final TextStyle textStyleTrailling = TextStyle(
      color: Colors.white,
      fontFamily: "RobotoMono",
      fontSize: 16,
      fontWeight: FontWeight.w500);

  List<dynamic> dataTontins = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    dataTontins = widget.tontine.avancement["retard"]!;
    print("Members .................................. : ${dataTontins}");
    return Scaffold(
        appBar: AppBar(
          title: const Text('Rétard de paiement'),
          centerTitle: true,
          // actions: [IconButton(onPressed: (() {}), icon: Icon(Icons.search))],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            height: size.height * 0.9,
            child: Container(
              width: size.width,
              color: ColorTheme.primaryColorWhite[400],
              margin: EdgeInsets.only(top: 0, bottom: 10),
              child: ListView.builder(
                itemCount: dataTontins.length,
                itemBuilder: ((context, index) {
                  dynamic tontine = dataTontins[index];
                  return Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                        color: ColorTheme.primaryColorBlue,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color:
                                ColorTheme.primaryColorBlack.withOpacity(0.8),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ]),
                    child: ListTile(
                      title: Text(
                        tontine != null
                            ? "${tontine!["nom"]} ${tontine!["prenom"]}"
                            : "vide",
                        style: textStyleTitle,
                      ),
                      subtitle: Text(
                        "${widget.tontine.periodicite}",
                        style: textStyleSub,
                      ),
                      trailing: Text(
                        "${widget.tontine.montant} FCFA",
                        style: textStyleSub,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ));
  }
}
