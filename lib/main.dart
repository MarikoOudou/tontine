import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tontino/screens/home.dart';
import 'package:tontino/screens/login.dart';
import 'package:tontino/screens/transfert/transfert.dart';
import 'package:tontino/services/Colors.dart';
import 'package:tontino/services/ServiceHttp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  getto() async {
    var servicephone = await Permission.phone;
    var servicelocation = await Permission.location;
  }

  ServiceHttp serviceHttp = ServiceHttp();

  String authorization = "Bearer ";
  String? token;

  getToken() async {
    return await serviceHttp.getToken();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getToken();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tontine',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: ColorTheme.primaryColorBlue,
      ),
      home: FutureBuilder(
          future: getToken(),
          builder: ((context, snapshot) {
            token = snapshot.data.toString();
            print("TOKEN ::::::::::: ${token}");
            if (token != null) {
              authorization = authorization + token!;
            }

            if (snapshot.data == null) {
              return Login();
            }

            return Home();
          })),
    );
  }
}
