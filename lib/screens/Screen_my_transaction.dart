import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tontino/models/user.dart';
import 'package:tontino/services/Colors.dart';

class ScreenMyTransaction extends StatefulWidget {
  const ScreenMyTransaction({Key? key, required this.id}) : super(key: key);

  final dynamic id;

  @override
  _ScreenMyTransactionState createState() => _ScreenMyTransactionState();
}

class _ScreenMyTransactionState extends State<ScreenMyTransaction> {
  dynamic transaction = {};

  User user = User();

  getTransaction(dynamic id_transaction) async {
    return await user.getTransactionById(id_transaction);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Détails de transcation'),
      ),
      body: FutureBuilder(
          future: getTransaction(widget.id),
          builder: ((context, snapshot) {
            if (snapshot.data == null) {
              print("PAS ENCORE DISPO");

              return Container(
                color: ColorTheme.primaryColorBlue,
                child: Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: ColorTheme.primaryColorYellow,
                    size: 200,
                  ),
                ),
              );
            }

            transaction = snapshot.data;
            print("DISPO :: $transaction");

            return Container(
              height: size.height - kToolbarHeight,
              padding: EdgeInsets.only(right: 10, left: 10, top: 10),
              child: Column(
                children: [
                  getInfo(transaction),
                  SizedBox(
                    height: 10,
                  ),
                  detailInfoTransaction(transaction),
                ],
              ),
            );
          })),
    );
  }

  Widget getInfo(dynamic transaction) {
    return Card(
        color: ColorTheme.primaryColorBlue,
        child: Container(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "${transaction['data']['object']['signe']}${transaction['data']['object']['montant']} F CFA",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: ColorTheme.primaryColorWhite),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  transaction['data']['object']['sdr'] == "Système"
                      ? Text("De MTN MoMo",
                          style: TextStyle(
                              fontSize: 16,
                              // fontWeight: FontWeight.bold,
                              color: ColorTheme.primaryColorWhite))
                      : transaction['data']['object']['signe'] == "+"
                          ? Text("De ${transaction['data']['object']!['sdr']}",
                              style: TextStyle(
                                  fontSize: 16,
                                  // fontWeight: FontWeight.bold,
                                  color: ColorTheme.primaryColorWhite))
                          : Text("De Moi meme",
                              style: TextStyle(
                                  fontSize: 16,
                                  // fontWeight: FontWeight.bold,
                                  color: ColorTheme.primaryColorWhite)),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: ColorTheme.primaryColorYellow),
                      child: Text(
                        "${transaction['data']['object']['type']}",
                        style: TextStyle(
                            color: ColorTheme.primaryColorBlue,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
              Container(
                  child: transaction['data']['object']['type'] == "transfert"
                      ? Image.asset("assets/images/transfert.png")
                      : transaction['data']['object']['type'] == "Dépôt"
                          ? SvgPicture.asset(
                              "assets/images/mtnmomo.svg",
                              width: 50,
                            )
                          : transaction['data']['object']['type'] ==
                                  "Cotisation" //retrait
                              ? Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: ColorTheme.primaryColorYellow),
                                  child: Icon(
                                    Icons.account_balance_wallet,
                                    color: ColorTheme.primaryColorWhite,
                                  ),
                                )
                              : transaction['data']['object']['type'] ==
                                      "Retrait"
                                  ? SvgPicture.asset(
                                      "assets/images/mtnmomo.svg",
                                      width: 50,
                                    )
                                  : Container(
                                      height: 50,
                                      width: 50,
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: ColorTheme.primaryColorYellow),
                                      child: Image.asset(
                                          "assets/images/transfert.png")))
            ],
          ),
        ));
  }

  Widget detailInfoTransaction(dynamic transaction) {
    return Container(
      // height: 200,
      padding: EdgeInsets.only(top: 25, right: 15, left: 15, bottom: 25),
      decoration: BoxDecoration(
          color: ColorTheme.primaryColorBlue,
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Date & Heure",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorTheme.primaryColorWhite)),
              Text(transaction['data']['object']['date'],
                  style: TextStyle(
                      fontSize: 14,
                      // fontWeight: FontWeight.bold,
                      color: ColorTheme.primaryColorYellow)),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Statut",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorTheme.primaryColorWhite)),
              Text(transaction['data']['object']['state'],
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: transaction['data']['object']['state'] ==
                              "En cours" // Annulé
                          ? Colors.yellow.shade300
                          : transaction['data']['object']['state'] == "Annulé"
                              ? Colors.red.shade300
                              : Colors.green.shade300)),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Operateur",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorTheme.primaryColorWhite)),
              Text(transaction['data']['object']['operateur'],
                  style: TextStyle(
                      fontSize: 14,
                      // fontWeight: FontWeight.bold,
                      color: ColorTheme.primaryColorYellow)),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Frais",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorTheme.primaryColorWhite)),
              Text("0 CFA",
                  style: TextStyle(
                      fontSize: 14,
                      // fontWeight: FontWeight.bold,
                      color: ColorTheme.primaryColorYellow)),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Montant (avec frais)",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorTheme.primaryColorWhite)),
              Text("${transaction['data']['object']['montant'].toString()} CFA",
                  style: TextStyle(
                      fontSize: 14,
                      // fontWeight: FontWeight.bold,
                      color: ColorTheme.primaryColorYellow)),
            ],
          )
        ],
      ),
    );
  }
}
