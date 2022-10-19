import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tontino/logic/cubit/app_cubit.dart';
import 'package:tontino/router/AppRouter.dart';
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
  late AppRouter _appRouter;

  @override
  void initState() {
    // TODO: implement initState
    _appRouter = AppRouter();
    super.initState();

    // getToken();
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

      onGenerateRoute: _appRouter.generateRoute,

      // home: FutureBuilder(
      //     future: getToken(),
      //     builder: ((context, snapshot) {
      //       token = snapshot.data.toString();
      //       print("TOKEN ::::::::::: ${token}");
      //       if (token != null) {
      //         authorization = authorization + token!;
      //       }

      //       if (snapshot.data == null) {
      //         return Login();
      //       }

      //       String tel =
      //           "{\"id\":2,\"username\":null,\"nom\":\"Mariko\",\"prenom\":\"Oudou\",\"tel\":\"0757351113\",\"password\":null}";

      //       return Home();
      //     })),
    );
  }
}
