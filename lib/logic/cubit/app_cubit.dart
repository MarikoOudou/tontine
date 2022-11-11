import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:tontino/models/MomoService.dart';
import 'package:tontino/models/user.dart';
import 'package:tontino/services/ServiceHttp.dart';
import 'package:tontino/services/service_sse.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  User _userRepositorie = User();
  MomoService _momoService = MomoService();
  ServiceSse _serviceSse = ServiceSse();

  AppCubit() : super(AppInitial()) {
    // getInfoUser();
    // getHistorique();
  }

  rechargement(int montant) {
    emit(AppLoading());

    _momoService.rechargement(montant).then((value) {
      print("VALEUR SERVEUR $value");
      if (value["code"] != 200 && value["code"] != 201) {
        emit(AppError());
      } else if (value["code"] == 200 || value["code"] == 201) {
        emit(AppDepot(message: value));
      }
    });
  }

  eventSse(String? url) {
    // emit(AppLoading());

    _serviceSse.connect(url: url);

    // .then((value) {
    //   print("VALEUR SERVEUR $value");
    //   if (value["code"] != 200 && value["code"] != 201) {
    //     emit(AppError());
    //   } else if (value["code"] == 200 || value["code"] == 201) {
    //     emit(AppDepot(message: value));
    //   }
    // })
    // ;
  }

  login(User user) {
    _userRepositorie = user;
    emit(AppLoading());
    _userRepositorie
        .login(
            telephone: _userRepositorie.tel,
            motDpass: _userRepositorie.password)
        .then((value) {
      if (value["code"] != 200) {
        emit(AppError());
      } else if (value["code"] == 200) {
        emit(AppLogin(data: value));
      }
    });
  }

  deconnexion() {
    emit(AppLoading());
    _userRepositorie.deconnexion().then((value) => {
          if (value == false)
            {emit(AppError())}
          else if (value == true)
            {emit(AppDeconnexion())}
        });
  }

  getInfoUser() async {
    if (await ServiceHttp().getToken() != null) {
      emit(AppLoading());

      print("EMITION-----------------------------------------------------");
      print("EMITION-----------------------------------------------------");
      print("EMITION-----------------------------------------------------");
      _userRepositorie.getUser().then((value) {
        print("info user --------------- $value");

        if (value.code != 200) {
          emit(AppError());
        } else if (value.data == 200) {
          // print("info user --------------- $value");
          emit(AppUserInfo(user: value.data));
          // _serviceSse.connect(url: value);
        }
      });
    }
  }

  getHistorique() async {
    if (await ServiceHttp().getToken() != null) {
      emit(AppLoading());
      _userRepositorie.historique().then((value) => {
            if (value["code"] != 200)
              {emit(AppError())}
            else if (value["code"] == 200)
              {emit(AppHistorique(historique: value))}
          });
    }
  }
}
