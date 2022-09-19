import 'package:flutter/material.dart';
import 'package:tontino/models/user.dart';
import 'package:tontino/screens/CodeQr.dart';
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
                onTap: (() {}),
                title: Text("data",
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
}
