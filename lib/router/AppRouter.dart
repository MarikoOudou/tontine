import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tontino/logic/cubit/app_cubit.dart';
import 'package:tontino/logic/cubit/tontine_cubit.dart';
import 'package:tontino/screens/CreerTontine.dart';
import 'package:tontino/screens/home.dart';
import 'package:tontino/screens/info_tontine_screen.dart';
import 'package:tontino/screens/login.dart';
import 'package:tontino/screens/momo_service/screen_depot.dart';
import 'package:tontino/services/ServiceHttp.dart';

class AppRouter {
  getTel() async {
    return await ServiceHttp().tel;
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (__) => AppCubit(),
                child: FutureBuilder(
                    future: ServiceHttp().getToken(),
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        return Home();
                      }
                      return Login();
                    }))));

      // MaterialPageRoute(builder: (_) => Login());
      // MaterialPageRoute(
      //     builder: (_) => FutureBuilder(
      //         future: Storage.get(StorageKeys.token),
      //         builder: ((context, snapshot) {
      //           print("TOKEN ${snapshot.hasData}");

      //           // if (snapshot.hasData) {
      //           //   return BlocProvider(
      //           //     create: (__) => GuardCubit(),
      //           //     child: TontinePage(),
      //           //   );
      //           // }

      //           return BlocProvider(
      //             create: (__) => SingUpCubit(),
      //             child: OverboardPage(),
      //           );
      //         })));

      case '/depot':
        final args = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (__) => AppCubit(),
                  child: ScreenDepot(
                    tel: args,
                  ),
                ));

      case '/infotontine':
        // final args = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (__) => TontineCubit(),
                  child: InfoTontineScreen(),
                ));

      case '/createtontine':
        // final args = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (__) => TontineCubit(),
                  child: CreerTontine(),
                ));

      case '/home':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (__) => AppCubit(),
                  child: Home(),
                ));

      // MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //           create: (__) => SingUpCubit(),
      //           child: WelcomePage(),
      //         ));

      default:
        return MaterialPageRoute(builder: (_) => Home());
    }
  }
}
