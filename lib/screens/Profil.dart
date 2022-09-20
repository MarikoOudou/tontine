import 'package:flutter/material.dart';
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
  @override
  @override
  Widget build(BuildContext context) {
    print(widget.user.id);

    Size size = MediaQuery.of(context).size;
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

            Container(
              margin: EdgeInsets.only(bottom: 10, top: 10),
              height: 60,
              padding: EdgeInsets.all(5),
              width: size.width,
              decoration: BoxDecoration(
                color: ColorTheme.primaryColorBlue,
                boxShadow: [
                  BoxShadow(
                    color: ColorTheme.primaryColorYellow.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
                // color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                onTap: (() {
                  informationApp(context, size);
                }),
                title: Text("Informations Nécessaires",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ColorTheme.primaryColorWhite)),
                trailing: Container(
                  child: IconButton(
                      onPressed: (() {}),
                      icon: Icon(
                        Icons.arrow_right_alt_outlined,
                        color: ColorTheme.primaryColorWhite,
                      )),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(bottom: 10, top: 10),
              height: 60,
              padding: EdgeInsets.all(5),
              width: size.width,
              decoration: BoxDecoration(
                color: ColorTheme.primaryColorBlue,
                boxShadow: [
                  BoxShadow(
                    color: ColorTheme.primaryColorYellow.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
                // color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                onTap: (() {
                  widget.user.deconnexion();
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) {
                    return Login();
                  })));

                  // FutureBuilder(
                  //     future: widget.user.deconnexion(),
                  //     builder: ((context, snapshot) {
                  //       print(snapshot.data);
                  //       if (snapshot.data == null) {
                  //         ContenteValidation(
                  //             size: size,
                  //             textValidate: "VOUS ETES DECONNECTE",
                  //             errorResp: 1,
                  //             loading: true);
                  //       }

                  //       return Login();
                  //     }));

                  //  Navigator.pushAndRemoveUntil(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) =>
                  //             Login()), // this mymainpage is your page to refresh
                  //     (Route<dynamic> route) => false,
                  //   );
                }),
                title: Text("Déconnexion",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ColorTheme.primaryColorWhite)),
                trailing: Container(
                  child: IconButton(
                      onPressed: (() {}),
                      icon: Icon(
                        Icons.arrow_right_alt_outlined,
                        color: ColorTheme.primaryColorWhite,
                      )),
                ),
              ),
            ),

            // Container(
            //   margin: EdgeInsets.only(bottom: 10, top: 10),
            //   height: 300,
            //   padding: EdgeInsets.all(13),
            //   width: size.width,
            //   decoration: BoxDecoration(
            //     color: ColorTheme.primaryColorBlue,
            //     boxShadow: [
            //       BoxShadow(
            //         color: ColorTheme.primaryColorYellow.withOpacity(0.2),
            //         spreadRadius: 2,
            //         blurRadius: 4,
            //         offset: Offset(0, 1), // changes position of shadow
            //       ),
            //     ],
            //     // color: Colors.white,
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   child: Text(
            //     "Nisi magna non ex incididunt consectetur veniam dolore.Do culpa laboris duis ipsum veniam et esse esse mollit Lorem nisi fugiat. Lorem mollit voluptate culpa officia in qui excepteur quis proident pariatur reprehenderit excepteur do veniam. Sit in veniam voluptate sit duis qui exercitation reprehenderit consectetur do. Et ut sit id consequat Lorem velit elit qui laborum quis anim. Laborum pariatur nisi deserunt in aute." +
            //         "Veniam esse cillum culpa ullamco id sit. Consequat nisi laboris adipisicing adipisicing fugiat enim ipsum aliquip excepteur ex commodo nisi pariatur. Aute pariatur excepteur enim adipisicing do occaecat. Commodo et et est esse do dolore ad ad mollit laboris dolore nulla fugiat." +
            //         "Dolore labore culpa proident duis laborum id ea magna sint incididunt aliqua occaecat. Aliqua aliquip ex id excepteur exercitation do ea dolore consectetur dolore excepteur eiusmod. Labore elit sit officia ipsum laboris.",
            //     style: TextStyle(
            //         fontSize: 18, color: ColorTheme.primaryColorWhite),
            //   ),
            // ),
            // Container(
            //   margin: EdgeInsets.only(bottom: 10, top: 10),
            //   height: 60,
            //   padding: EdgeInsets.all(5),
            //   width: size.width,
            //   decoration: BoxDecoration(
            //     color: ColorTheme.primaryColorBlue,
            //     boxShadow: [
            //       BoxShadow(
            //         color: ColorTheme.primaryColorYellow.withOpacity(0.2),
            //         spreadRadius: 2,
            //         blurRadius: 4,
            //         offset: Offset(0, 1), // changes position of shadow
            //       ),
            //     ],
            //     // color: Colors.white,
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   child: ListTile(
            //     onTap: (() {}),
            //     title: Text("data",
            //         style: TextStyle(
            //             fontSize: 16,
            //             fontWeight: FontWeight.bold,
            //             color: ColorTheme.primaryColorWhite)),
            //     trailing: Container(
            //       child: IconButton(
            //           onPressed: (() {}),
            //           icon: Icon(
            //             Icons.arrow_right_alt_outlined,
            //             color: ColorTheme.primaryColorWhite,
            //           )),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

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
                                padding: EdgeInsets.all(10),
                                child: Center(
                                  child: Text(
                                    "Informations Nécessaires".toUpperCase(),
                                    style: TextStyle(
                                        color: ColorTheme.primaryColorWhite,
                                        fontSize: 15,
                                        decorationStyle:
                                            TextDecorationStyle.solid,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                width: size.width,
                                padding: EdgeInsets.all(15),
                                child: SingleChildScrollView(
                                  child: Text(
                                    "Ex duis quis aute est occaecat aliqua laborum qui consectetur ea amet quis officia quis. Ad nostrud ullamco do est aliquip duis veniam culpa proident ullamco Lorem. Qui ipsum consectetur do sunt. Sunt aute occaecat consectetur laboris eu sunt proident ullamco veniam in amet magna. Eu sit amet fugiat irure veniam elit laborum exercitation nostrud. Et eiusmod nostrud voluptate nostrud id. Proident elit cupidatat aliquip nisi." +
                                        "Enim adipisicing nulla nostrud eiusmod nulla commodo aliquip voluptate eiusmod amet. Aliqua minim excepteur veniam proident occaecat occaecat anim aute. Enim magna occaecat culpa consequat labore quis esse consequat nostrud ut sint irure nostrud. Do in veniam minim sunt magna aute. Cillum proident commodo consequat labore." +
                                        "Ullamco aliqua cillum minim in commodo et sit commodo. Laborum minim dolore laborum tempor enim qui deserunt reprehenderit est irure laborum. Et magna nulla sit ullamco voluptate dolor non laborum ut exercitation dolor non duis do. Adipisicing esse est sit anim laborum consequat ut qui consectetur duis incididunt consequat. Lorem nulla culpa mollit ut commodo excepteur Lorem quis labore nisi. Esse voluptate deserunt nisi aute magna nostrud non.",
                                    style: TextStyle(
                                        color: ColorTheme.primaryColorWhite,
                                        fontSize: 15,
                                        decorationStyle:
                                            TextDecorationStyle.solid,
                                        fontWeight: FontWeight.bold),
                                  ),
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
}
