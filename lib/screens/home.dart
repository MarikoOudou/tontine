import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tontino/models/user.dart';
import 'package:tontino/screens/CodeQr.dart';
import 'package:tontino/screens/CreerTontine.dart';
import 'package:tontino/screens/Profil.dart';
import 'package:tontino/screens/ScreenQrcode.dart';
import 'package:tontino/screens/loading.dart';
import 'package:tontino/screens/login.dart';
import 'package:tontino/screens/mes_tontine/MesTontine.dart';
import 'package:tontino/screens/notification/notifications.dart';
import 'package:tontino/services/Colors.dart';
import 'package:tontino/services/ServiceHttp.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white);

  bool tokenExp = false;

  User user = User();

  String qrcodeEnco = "";

  Map<String, dynamic> historiques = {};

  bool loading = true;

  @override
  initState() {
    // TODO: implement initState
    super.initState();
  }

  loadingUser() async {
    Map<String, dynamic> userget = await user.getUser();
    historiques = await user.historique();
    print("user info  ${userget}");
    print("historique info  ${historiques}");

    if (userget["reponse"]) {
      user = User.fromJsonMap({
        "id": userget["data"]["id"],
        "nom": userget["data"]["nom"],
        "prenom": userget["data"]["prenom"],
        "slug": userget["data"]["slug"],
        "tel": userget["data"]["tel"],
        "solde": userget["data"]["solde"]
      });
      tokenExp = true;

      return user;

      // loading = false;
    } else if (userget["reponse"] == false) {
      return false;
    } else {
      return null;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget homePage(Size size, User user) {
    qrcodeEnco = jsonEncode(jsonEncode({"tel": user.tel}));

    print(qrcodeEnco);
    return Container(
      margin: EdgeInsets.only(top: 5),
      height: size.height - kToolbarHeight - 25,
      width: size.width,
      color: ColorTheme.primaryColorWhite[400],
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            //margin: EdgeInsets.all(6),
            padding: EdgeInsets.all(10),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        margin: EdgeInsets.only(right: 5),
                        child: Image.asset(
                          "assets/images/logo.png",
                          width: 80,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${user.nom} ${user.prenom}".trim(),
                            style: TextStyle(
                                color: ColorTheme.primaryColorWhite,
                                fontFamily: "RobotoMono",
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${user.slug}",
                            style: TextStyle(
                                color: ColorTheme.primaryColorYellow,
                                fontFamily: "RobotoMono",
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                // Container(
                //   child: Ink(
                //     color: Colors.black,
                //     child: InkWell(
                //       onTap: (() {
                //         Navigator.push(context,
                //             MaterialPageRoute(builder: ((context) {
                //           return Notifications();
                //         })));
                //       }),
                //       splashColor: ColorTheme.primaryColorYellow,
                //       child: Icon(
                //         Icons.notifications,
                //         size: 30,
                //         color: Colors.white,
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              height: (size.height - kToolbarHeight - kTextTabBarHeight - 25) *
                  0.92,
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    height: ((size.height -
                                kToolbarHeight -
                                kTextTabBarHeight -
                                25) *
                            0.8) *
                        0.4,
                    padding: EdgeInsets.all(20),
                    width: size.width,
                    decoration: BoxDecoration(
                      color: ColorTheme.primaryColorBlue,
                      // gradient: LinearGradient(
                      //   colors: [Color(0xff004f71), Color(0xffffc304)],
                      //   begin: Alignment.bottomLeft,
                      //   end: Alignment.topRight,
                      // ),
                      boxShadow: [
                        BoxShadow(
                          color: ColorTheme.primaryColorYellow.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // color: Colors.black,
                          alignment: Alignment.centerLeft,
                          height: ((size.height * 0.79) * 0.2) * 0.8,
                          width: (size.height * 0.25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Solde",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "RobotoMono",
                                      fontSize: size.width * 0.05,
                                      fontWeight: FontWeight.bold)),
                              Text("${user.solde} FCFA",
                                  style: TextStyle(
                                      color: ColorTheme.primaryColorYellow,
                                      fontFamily: "RobotoMono",
                                      fontSize: size.width * 0.06,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: (() {
                            getCODEQR(context, size, qrcodeEnco);
                          }),
                          child: CodeQr(
                            size: size,
                            dataQR: qrcodeEnco,
                            sizeQRCODE: ((size.height -
                                        kToolbarHeight -
                                        kTextTabBarHeight -
                                        25) *
                                    0.9) *
                                0.2,
                            foregroundColor: ColorTheme.primaryColorWhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: ColorTheme.primaryColorBlue,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color:
                                ColorTheme.primaryColorBlack.withOpacity(0.8),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Menu Tontine",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "RobotoMono",
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          child: Divider(
                            thickness: 1,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            InkWell(
                              splashColor: Colors.grey,
                              onTap: (() {
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: ((context) {
                                  return CreerTontine(size: size);
                                })));
                              }),
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 40,
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xff004f71),
                                              Color(0xffffc304)
                                            ],
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight,
                                          )),
                                      child: Icon(
                                        Icons.add,
                                        // size: 40,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text("Créer",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "RobotoMono",
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.grey,
                              onTap: (() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => MesTontine())));
                              }),
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 40,
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xff004f71),
                                              Color(0xffffc304),
                                            ],
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight,
                                          )),
                                      child: Icon(
                                        Icons.list_rounded,
                                        // size: 40,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text("Mes Tontines",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "RobotoMono",
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: (size.height * 0.79) * 0.5,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: ColorTheme.primaryColorBlue,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color:
                                ColorTheme.primaryColorBlack.withOpacity(0.8),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ]),
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Historique des transactions",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "RobotoMono",
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          child: Divider(
                            thickness: 1,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                            child: SizedBox(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: historiques["data"] == null
                                  ? 0
                                  : historiques["data"]!.length,
                              itemBuilder: ((context, index) {
                                Map<String, dynamic> historique =
                                    historiques["data"][index];
                                return ListTile(
                                  leading: Container(
                                    height: 40,
                                    width: 40,
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xff004f71),
                                            Color(0xffffc304)
                                          ],
                                          begin: Alignment.bottomLeft,
                                          end: Alignment.topRight,
                                        )),
                                    child: Icon(
                                      historique['type'] == "transfert"
                                          ? Icons.send
                                          : Icons.receipt,
                                      // size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                  // title: Text(
                                  //   "Nom Et Prenom",
                                  //   style: optionStyle,
                                  // ),
                                  title: Text(
                                    (historique['type'] == "transfert"
                                            ? "Tranfert"
                                            : "Cotisation")
                                        .toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: ColorTheme.primaryColorYellow),
                                  ),
                                  trailing: Text(
                                    "${historique['montant']} FCFA",
                                    style: optionStyle,
                                  ),
                                );
                              })),
                        )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<Widget> _widgetOptions = <Widget>[
      homePage(size, user),
      Profil(
        user: user,
      ),
    ];

    return FutureBuilder(
        future: loadingUser(),
        builder: ((context, snapshot) {
          dynamic userData = snapshot.data;

          print("Information  ${userData}");

          if (userData == null) {
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

          if (userData == false) {
            return Login();
          }

          return Scaffold(
            appBar: PreferredSize(
                child: AppBar(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: ColorTheme.primaryColorBlue,
                  ),
                  centerTitle: true,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        scale: 12,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'FlutterBeads',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                preferredSize: Size.zero),
            body: Container(
              child: <Widget>[
                userData != null
                    ? homePage(size, userData)
                    : Container(
                        child: Center(
                          child: Text("Erreur de chargement des données"),
                        ),
                      ),
                Profil(
                  user: user,
                ),
              ].elementAt(_selectedIndex),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return ScreenQrcode(
                    typeScanner: 0,
                  );
                })));
              },
              backgroundColor: Colors.transparent,
              child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xff004f71), Color(0xffffc304)],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: ColorTheme.primaryColorYellow.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Icon(Icons.qr_code_scanner_sharp)),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              clipBehavior: Clip.antiAlias,
              child: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  /*BottomNavigationBarItem(
              icon: Icon(Icons.qr_code),
              label: 'Code QR a Scanner',
            ),*/
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline_rounded),
                    label: 'Profil',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: ColorTheme.primaryColorYellow,
                backgroundColor: ColorTheme.primaryColorBlue,
                unselectedItemColor: ColorTheme.primaryColorWhite,
                onTap: _onItemTapped,
              ),
            ),
          );
        }));
  }

  getCODEQR(BuildContext context, Size size, String dataQR) {
    print("QRCODE GEN ............................ ${dataQR}");
    //  print("QRCODE GEN ............................ ${jsonEncode(dataQR)}");
    print(
        "QRCODE GEN ............................ ${jsonDecode(jsonDecode(dataQR))}");

    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
                opacity: a1.value,
                child: Container(
                  height: size.height,
                  width: size.width,
                  padding: EdgeInsets.only(
                      left: 30, right: 30, top: 100, bottom: 100),
                  color: ColorTheme.primaryColorWhite,
                  child: Container(
                    height: size.height * 0.6,
                    width: size.width * 0.5,
                    decoration: BoxDecoration(
                        color: ColorTheme.primaryColorBlue,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Stack(
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
                        CodeQr(
                          size: size,
                          dataQR: dataQR,
                          sizeQRCODE: 150,
                          foregroundColor: ColorTheme.primaryColorWhite,
                        ),
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
}
