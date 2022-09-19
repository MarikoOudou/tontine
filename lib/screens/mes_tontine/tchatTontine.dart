import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:tontino/services/Colors.dart';

class TchatTontine extends StatefulWidget {
  const TchatTontine({Key? key, required this.id_tontine, required this.size})
      : super(key: key);

  final dynamic id_tontine;
  final Size size;

  @override
  _TchatTontineState createState() => _TchatTontineState();
}

class _TchatTontineState extends State<TchatTontine> {
  final fieldText = TextEditingController();
  void clearText() {
    fieldText.clear();
  }

  final _formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> messages = [
    {
      "text": "Yes sure",
      "date": DateTime.now().subtract(Duration(milliseconds: 1, days: 8)),
      "sendBy": {
        "nom": "Kone",
        "prenom": "Ali",
        "tel": "01075735",
      },
      "isSendBy": false
    },
    {
      "text": "Veniam aute sint ad proident Lorem.",
      "date": DateTime.now().subtract(Duration(milliseconds: 3, days: 2)),
      "sendBy": {
        "nom": "mariko",
        "prenom": "oudou",
        "tel": "01075735",
      },
      "isSendBy": true
    },
    {
      "text": "Veniam aute voluptate id minim Lorem ipsum sint n.",
      "date": DateTime.now().subtract(Duration(milliseconds: 10)),
      "sendBy": {
        "nom": "mariko",
        "prenom": "oudou",
        "tel": "01075735",
      },
      "isSendBy": true
    },
    {
      "text":
          "Vipsum sint nostrud pariatur consectetur sint ad proident Lorem.",
      "date": DateTime.now().subtract(Duration(milliseconds: 15)),
      "sendBy": {
        "nom": "Salif",
        "prenom": "Ben",
        "tel": "01075735",
      },
      "isSendBy": false
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Message du tontine ${widget.id_tontine}'),
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
            child: GroupedListView<Map<String, dynamic>, DateTime>(
              padding: EdgeInsets.all(8),
              elements: messages,
              reverse: true,
              order: GroupedListOrder.DESC,
              groupBy: ((message) => DateTime(
                    message["date"].year,
                    message["date"].month,
                    message["date"].day,
                  )),
              groupHeaderBuilder: ((dynamic message) => SizedBox(
                    height: 40,
                    child: Center(
                      child: Card(
                        color: Theme.of(context).primaryColor,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            DateFormat.yMMMd().format(message["date"]),
                            style:
                                TextStyle(color: ColorTheme.primaryColorWhite),
                          ),
                        ),
                      ),
                    ),
                  )),
              itemBuilder: ((Context, dynamic message) => Align(
                    alignment: message["isSendBy"]
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Card(
                      color: message["isSendBy"]
                          ? ColorTheme.primaryColorWhite
                          : ColorTheme.primaryColorYellow,
                      elevation: 8,
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Text(
                              message["sendBy"]["nom"],
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: ColorTheme.primaryColorBlue),
                            ),
                            Text(message["text"]),
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
          )),
          Row(
            children: [
              Container(
                width: widget.size.width * 0.85,
                child: Form(
                  key: _formKey,
                  child: TextField(
                    onSubmitted: ((value) {
                      final Map<String, dynamic> message = {
                        "text": value,
                        "date": DateTime.now(),
                        "sendBy": {
                          "nom": "Kone",
                          "prenom": "Ali",
                          "tel": "01075735",
                        },
                        "isSendBy": true
                      };
                    }),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(12),
                        hintText: "Message"),
                  ),
                ),
              ),
              IconButton(
                splashRadius: 10,
                splashColor: ColorTheme.primaryColorYellow,
                style: ButtonStyle(),
                onPressed: (() {
                  clearText();
                  _formKey.currentState?.reset();

                  setState(() {});
                }),
                icon: Icon(
                  Icons.send,
                  color: ColorTheme.primaryColorBlue,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
