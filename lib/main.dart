import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tontino/logic/cubit/app_cubit.dart';
import 'package:tontino/models/Sse.dart';
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

  Stream? myStream;

  @override
  void initState() {
    // TODO: implement initState
    _appRouter = AppRouter();
    // testSse();
    // testterSSE();
    super.initState();

    // getToken();
  }

  testterSSE() {
    SSEClient.subscribeToSSE(
        url:
            'http://18.205.185.206/.well-known/mercure?topic=https%3A%2F%2Fexample.com%2F0707',
        header: {
          // "Cookie": "",
          "Accept": "text/event-stream",
          "Cache-Control": "no-cache",
        }).listen((event) {
      print("EVENT EN COURS  -----------------------  ${event.data}");
      print('Id: ' + event.id!);
      print('Event: ' + event.event!);
      print('Data: ' + event.data!);
    });
  }

  void testSse() {
    this.myStream = Sse.connect(
      uri: Uri.parse('http://18.205.185.206/.well-known/mercure'),
      closeOnError: true,
      withCredentials: false,
    ).stream;

    this.myStream?.listen((event) {
      print('Received:' +
          DateTime.now().millisecondsSinceEpoch.toString() +
          ' : ' +
          event.toString());
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: MaterialApp(
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
      ),
    );
  }
}
