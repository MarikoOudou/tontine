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
import 'package:tontino/screens/momo_service/screen_depot.dart';
import 'package:tontino/screens/momo_service/screen_recharge.dart';
import 'package:tontino/screens/momo_service/screen_retrait.dart';
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
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(Duration(seconds: 6));
        // loadingUser();
      },
      child: Container(
        margin: EdgeInsets.only(top: 5),
        height: size.height - kToolbarHeight - 25,
        width: size.width,
        color: ColorTheme.primaryColorWhite[400],
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            getHeader(user),
            getBody(size, user),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView getBody(Size size, User user) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        height: (size.height - kToolbarHeight - kTextTabBarHeight - 25) * 0.95,
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              height: ((size.height - kToolbarHeight - kTextTabBarHeight - 25) *
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
                        Text("Compte principal",
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
                                fontSize: size.width * 0.045,
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
              ),
              child: getMenu(size, user.tel.toString()),
            ),
            Container(
              height: (size.height * 0.79) * 0.4,
              width: size.width,
              decoration: BoxDecoration(
                color: ColorTheme.primaryColorBlue,
                borderRadius: BorderRadius.circular(10),
                // boxShadow: [
                //   BoxShadow(
                //     color: ColorTheme.primaryColorBlack.withOpacity(0.8),
                //     spreadRadius: 2,
                //     blurRadius: 4,
                //     offset: Offset(0, 1), // changes position of shadow
                //   ),
                // ]
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 10),
              child: getMyTransaction(),
            )
          ],
        ),
      ),
    );
  }

  Container getHeader(User user) {
    return Container(
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
    );
  }

  Column getMyTransaction() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 0),
          child: Text(
            "Historique des transactions",
            style: TextStyle(
                color: ColorTheme.primaryColorYellow,
                fontFamily: "RobotoMono",
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          child: Divider(
            thickness: 1,
            color: ColorTheme.primaryColorYellow,
          ),
        ),
        Expanded(
            child: SizedBox(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount:
                  historiques["data"] == null ? 0 : historiques["data"]!.length,
              itemBuilder: ((context, index) {
                Map<String, dynamic> historique = historiques["data"][index];
                return ListTile(
                  leading: Container(
                    height: 40,
                    width: 40,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [Color(0xff004f71), Color(0xffffc304)],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        )),
                    child: historique['type'] == "transfert"
                        ? Image.asset("assets/images/transfert.png")
                        : historique['type'] == "depot"
                            ? Image.asset("assets/images/depot.png")
                            : historique['type'] ==
                                    "tontine_cotisation" //retrait
                                ? Icon(
                                    Icons.account_balance_wallet,
                                    color: ColorTheme.primaryColorWhite,
                                  )
                                : historique['type'] == "retrait"
                                    ? Image.asset("assets/images/money.png")
                                    : Image.asset(
                                        "assets/images/transfert.png"),
                  ),
                  // title: Text(
                  //   "Nom Et Prenom",
                  //   style: optionStyle,
                  // ),
                  title: Text(
                    (historique['type'] == "transfert"
                            ? "Tranfert"
                            : historique['type'] == "depot"
                                ? "Dépot"
                                : historique['type'] == "retrait"
                                    ? "Rétrait"
                                    : "Cotisation")
                        .toUpperCase(),
                    style: TextStyle(
                        fontSize: 14, color: ColorTheme.primaryColorWhite),
                  ),
                  subtitle: Text(
                    historique['lib'],
                    style: TextStyle(
                        fontSize: 14, color: ColorTheme.primaryColorYellow),
                  ),
                  trailing: Text(
                    "${historique['montant']} FCFA",
                    style: optionStyle,
                  ),
                );
              })),
        )),
      ],
    );
  }

  Column getMenu(Size size, String tel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 0),
          child: Text(
            "Menu",
            style: TextStyle(
                color: ColorTheme.primaryColorYellow,
                fontFamily: "RobotoMono",
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          child: Divider(
            thickness: 1,
            color: ColorTheme.primaryColorYellow,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            InkWell(
              splashColor: Colors.grey,
              onTap: (() {
                // showSearch(context: context, delegate: delegate)
                showModalBottomSheet<void>(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 240,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: ColorTheme.primaryColorBlue,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  child: const Text(
                                    'Créer une tontine',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: ((context) {
                                      return CreerTontine(size: size);
                                    })));
                                  },
                                  style: ButtonStyle(
                                      minimumSize:
                                          MaterialStateProperty.all<Size>(Size(
                                              size.width * 0.9,
                                              (size.height - kToolbarHeight) *
                                                  0.07)),
                                      maximumSize:
                                          MaterialStateProperty.all<Size>(Size(
                                              size.width * 0.9,
                                              (size.height - kToolbarHeight) *
                                                  0.07)),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              ColorTheme.primaryColorYellow),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            side: BorderSide(
                                                color: ColorTheme
                                                    .primaryColorYellow)),
                                      ))),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  child: const Text(
                                    'Voir Mes Tontines',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: ((context) {
                                      return MesTontine();
                                    })));
                                  },
                                  style: ButtonStyle(
                                      minimumSize:
                                          MaterialStateProperty.all<Size>(Size(
                                              size.width * 0.9,
                                              (size.height - kToolbarHeight) *
                                                  0.07)),
                                      maximumSize:
                                          MaterialStateProperty.all<Size>(Size(
                                              size.width * 0.9,
                                              (size.height - kToolbarHeight) *
                                                  0.07)),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              ColorTheme.primaryColorYellow),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            side: BorderSide(
                                                color: ColorTheme
                                                    .primaryColorYellow)),
                                      ))),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
                // Navigator.push(context,
                //     MaterialPageRoute(builder: ((context) => MesTontine())));
                // showGeneralDialog(
                //     transitionDuration: Duration(milliseconds: 20),
                //     barrierDismissible: true,
                //     barrierLabel: 'Tester',
                //     context: context,
                //     pageBuilder: ((context, animation, secondaryAnimation) {
                //       return SizedBox(
                //         height: 200,
                //         child: Container(
                //           decoration: BoxDecoration(
                //               color: ColorTheme.primaryColorWhite,
                //               borderRadius: BorderRadius.circular(30)),
                //           child: Center(
                //             child: Text("text"),
                //           ),
                //         ),
                //       );
                //     }));
              }),
              child: Container(
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xff004f71),
                              Color(0xffffc304),
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          )),
                      child: const Icon(
                        Icons.account_balance_wallet,
                        // size: 40,
                        color: Colors.white,
                      ),
                    ),
                    const Text("Tontine",
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
                        builder: ((context) => ScreenDepot(
                              tel: tel,
                            ))));
              }),
              child: Container(
                child: Column(
                  children: [
                    Container(
                        height: 40,
                        width: 40,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                              colors: [
                                Color(0xff004f71),
                                Color(0xffffc304),
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                            )),
                        child: Image.asset("assets/images/depot.png")),
                    Text("Dépot",
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
                        builder: ((context) => ScreenRetrait(
                              tel: tel,
                            ))));
              }),
              child: Container(
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xff004f71),
                              Color(0xffffc304),
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          )),
                      child: Image.asset("assets/images/money.png"),
                    ),
                    const Text("Rétrait",
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
    );
  }

  dynamic userData = {};

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
        future: loadingUser(),
        builder: ((context, snapshot) {
          userData = snapshot.data;

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
                // ignore: sort_child_properties_last
                child: AppBar(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: ColorTheme.primaryColorBlue,
                  ),
                ),
                preferredSize: Size.zero),
            body: SizedBox(
              height: size.height,
              child: RefreshIndicator(
                key: _refreshIndicatorKey,
                color: ColorTheme.primaryColorBlue,
                backgroundColor: ColorTheme.primaryColorYellow,
                strokeWidth: 4.0,
                onRefresh: () async {
                  userData = await loadingUser();
                  setState(() {});
                  return userData;
                },
                child: ListView(
                  children: [
                    <Widget>[
                      userData != null
                          ? homePage(size, userData)
                          : const Center(
                              child: Text("Erreur de chargement des données"),
                            ),
                      Profil(
                        user: user,
                      ),
                    ].elementAt(_selectedIndex),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return const ScreenQrcode(
                    typeScanner: 0,
                  );
                })));
              },
              backgroundColor: Colors.transparent,
              child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xff004f71), Color(0xffffc304)],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: ColorTheme.primaryColorYellow.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ],
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
